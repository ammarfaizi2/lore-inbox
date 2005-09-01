Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbVIAP7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbVIAP7s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbVIAP7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:59:48 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:21944 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030219AbVIAP7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:59:47 -0400
Date: Thu, 1 Sep 2005 10:56:15 -0500
From: Nathan Lynch <nathanl@austin.ibm.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: shaohua.li@intel.com, akpm@osdl.org, zwane@arm.linux.org.uk,
       hotplug_sig@lists.osdl.org, linux-kernel@vger.kernel.org,
       lhcs-devel@lists.sourceforge.net, ak@suse.de
Subject: Re: [Hotplug_sig] [patch 1/1] Hot plug CPU to support physical add of new processors (i386)
Message-ID: <20050901155615.GS23400@localhost.localdomain>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D0F@USRV-EXCH4.na.uis.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04D0F@USRV-EXCH4.na.uis.unisys.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Protasevich, Natalie wrote:
> > > +#ifdef CONFIG_HOTPLUG_CPU
> > > +	if (cpu_online(cpu)) {
> > > +#else
> > >  	if (cpu_online(cpu) || !cpu_present(cpu)) {
> > > +#endif
> > >  		ret = -EINVAL;
> > >  		goto out;
> > >  	}
> > 
> > Why this change?  I think the cpu_present check is needed for 
> > ppc64 since it has non-present cpus in sysfs.
> > 
> 
> The new processor was never brought up, its bit is only set in
> cpu_possible_map, but not in present map. 

If a cpu is physically present and is capable of being onlined it
should be marked in cpu_present_map, please.  This change would break
ppc64; can you rework it?
