Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVBFS2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVBFS2z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 13:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVBFS2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 13:28:55 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:658 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261266AbVBFS2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 13:28:52 -0500
Date: Sun, 6 Feb 2005 19:28:45 +0100
From: Olaf Hering <olh@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavenis@latnet.lv
Subject: Re: [PATCH] Bug in tty_io.c after changes between 2.6.9-rc1-bk1 and 2.6.9-rc1-bk2
Message-ID: <20050206182845.GA24803@suse.de>
References: <200502021844.j12IilJJ029973@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200502021844.j12IilJJ029973@hera.kernel.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Feb 03, Linux Kernel Mailing List wrote:

> ChangeSet 1.1992.2.73, 2005/02/02 08:48:23-08:00, pavenis@latnet.lv
> 
> 	[PATCH] Bug in tty_io.c after changes between 2.6.9-rc1-bk1 and 2.6.9-rc1-bk2
> 	
> 	Fix http://bugzilla.kernel.org/show_bug.cgi?id=3736
> 	
> 	Finally located that a problem seems to be a simple typo.
> 	
> 	Acked-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> 
> 
>  tty_io.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
> --- a/drivers/char/tty_io.c	2005-02-02 10:45:08 -08:00
> +++ b/drivers/char/tty_io.c	2005-02-02 10:45:08 -08:00
> @@ -1156,8 +1156,8 @@
>  	int i = index + driver->name_base;
>  	/* ->name is initialized to "ttyp", but "tty" is expected */
>  	sprintf(p, "%s%c%x",
> -			driver->subtype == PTY_TYPE_SLAVE ? "tty" : driver->name,
> -			ptychar[i >> 4 & 0xf], i & 0xf);
> +		driver->subtype == PTY_TYPE_SLAVE ? "pty" : driver->name,
> +		ptychar[i >> 4 & 0xf], i & 0xf);
>  }

This change looks very bogus, what are you trying to fix here?

if pty_driver->subtype == PTY_TYPE_MASTER, a node ptyXY has to be created.
if pty_driver->subtype == PTY_TYPE_SLAVE, a node ttyXY has to be created.
See Documentation/devices.txt, line 108ff and 183ff

With your change, the ttyXY becomes ptyXY? Why does that fix anything?

Do you have an outdated udev package with bogus udev.rules?
