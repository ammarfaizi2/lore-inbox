Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269191AbTHGSCm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 14:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269321AbTHGSCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 14:02:42 -0400
Received: from maild.telia.com ([194.22.190.101]:1746 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id S269191AbTHGSCl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 14:02:41 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Takashi Iwai <tiwai@suse.de>, Daniel Phillips <phillips@arcor.de>
Subject: Re: SCHED_SOFTRR patch (memory lock?)
Date: Thu, 7 Aug 2003 20:05:06 +0200
User-Agent: KMail/1.5.9
Cc: Steven Newbury <s_j_newbury@yahoo.co.uk>, davidel@xmailserver.org,
       linux-kernel@vger.kernel.org
References: <20030728202750.73149.qmail@web60001.mail.yahoo.com> <200308071659.03894.phillips@arcor.de> <s5hwudpjupm.wl@alsa2.suse.de>
In-Reply-To: <s5hwudpjupm.wl@alsa2.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200308072005.07017.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 August 2003 18.31, Takashi Iwai wrote:
> At Thu, 7 Aug 2003 16:59:03 +0100,
>
> Daniel Phillips wrote:
> > > Under 2.6.0-test1 based kernels I have experienced quite a lote of
> > > drop-outs with XMMS playing mp3's with a moderate load, however, when
> > > run as root (with SCHED_RR) I encountered no drop-outs at all.  When
> > > using SOFTRR under I had very choppy playback when the machine was
> > > under load. It was a constant jittering more than intermittent
> > > drop-outs.
> >
> > According to me, this should not happen, since your cpu usage is well
> > below what is supposed to be the cutoff for the realtime slice.  I've
> > only seen one report like yours, where SOFTRR isn't working as intended. 
> > On the other hand, I've missed a lot of lkml traffice lately, so there
> > could be more.
>
> looking at the source code of xmms and found that xmms OSS output
> plugin behaves differently if the process is SCHED_RR.
> when xmms is started with SCHED_RR, it won't create an (another) audio
> thread.  perhaps this explains also the difference found in some
> cases.
>
> well, i'm not 100% sure about this theory, now needs to practice :)
> please try to turn off the check of SCHED_RR in
> xmms/Output/OSS/audio.c, something like:
>
>         realtime = xmms_check_realtime_priority();
>
> replaced with
>
> 	realtime = 0;

Another possibility - will XMMS lock its memory from swapping when running as 
root? (Or are there any special allocation/IO rule for root?)

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
