Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265605AbUAMTs5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 14:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265611AbUAMTs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 14:48:57 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:25799 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265605AbUAMTsz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 14:48:55 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 13 Jan 2004 11:48:58 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
cc: Takashi Iwai <tiwai@suse.de>, Daniel Phillips <phillips@arcor.de>,
       Steven Newbury <s_j_newbury@yahoo.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SCHED_SOFTRR patch (memory lock?)
In-Reply-To: <200308072005.07017.roger.larsson@skelleftea.mail.telia.com>
Message-ID: <Pine.LNX.4.44.0401131145490.12810-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003, Roger Larsson wrote:

> On Thursday 07 August 2003 18.31, Takashi Iwai wrote:
> > At Thu, 7 Aug 2003 16:59:03 +0100,
> >
> > Daniel Phillips wrote:
> > > > Under 2.6.0-test1 based kernels I have experienced quite a lote of
> > > > drop-outs with XMMS playing mp3's with a moderate load, however, when
> > > > run as root (with SCHED_RR) I encountered no drop-outs at all.  When
> > > > using SOFTRR under I had very choppy playback when the machine was
> > > > under load. It was a constant jittering more than intermittent
> > > > drop-outs.
> > >
> > > According to me, this should not happen, since your cpu usage is well
> > > below what is supposed to be the cutoff for the realtime slice.  I've
> > > only seen one report like yours, where SOFTRR isn't working as intended. 
> > > On the other hand, I've missed a lot of lkml traffice lately, so there
> > > could be more.
> >
> > looking at the source code of xmms and found that xmms OSS output
> > plugin behaves differently if the process is SCHED_RR.
> > when xmms is started with SCHED_RR, it won't create an (another) audio
> > thread.  perhaps this explains also the difference found in some
> > cases.
> >
> > well, i'm not 100% sure about this theory, now needs to practice :)
> > please try to turn off the check of SCHED_RR in
> > xmms/Output/OSS/audio.c, something like:
> >
> >         realtime = xmms_check_realtime_priority();
> >
> > replaced with
> >
> > 	realtime = 0;
> 
> Another possibility - will XMMS lock its memory from swapping when running as 
> root? (Or are there any special allocation/IO rule for root?)

Gee, it was 100F last time I saw this thread :-)
Yes, xmms behave in two completely different ways depending on the fact 
that it is or it is not running RR. With RR it writes directly to the dsp, 
while w/out it creates a thread that handles an output buffer. Then thread 
then does write to the dsp when the buffer has something to be written.




- Davide


