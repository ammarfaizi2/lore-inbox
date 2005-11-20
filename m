Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbVKTRyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVKTRyZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 12:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVKTRyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 12:54:25 -0500
Received: from dns.suna-asobi.com ([210.151.31.146]:20705 "EHLO
	dns.suna-asobi.com") by vger.kernel.org with ESMTP id S1751312AbVKTRyY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 12:54:24 -0500
Date: Mon, 21 Nov 2005 02:54:52 +0900
From: Akira Tsukamoto <akira-t@suna-asobi.com>
To: Chris Largret <largret@gmail.com>, jstipins@umich.edu,
       linux-kernel@vger.kernel.org
Subject: Re: AMD 64 system clock speed
In-Reply-To: <20051119234708.GH25348@bakeyournoodle.com>
References: <1132434746.18950.9.camel@shogun.daga.dyndns.org> <20051119234708.GH25348@bakeyournoodle.com>
Message-Id: <20051121024850.80BD.AKIRA-T@suna-asobi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2005 10:47:08 +1100
Tony Breeds <tony@bakeyournoodle.com> mentioned:
> On Sat, Nov 19, 2005 at 01:12:26PM -0800, Chris Largret wrote:
> > On Fri, 2005-11-18 at 20:01 -0500, jstipins@umich.edu wrote:
> > > Hi there,
> > > 
> > > My earlier question regarding the glibc "make check" nptl/tst-clock2.c
> > > failure turns out to be due to my system clock running 3x normal speed.
> > > 
> > > Evidently, this is a known issue with 2.6.x kernels running on AMD 64
> > > processors.  The "noapic" boot option fixes the clock problem, but disrupts
> > > other things... ethernet does work, etc.  The solution seems to be using
> > > "apci=noirq noapic" as boot options.
> > > 
> > > I am using the 2.6.14.2 kernel, and still need to use those boot parameters.
> > > What is the current state of this bug?
> > 
> > Interestingly, I found out last night that the 2.4.26 kernel can
> > recognize both processors in my X2. Unfortunately, it had the same time
> > synchronization issues as the newer 2.6.12+ kernels that I have been
> > running. It isn't solely related to the new kernel series.
> 
> You could also be seeing the same problem outlined in.
> 	http://marc.theaimsgroup.com/?t=113097284500003&r=2&w=2
> 
> Try booting with: acpi_skip_timer_override instead of the other command
> line parameters.

My machine's clock runs about 2X from normal speed.
Could you try my patch which I just posted a hour ago?
http://marc.theaimsgroup.com/?l=linux-kernel&m=113249769027262&w=2

The patch will detect whether IO-APCI timer interupt is generated too fast 
and try to use a legacy i8259A IRQ instead.

It might help. It also worked on 2.4.31 kernel for me.


> 
> Yours Tony
> 
>    linux.conf.au       http://linux.conf.au/ || http://lca2006.linux.org.au/
>    Jan 23-28 2006      The Australian Linux Technical Conference!
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Akira Tsukamoto <akira-t@suna-asobi.com, at541@columbia.edu>


