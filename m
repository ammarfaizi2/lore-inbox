Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbULUGnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbULUGnS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 01:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbULUGnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 01:43:18 -0500
Received: from mail.gmx.de ([213.165.64.20]:48534 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261486AbULUGnN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 01:43:13 -0500
X-Authenticated: #9962044
From: marvin24@gmx.de
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [BUG] 2.6.10-rc3 snd-powermac crash
Date: Tue, 21 Dec 2004 07:43:05 +0100
User-Agent: KMail/1.7
References: <1103389648.5967.7.camel@gaston> <s5hr7lluei7.wl@alsa2.suse.de> <1103561717.5301.2.camel@gaston>
In-Reply-To: <1103561717.5301.2.camel@gaston>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200412210743.06396.marvin24@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Le Montag 20 Dezember 2004 17:55, vous avez écrit :
> I don't have a 100% reprocase yet, it seem to be related to playing with
> an OSS mixer while using an OSS app (like xmms), that is basically
> having 2 things opening the OSS emulation, and one of them closing it,
> or something like that, causing the rate plugin (and maybe more) to be
> tore down, while still in use by the other app (looks like a
> use-after-free).

on my B/W G3 it crashes when doing such stupid things like "dir > /dev/audio". 
I'm using debian/sarge, kernel 2.6.10-rc3, alsa 1.0.7. This also happend in 
past kernel/alsa versions. I don't remember anymore when it started. Sorry, 
but here is the ops.

Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: CE0A40C4 LR: CE0A49D8 SP: C0E2DDC0 REGS: c0e2dd10 TRAP: 0300    Not 
tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: CE0AA438, DSISR: 40000000
TASK = c1266d10[5114] 'dir' THREAD: c0e2c000Last syscall: 4
GPR00: 000007F8 C0E2DDC0 C1266D10 C9CCEC80 C426FAA0 C426F5A0 00000200 00000B03
GPR08: 00000001 CE0A9C40 000007F8 CE0A9C80 C37416A4 1002D000 00000000 100C0000
GPR16: 00000000 C426FAA0 C426F5A0 10020000 10020000 10020000 10020000 10010000
GPR24: 00000000 CB796F00 C426FAA0 CE0A407C C426FAA0 C9CCECF0 C9CCEC80 00000B03
NIP [ce0a40c4] resample_expand+0x48/0x3a8 [snd_pcm_oss]
LR [ce0a49d8] rate_transfer+0x7c/0x98 [snd_pcm_oss]
Call trace:
 [ce0a49d8] rate_transfer+0x7c/0x98 [snd_pcm_oss]
 [ce0a13c4] snd_pcm_plug_write_transfer+0x1cc/0x2a0 [snd_pcm_oss]
 [ce09c520] snd_pcm_oss_write2+0xbc/0x134 [snd_pcm_oss]
 [ce09ef28] snd_pcm_oss_write+0x268/0x2e4 [snd_pcm_oss]
 [c005de88] vfs_write+0x114/0x13c
 [c005df8c] sys_write+0x4c/0x90
 [c0004420] ret_from_syscall+0x0/0x44

Greetings 

Marc
