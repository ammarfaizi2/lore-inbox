Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318519AbSGaWsd>; Wed, 31 Jul 2002 18:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318520AbSGaWsd>; Wed, 31 Jul 2002 18:48:33 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:33277 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318519AbSGaWsb>; Wed, 31 Jul 2002 18:48:31 -0400
Subject: Re: [PATCH] 2.5.29: some compilation fixes for irq frenzy [OSS +
	i8x0 audio]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andy Pfiffer <andyp@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1028152202.964.84.camel@andyp>
References: <1028062608.964.6.camel@andyp> 
	<1028067951.8510.44.camel@irongate.swansea.linux.org.uk> 
	<1028063953.964.13.camel@andyp> 
	<1028069255.8510.46.camel@irongate.swansea.linux.org.uk> 
	<1028152202.964.84.camel@andyp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 01:08:36 +0100
Message-Id: <1028160516.13008.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-31 at 22:50, Andy Pfiffer wrote: 
> On Tue, 2002-07-30 at 15:47, Alan Cox wrote:
> > On Tue, 2002-07-30 at 22:19, Andy Pfiffer wrote:
> > > As luck would have it, I booted the kernel and played the tunes on a
> > > 2-way P4 Xeon system.  Nothing wedged, but then again, I didn't try to
> > > break it.
> > > 
> > > So, what did I break?
> > 
> > SMP support I think. A lot of the save_flags/cli stuff you changed looks
> > like it needs to also lock out interrupts on the other processors,
> > otherwise you can get a DMA pointer being updated under you.
> 
> After reading the code in question, it appears to me that the existing
> save_flags/cli constructs are being used to atomically query/modify
> elements of an audio_devs[N] entry.  I can see how it might be possible
> for the patch to break SMP.
> 
> Would a spinlock_t for each "struct audio_operations" be the preferred
> solution over, say, a global spinlock_t for all "struct
> audio_operations?"
> 
> And while I'm asking: I'm a bit perplexed by the "naked" sti()'s in
> audio_write() and audio_read() for the case where CNV_MU_LAW conversion
> is required.  The intent appears to be to force interrupts back on
> during the format conversion.  I don't see any corresponding cli() on
> the return path, however.
> 
> Does anyone have any idea why those sti()'s just seem to be stuck there?
> 
> Regards,
> Andy
> 
> 
