Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbTARCkn>; Fri, 17 Jan 2003 21:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbTARCkn>; Fri, 17 Jan 2003 21:40:43 -0500
Received: from mail.cs.umn.edu ([128.101.35.202]:59613 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id <S261857AbTARCkm>;
	Fri, 17 Jan 2003 21:40:42 -0500
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: alsa-devel@alsa-project.org, perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: Patch?: linux-2.5.59/sound/soundcore.c referenced non-existant
 errno variable
From: Raja R Harinath <harinath@cs.umn.edu>
Date: Fri, 17 Jan 2003 20:49:36 -0600
In-Reply-To: <20030117155717.A6250@baldur.yggdrasil.com> ("Adam J.
 Richter"'s message of "Fri, 17 Jan 2003 15:57:17 -0800")
Message-ID: <d9n0lz18an.fsf@bose.cs.umn.edu>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.3.50
 (i686-pc-linux-gnu)
References: <20030117155717.A6250@baldur.yggdrasil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Adam J. Richter" <adam@yggdrasil.com> writes:

> 	linux-2.5.59/sound/sound_firmware.c attempts to use the
> user level system call interface from the kernel, which I understand
> works on i386 and perhaps all architectures, but requires a variable
> named "errno." 

Which is provided in-kernel (not for modules) by 'lib/errno.c'.

> (Actually, it mixed things like close() and sys_close(), but that's
> beside the point.)

Those are provided by <linux/unistd.h>, with __KERNEL_SYSCALLS__
defined.

> 	I could just declare a "static int errno;" in the file,

That was originally there, but removed in 2.5.57 IIRC.
<linux/unistd.h> has 'extern int errno;' -- so 'static int errno;'
would be a bug.

- Hari
-- 
Raja R Harinath ------------------------------ harinath@cs.umn.edu
