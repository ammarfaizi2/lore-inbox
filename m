Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbUK2M6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbUK2M6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 07:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbUK2M5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 07:57:03 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:54169 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261722AbUK2MzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 07:55:00 -0500
Subject: Re: [RFC] relinquish_fs() syscall
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041129114331.GA33900@gaz.sfgoth.com>
References: <20041129114331.GA33900@gaz.sfgoth.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101729087.20223.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 29 Nov 2004 11:51:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-11-29 at 11:43, Mitchell Blank Jr wrote:
> This has several benefits:
> 
>  * Considerably safer against root users in cage

Pardon. Its equally ineffectual. It might take someone a week longer to
write the exploit but an hour after that its no different.

>    Normal chroot's are trivial for privileged users to break out of -
>    these tasks don't work in the namespace.  You can't create a directory
>    to do the "chroot foo; cd ../../..; chroot ." trick.  You can't
>    create device nodes or mount /proc anywhere (I added an extra check
>    to do_mount() that even prevents a mount on top of '/')

A priviledged user can ioperm/iopl their way out.

>    This is a big deal for privilege separation; currently it's hard to
>    implement except in a daemon that starts its life as root.  Now the
>    same techniques can be used by any process.

That doesn't do name lookup, character set translation, or time (and a
few other things).

>    Imagine, for example, a jpeg decoder that after opening its input and
>    output files called relinquish_fs().  Now if the decoder has a flaw and

Imagine a jpeg decoder using an SELinux policy. 

