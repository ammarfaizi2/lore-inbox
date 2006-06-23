Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbWFWM3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbWFWM3D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 08:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWFWM3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 08:29:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11211 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932557AbWFWM3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 08:29:02 -0400
Date: Fri, 23 Jun 2006 08:28:45 -0400
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, davej@codemonkey.org.uk,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [Ubuntu PATCH] cpufreq: fix powernow-k8 load bug
Message-ID: <20060623122845.GC19461@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <randy.dunlap@oracle.com>,
	davej@codemonkey.org.uk, lkml <linux-kernel@vger.kernel.org>,
	akpm <akpm@osdl.org>
References: <4498DA08.1010309@oracle.com> <20060622203855.GD2959@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622203855.GD2959@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 10:38:56PM +0200, Pavel Machek wrote:
 > > --- linux-2617-pv.orig/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
 > > +++ linux-2617-pv/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
 > > @@ -1008,7 +1008,7 @@ static int __cpuinit powernowk8_cpu_init
 > >  		 * an UP version, and is deprecated by AMD.
 > >  		 */
 > >  
 > > -		if ((num_online_cpus() != 1) || (num_possible_cpus() != 1)) {
 > > +		if ((num_online_cpus() != 1)) {
 > >  			printk(KERN_ERR PFX "MP systems not supported by PSB BIOS structure\n");
 > >  			kfree(data);
 > >  			return -ENODEV;
 > > 
 > 
 > Seems wrong to me... what if I boot, then hotplug second cpu?

We only run this code if powernow_k8_cpu_init_acpi() has failed,
which it should never do on an SMP system.

So, you get exactly the same behaviour, as expected.
You can't support >1 CPU with PSB.

The above patch makes sure things continue to work if you run
an SMP kernel on UP hardware.

		Dave

-- 
http://www.codemonkey.org.uk
