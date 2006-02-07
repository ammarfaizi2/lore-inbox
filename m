Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbWBGMe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWBGMe5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 07:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbWBGMe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 07:34:57 -0500
Received: from mail.suse.de ([195.135.220.2]:55007 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965061AbWBGMe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 07:34:56 -0500
Date: Tue, 7 Feb 2006 13:34:50 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Fulghum <paulkf@microgate.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new tty buffering locking fix
Message-ID: <20060207123450.GA854@suse.de>
References: <200602032312.k13NCbWb012991@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200602032312.k13NCbWb012991@hera.kernel.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Feb 03, Linux Kernel Mailing List wrote:

> [PATCH] new tty buffering locking fix
> 
> Change locking in the new tty buffering facility from using tty->read_lock,
> which is currently ignored by drivers and thus ineffective.  New locking
> uses a new tty buffering specific lock enforced centrally in the tty
> buffering code.
> 
> Two drivers (esp and cyclades) are updated to use the tty buffering
> functions instead of accessing tty buffering internals directly.  This is
> required for the new locking to work.
> 
> Minor checks for NULL buffers added to
> tty_prepare_flip_string/tty_prepare_flip_string_flags
> 
> Signed-off-by: Paul Fulghum <paulkf@microgate.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
>  drivers/char/cyclades.c  |    6 +--
>  drivers/char/esp.c       |    4 +-
>  drivers/char/tty_io.c    |   77 ++++++++++++++++++++++++++++++-----------------
>  include/linux/kbd_kern.h |    5 +++
>  include/linux/tty.h      |    2 +
>  include/linux/tty_flip.h |    7 +++-
>  6 files changed, 68 insertions(+), 33 deletions(-)

This patch breaks the hvc console, no input is accepted, even with
init=/bin/sash? Any idea what this driver needs to do now?
I wonder if it worked ok on -mm.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
