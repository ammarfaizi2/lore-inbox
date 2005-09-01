Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbVIAPsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbVIAPsv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbVIAPsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:48:51 -0400
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:22283 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S1030216AbVIAPso convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:48:44 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Hotplug_sig] [patch 1/1] Hot plug CPU to support physical add of new processors (i386)
Date: Thu, 1 Sep 2005 10:48:20 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D0F@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Hotplug_sig] [patch 1/1] Hot plug CPU to support physical add of new processors (i386)
Thread-Index: AcWvCox3peJd7y3ISji7UxOaARVtxwAASq1g
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Nathan Lynch" <nathanl@austin.ibm.com>
Cc: <shaohua.li@intel.com>, <akpm@osdl.org>, <zwane@arm.linux.org.uk>,
       <hotplug_sig@lists.osdl.org>, <linux-kernel@vger.kernel.org>,
       <lhcs-devel@lists.sourceforge.net>, <ak@suse.de>
X-OriginalArrivalTime: 01 Sep 2005 15:48:21.0372 (UTC) FILETIME=[946013C0:01C5AF0C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +#ifdef CONFIG_HOTPLUG_CPU
> > +	if (cpu_online(cpu)) {
> > +#else
> >  	if (cpu_online(cpu) || !cpu_present(cpu)) {
> > +#endif
> >  		ret = -EINVAL;
> >  		goto out;
> >  	}
> 
> Why this change?  I think the cpu_present check is needed for 
> ppc64 since it has non-present cpus in sysfs.
> 

The new processor was never brought up, its bit is only set in
cpu_possible_map, but not in present map. 

        ... 
        if (boot_error) {
                /* Try to put things back the way they were before ...
*/
                unmap_cpu_to_logical_apicid(cpu);
                cpu_clear(cpu, cpu_callout_map); /* was set here
(do_boot_cpu()) */
                cpu_clear(cpu, cpu_initialized); /* was set by
cpu_init() */
                cpucount--;
        } else {
                x86_cpu_to_apicid[cpu] = apicid;
                cpu_set(cpu, cpu_present_map);  <=====================
        }
        ...
So if someone tries to boot a CPU up first time during runtime it always
fails this check.
Thanks,
--Natalie
