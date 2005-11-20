Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVKTSMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVKTSMG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 13:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVKTSMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 13:12:06 -0500
Received: from dns.suna-asobi.com ([210.151.31.146]:48097 "EHLO
	dns.suna-asobi.com") by vger.kernel.org with ESMTP id S1750722AbVKTSMF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 13:12:05 -0500
Date: Mon, 21 Nov 2005 03:12:34 +0900
From: Akira Tsukamoto <akira-t@suna-asobi.com>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: athlon x2 + 2.6.14 + SMP = fast clock
Cc: Christopher Mulcahy <cmulcahy@avesi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1131490766.27168.669.camel@cog.beaverton.ibm.com>
References: <1131498162.21752.102.camel@jones> <1131490766.27168.669.camel@cog.beaverton.ibm.com>
Message-Id: <20051121030949.80C0.AKIRA-T@suna-asobi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Nov 2005 14:59:25 -0800
john stultz <johnstul@us.ibm.com> mentioned:
> On Tue, 2005-11-08 at 20:02 -0500, Christopher Mulcahy wrote:
> > On Tue, 2005-11-08 at 13:38 -0800, john stultz wrote:
> > > On Tue, 2005-11-08 at 15:40 -0500, Christopher Mulcahy wrote:
> > > > I am running 2.6.14 SMP on an dual-core athlon x2 3800.
> > > > The system clock runs at roughly twice normal speed.
> > > 
> > > Is this a new regression or did the problem occur with 2.6.13 or older
> > > kernels?
> > This is a new-machine.
> > The only other kernel it has seen is the distro-install-kernel ( 2.6.12
> > uni-processor (ubuntu-5.10) )  ( this kernel does not have a problem,
> > but it is not SMP )
> > 
> > I will try to find time to build 2.4.13 and 2.4.12 SMP kernels with the
> > ~same config to see if they have the same problem. ( I presume I could
> > then attach these findings to the original bugzilla report? )
> 
> There are a few similar sounding bugs out there:
> If its an ATI chipset, check out 
> http://bugzilla.kernel.org/show_bug.cgi?id=3927
> 
> If its an nvidia chipset, check out
> http://bugzilla.kernel.org/show_bug.cgi?id=3341


My machine's clock runs about 2X from normal speed.
Could you try my patch which I just posted a hour ago?
http://marc.theaimsgroup.com/?l=linux-kernel&m=113249769027262&w=2

The patch will detect whether IO-APCI timer interupt is generated too fast 
and try to use a legacy i8259A IRQ instead.

It might help. It also worked on 2.4.31 kernel for me.



> 
> 
> > > Would you mind opening a kernel bug and attaching your dmesg and config?
> > > 
> > > http://bugzilla.kernel.org
> > > 
> > will do.
> 
> Please tag me as the owner when you do.
> 
> > > 
> > > Also try booting w/ "idle=poll" to see if that doesn't clear up the
> > > issue.
> > > 
> > Tried that without results.
> 
> Bummer. Your box may not boot, but trying noapic might help as well.
> 
> thanks
> -john
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Akira Tsukamoto <akira-t@suna-asobi.com, at541@columbia.edu>


