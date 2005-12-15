Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbVLOBOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbVLOBOx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 20:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbVLOBOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 20:14:53 -0500
Received: from fsmlabs.com ([168.103.115.128]:16801 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S964962AbVLOBOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 20:14:52 -0500
X-ASG-Debug-ID: 1134609290-23931-19-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Wed, 14 Dec 2005 17:20:19 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
cc: Gerd Knorr <kraxel@suse.de>,
       Xen merge mainline list <xen-merge@lists.xensource.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
X-ASG-Orig-Subj: Re: [Xen-merge] Re: [patch] SMP alternatives for i386
Subject: Re: [Xen-merge] Re: [patch] SMP alternatives for i386
In-Reply-To: <865100f9f39bd64c72af67447023b1cd@cl.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0512141706091.1678@montezuma.fsmlabs.com>
References: <439EE742.5040909@suse.de> <Pine.LNX.4.64.0512141129090.1678@montezuma.fsmlabs.com>
 <865100f9f39bd64c72af67447023b1cd@cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6305
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Keir,

On Wed, 14 Dec 2005, Keir Fraser wrote:

> >  	fixup_irqs(map);
> >  	/* It's now safe to remove this processor from the online map */
> >  	cpu_clear(cpu, cpu_online_map);
> > +
> > +	if (1 == num_online_cpus())
> > +		alternatives_smp_switch(0);
> >  	return 0;
> >  }
> > 
> > Is that really safe there? Ideally you want to do the switch when the
> > processor going offline is no longer executing kernel code.
> 
> Perhaps that check belongs at the end of __cpu_die()? That's where it lives in
> xen's smpboot.c.

Yes indeed, end of __cpu_die would be perfect for x86 too as that's where 
CPU_DEAD acknowledge is checked.

