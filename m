Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWFWNGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWFWNGh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 09:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWFWNGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 09:06:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39648 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964808AbWFWNGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 09:06:36 -0400
Date: Fri, 23 Jun 2006 15:05:16 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Randy Dunlap <randy.dunlap@oracle.com>,
       davej@codemonkey.org.uk, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: Re: [Ubuntu PATCH] cpufreq: fix powernow-k8 load bug
Message-ID: <20060623130516.GC8048@elf.ucw.cz>
References: <4498DA08.1010309@oracle.com> <20060622203855.GD2959@openzaurus.ucw.cz> <20060623122845.GC19461@redhat.com> <20060623124654.GA8048@elf.ucw.cz> <20060623130414.GD19461@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623130414.GD19461@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-06-23 09:04:14, Dave Jones wrote:
> On Fri, Jun 23, 2006 at 02:46:56PM +0200, Pavel Machek wrote:
> 
>  > >  > > --- linux-2617-pv.orig/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
>  > >  > > +++ linux-2617-pv/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
>  > >  > > @@ -1008,7 +1008,7 @@ static int __cpuinit powernowk8_cpu_init
>  > >  > >  		 * an UP version, and is deprecated by AMD.
>  > >  > >  		 */
>  > >  > >  
>  > >  > > -		if ((num_online_cpus() != 1) || (num_possible_cpus() != 1)) {
>  > >  > > +		if ((num_online_cpus() != 1)) {
>  > >  > >  			printk(KERN_ERR PFX "MP systems not supported by PSB BIOS structure\n");
>  > >  > >  			kfree(data);
>  > >  > >  			return -ENODEV;
>  > >  > > 
>  > >  > 
>  > >  > Seems wrong to me... what if I boot, then hotplug second cpu?
>  > > 
>  > > We only run this code if powernow_k8_cpu_init_acpi() has failed,
>  > > which it should never do on an SMP system.
>  > > 
>  > > So, you get exactly the same behaviour, as expected.
>  > > You can't support >1 CPU with PSB.
>  > > 
>  > > The above patch makes sure things continue to work if you run
>  > > an SMP kernel on UP hardware.
>  > 
>  > I'm pretty sure you'll find SMP machine with broken ACPI cpufreq
>  > (therefore cpu_init_acpi() will fail).
> 
> So? It fails now, it'll fail after this patch.
> That's not the situation that this patch is changing.
> 
> If you have >1 CPU, you *must* have a working ACPI BIOS.
> 
>  > he might boot with one cpu then simulate hotplug of second one.
>  > 
>  > 1) user is already doing perverse things at this point
>  > 
>  > and
>  > 
>  > 2) machine BIOS is b0rken
>  > 
>  > ...so... it is only theoretical and probably not worth fixing.
> 
> SMP kernel on UP hardware is not theoretical, and is worth fixing.

Problem _I_ pointed out is theoretical, so the patch is okay and sorry
for the noise.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
