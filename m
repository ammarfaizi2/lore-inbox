Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131275AbRCNCgH>; Tue, 13 Mar 2001 21:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131277AbRCNCf5>; Tue, 13 Mar 2001 21:35:57 -0500
Received: from grace.speakeasy.org ([216.254.0.2]:41995 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S131275AbRCNCfq>; Tue, 13 Mar 2001 21:35:46 -0500
Date: Tue, 13 Mar 2001 21:35:04 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: <linux-kernel@vger.kernel.org>
Subject: KERN_ERR for missing codecs?
Message-ID: <Pine.LNX.4.33.0103132117100.14941-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The following piece of code from drivers/sound/ac97_codec.c would print a
kernel error message:

        if ((audio = codec->codec_read(codec, AC97_RESET)) & 0x8000) {
                printk(KERN_ERR "ac97_codec: %s ac97 codec not present\n",
                       codec->id ? "Secondary" : "Primary");
                return 0;
        }

I believe that the kernel should not worry _so_ much about things that
don't exist on the system. KERN_ERR is normally used for really serious
problem.

Probably this error indicates that the driver of a particular card expects
more codecs than there are. But it's a issue of that driver - some of them
may refuse to load, some of them may print error messages. It depends on
what that driver expects.

I suggest removing that printk - the sound card drivers that care about
codecs already print appropriate messages (maestro3.c, via82cxxx_audio.c).
Some drivers that don't care (trident.c, ymfpci.c) because they are
probing more than one codec.

Or at least that KERN_ERR could be downgraded to KERN_WARNING.

Regards,
Pavel Roskin

