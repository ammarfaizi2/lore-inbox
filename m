Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267141AbTAKUeg>; Sat, 11 Jan 2003 15:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267143AbTAKUeg>; Sat, 11 Jan 2003 15:34:36 -0500
Received: from mail.cs.umn.edu ([128.101.34.202]:47358 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id <S267141AbTAKUeg>;
	Sat, 11 Jan 2003 15:34:36 -0500
To: rct@gherkin.frus.com (Bob_Tracy(0000))
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.55+: soundcore: Unknown symbol errno
From: Raja R Harinath <harinath@cs.umn.edu>
Date: Sat, 11 Jan 2003 14:43:22 -0600
In-Reply-To: <20030111151812.3F4DC4EE7@gherkin.frus.com> (rct@gherkin.frus.com's
 message of "Sat, 11 Jan 2003 09:18:12 -0600 (CST)")
Message-ID: <d9iswvzac5.fsf@bose.cs.umn.edu>
User-Agent: Gnus/5.090011 (Oort Gnus v0.11) Emacs/21.3.50
 (i686-pc-linux-gnu)
References: <20030111151812.3F4DC4EE7@gherkin.frus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

rct@gherkin.frus.com (Bob_Tracy(0000)) writes:

> I'm getting the subject error message with ALSA for both 2.5.55 and
> 2.5.56.  The culprit appears to be the very last patch in the 2.5.55
> patch set, which deletes "static int errno;" from
> linux/sound/sound_firmware.c.  The undefined reference to errno is
> from the include of <linux/unistd.h>.

Try compiling soundcore in-kernel (everything else can be modular).

The "problem" appears to be that 'errno' in lib/errno.c is not
EXPORT_SYMBOLed.  The "static int errno;" in sound_firmware.c was most
definitely a bug, especially since it conflicts with the "extern int
errno;" in linux/unistd.h.

- Hari
-- 
Raja R Harinath ------------------------------ harinath@cs.umn.edu
