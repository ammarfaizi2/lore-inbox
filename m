Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317005AbSHGPCU>; Wed, 7 Aug 2002 11:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317209AbSHGPCU>; Wed, 7 Aug 2002 11:02:20 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:35610 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S317005AbSHGPCT>; Wed, 7 Aug 2002 11:02:19 -0400
Date: Wed, 7 Aug 2002 11:05:54 -0400
From: Doug Ledford <dledford@redhat.com>
To: Thomas Munck Steenholdt <tmus@get2net.dk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: i810 sound broken...
Message-ID: <20020807110554.D10872@redhat.com>
Mail-Followup-To: Thomas Munck Steenholdt <tmus@get2net.dk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.43.0208051546120.8463-100000@cibs9.sns.it> <1028561325.18478.55.camel@irongate.swansea.linux.org.uk> <1028572739.4406.2.camel@frasier>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1028572739.4406.2.camel@frasier>; from tmus@get2net.dk on Mon, Aug 05, 2002 at 08:38:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 08:38:52PM +0200, Thomas Munck Steenholdt wrote:
> On Mon, 2002-08-05 at 17:28, Alan Cox wrote:
> > On Mon, 2002-08-05 at 14:47, venom@sns.it wrote:
> > > Still OSS modules for i810 does not work with 2.5 kernels, actually 2.4
> > > is fine. No time to switch to alsa (and not interested for now too).
> > 
> > OSS for 2.5 is someone elses problem. I have no plan to do any work on
> > the old OSS drivers for the 2.5 tree or even to submit 2.4 updates into
> > 2.5 for it. 
> > 
> 
> So anyway - How should I go about determining the exact problem on my
> box... I've had it all along, and I know for a fact that the hardware is
> OK... Modules are loaded correctly, but it just does not work!

I'll tell you what you can do.  Grab some ICH docs so you have a list of 
the valid regs on the i810 sound chip.  Then, go into i810_audio.c and 
write me up a little hack that, at the end of the chip init sequence, 
whill dump the state of all the regs on the chip.  Make it smart enough to 
know about different regs on different chips (aka, Intel ICH0 and ICH1 
will probably have a slightly different reg setup than the ICH2 and 
later).  Then, load that driver on your machine and get me that register 
dump.  Then, I'll take the patch and apply it here on the i810 machines I 
have that do work and get their register dump.  We'll see then where the 
differences are.  On the i845 based machine I have at work, where the 
sound doesn't work just like you describe, I've isolated the problem down 
to the fact that when we start the DMA engine it *immediately* signals 
that it has already finished the DMA process and has already stopped again 
but it never actually does the DMA.  So, I suspect there is some config 
bit somewhere set wrong and the DMA is not taking place as a result (hell, 
for all I know, the AC97 link for sound output may be off or something 
like that).  Getting a register dump from several busted machines as well 
as from some working machines should enable me to solve the problem 
relatively easily.  I just haven't had the time to write the patch myself 
and do any more work on the thing :-(

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
