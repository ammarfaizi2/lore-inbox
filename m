Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbVKUAAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVKUAAy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 19:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbVKUAAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 19:00:54 -0500
Received: from hoppetossa.avesi.com ([208.239.169.21]:51664 "HELO
	hoppetossa.avesi.com") by vger.kernel.org with SMTP
	id S1750799AbVKUAAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 19:00:53 -0500
Subject: Re: athlon x2 + 2.6.14 + SMP = fast clock
From: Christopher Mulcahy <cmulcahy@avesi.com>
Reply-To: cmulcahy@avesi.com
To: Akira Tsukamoto <akira-t@suna-asobi.com>
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051121030949.80C0.AKIRA-T@suna-asobi.com>
References: <1131498162.21752.102.camel@jones>
	 <1131490766.27168.669.camel@cog.beaverton.ibm.com>
	 <20051121030949.80C0.AKIRA-T@suna-asobi.com>
Content-Type: text/plain
Organization: Avenir Solutions
Date: Sun, 20 Nov 2005 20:48:42 -0500
Message-Id: <1132537722.9627.145.camel@harry>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using arch amd64.

I applied this patch.

http://bugzilla.kernel.org/attachment.cgi?id=6061&action=view

It applies to 2.6.14.2 so long as you remove the static declaration of
'int disable_timer_pin_1'

It appears to have solved my problem.

Chris

On Mon, 2005-11-21 at 03:12 +0900, Akira Tsukamoto wrote:
> On Tue, 08 Nov 2005 14:59:25 -0800
> john stultz <johnstul@us.ibm.com> mentioned:
> > On Tue, 2005-11-08 at 20:02 -0500, Christopher Mulcahy wrote:
> > > On Tue, 2005-11-08 at 13:38 -0800, john stultz wrote:
> > > > On Tue, 2005-11-08 at 15:40 -0500, Christopher Mulcahy wrote:
> > > > > I am running 2.6.14 SMP on an dual-core athlon x2 3800.
> > > > > The system clock runs at roughly twice normal speed.
> > > > 
> > > > Is this a new regression or did the problem occur with 2.6.13 or older
> > > > kernels?
> > > This is a new-machine.
> > > The only other kernel it has seen is the distro-install-kernel ( 2.6.12
> > > uni-processor (ubuntu-5.10) )  ( this kernel does not have a problem,
> > > but it is not SMP )
> > > 
> > > I will try to find time to build 2.4.13 and 2.4.12 SMP kernels with the
> > > ~same config to see if they have the same problem. ( I presume I could
> > > then attach these findings to the original bugzilla report? )
> > 
> > There are a few similar sounding bugs out there:
> > If its an ATI chipset, check out 
> > http://bugzilla.kernel.org/show_bug.cgi?id=3927
> > 
> > If its an nvidia chipset, check out
> > http://bugzilla.kernel.org/show_bug.cgi?id=3341
> 
> 
> My machine's clock runs about 2X from normal speed.
> Could you try my patch which I just posted a hour ago?
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113249769027262&w=2
> 
> The patch will detect whether IO-APCI timer interupt is generated too fast 
> and try to use a legacy i8259A IRQ instead.
> 
> It might help. It also worked on 2.4.31 kernel for me.
> 
> 
> 
> > 
> > 
> > > > Would you mind opening a kernel bug and attaching your dmesg and config?
> > > > 
> > > > http://bugzilla.kernel.org
> > > > 
> > > will do.
> > 
> > Please tag me as the owner when you do.
> > 
> > > > 
> > > > Also try booting w/ "idle=poll" to see if that doesn't clear up the
> > > > issue.
> > > > 
> > > Tried that without results.
> > 
> > Bummer. Your box may not boot, but trying noapic might help as well.
> > 
> > thanks
> > -john
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 

