Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbUKBLkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUKBLkZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 06:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbUKBLkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 06:40:18 -0500
Received: from smtp-out-02.utu.fi ([130.232.202.172]:1779 "EHLO
	smtp-out-02.utu.fi") by vger.kernel.org with ESMTP id S261197AbUKBLkI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 06:40:08 -0500
Date: Tue, 02 Nov 2004 13:40:01 +0200
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: XMMS (or some other audio player) 'hang' issues with intel8x0 and
 dmix plugin [u]
In-reply-to: <1099385872.21422.10.camel@leto.cs.pocnet.net>
To: Christophe Saout <christophe@saout.de>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net
Message-id: <200411021340.03164.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <1099284142.11924.17.camel@nosferatu.lan>
 <1099385872.21422.10.camel@leto.cs.pocnet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 November 2004 10:57, Christophe Saout wrote:

> I've tracked this down to what seems to be a bug in the libalsa dmix
> code with mmap emulation. If the sound output was stopped for some
> reason (stream paused or underrun) the library will accept more data
> until the buffer is full but never restart the output.

Strangely, I've observed these kinds of "Hangs" with bmp and mplayer,
without mmap mode enabled in either. Also using dmix as in the other
reports here. Could of course be some third application using alsa in
mmap mode, I suppose.

Unfortunately, I have no strace to offer right now as the bug is happening
randomly and I haven't been able to find any method by which to reproduce
it.

What's strange is that almost always when it happens, either mplayer or
beep-media-player will have an extra forked process. As bmp is threaded
and I shouldn't see more than one bmp in ps aux on NPTL, this seemed a
bit strange. Strace on the process that looked more recent makes it usually
wake up from deep sleep, and then it promptly vanishes after only a few syscalls.
The strace itself seems to wake it up... After the 'extra' process is gone,
sound output usually resumes, but not always. Other times strace only reveals
the app doing nanosleep's and nothing else, and the only solution is to kill
all apps that might've touched sound.

Another dmix+mplayer issue I have is that mplayer's get_delay for alsa seems
to return bogus values for alsa+dmix case, but I digress...
