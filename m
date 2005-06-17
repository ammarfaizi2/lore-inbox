Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVFQRLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVFQRLR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 13:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVFQRLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 13:11:17 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:45017 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262007AbVFQRLG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 13:11:06 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Robert Love <rml@novell.com>
Subject: Re: [patch] inotify.
Date: Fri, 17 Jun 2005 19:07:38 +0200
User-Agent: KMail/1.7.2
Cc: Zach Brown <zab@zabbo.net>, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>
References: <1118855899.3949.21.camel@betsy> <42B1BC4B.3010804@zabbo.net> <1118946334.3949.63.camel@betsy>
In-Reply-To: <1118946334.3949.63.camel@betsy>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200506171907.39940.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dunnersdag 16 Juni 2005 20:25, Robert Love wrote:
> +Q: Why a device node?
> +
> +A: The second biggest problem with dnotify is that the user
> +interface sucks ass.  Signals are a terrible, terrible interface
> +for file notification.  Or for anything, for that matter.  The
> +idea solution, from all perspectives, is a file descriptor based
> +one that allows basic file I/O and poll/select.  Obtaining the
> +fd and managing the watches could of been done either via a
> +device file or a family of new system calls.  We decided to
> +implement a device file because adding three or four new system
> +calls that mirrored open, close, and ioctl seemed silly.  A
> +character device makes sense from user-space and was easy to
> +implement inside of the kernel.

Sorry to bring up a topic that should have been settled a long time ago.

I found that the interface consisting of
 - open a handle
 - add a file descriptor with an event mask to handle
 - remove a file/watch descriptor from handle
 - wait on handle, get events
 - close handle

in inotify is _very_ similar to how epoll is represented to user
space. Is there a good reason that epoll is a set of syscalls while
inotify is a character device, or is one of them simply wrong?

	Arnd <><
