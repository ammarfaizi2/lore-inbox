Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWHTU56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWHTU56 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 16:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWHTU56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 16:57:58 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:25569 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1751440AbWHTU55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 16:57:57 -0400
To: jo@sommrey.de
CC: linux-kernel@vger.kernel.org
In-reply-to: <20060820180505.GA18283@sommrey.de> (message from Joerg Sommrey
	on Sun, 20 Aug 2006 20:05:05 +0200)
Subject: Re: PROBLEM: FUSE unmount breaks serial terminal line
References: <20060820180505.GA18283@sommrey.de>
Message-Id: <E1GEuMZ-0004uq-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 20 Aug 2006 22:57:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> something in FUSE breaks serial devices.  I found this issue 
> using gphotofs, don't know if any other FUSE impementation has similar
> effects.  The problem is: from the moment the FUSE filesystem is unmounted,
> a process that read()s on a serial device /dev/ttyS? gets an EOF
> returncode.  
> 
> Here is the tail of the output from "strace -tt cat /dev/ttyS0" when the
> FUSE fs was unmounted:
> 
> 19:41:46.513143 open("/dev/ttyS0", O_RDONLY|O_LARGEFILE) = 3
> 19:41:46.513373 fstat64(3, {st_mode=S_IFCHR|0660, st_rdev=makedev(4, 64), ...}) = 0
> 19:41:46.513552 read(3, "", 4096)       = 0
> 19:42:49.854367 close(3)                = 0
> 19:42:49.860663 close(1)                = 0
> 19:42:49.860793 exit_group(0)           = ?
> 
> Found this on x86 with kernels 2.6.16 and 2.6.17.
> 
> Any ideas?

Likely a userspace issue.  Can you please attach a strace (strace -f
-p `pidof gphotofs`) to the gphotofs process just before doing the
unmount?

Thanks,
Miklos
