Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWKGLrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWKGLrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 06:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWKGLrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 06:47:13 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:57784 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932127AbWKGLrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 06:47:11 -0500
Message-ID: <45507232.7010104@garzik.org>
Date: Tue, 07 Nov 2006 06:46:58 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [take21 0/4] kevent: Generic event handling mechanism.
References: <11619654014077@2ka.mipt.ru> <45506D51.30604@garzik.org>
In-Reply-To: <45506D51.30604@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At an aside...  This may be useful.  Or not.

Al Viro had an interesting idea about kernel<->userspace data passing 
interfaces.  He had suggested creating a task-specific filesystem 
derived from ramfs.  Through the normal VFS/VM codepaths, the user can 
easily create [subject to resource/priv checks] a buffer that is locked 
into the pagecache.  Using mmap, read, write, whatever they prefer. 
Derive from tmpfs, and the buffers are swappable.

Then it would be a simple matter to associate a file stored in 
"keventfs" with a ring buffer guaranteed to be pagecache-friendly.

Heck, that might make zero-copy easier in some cases, too.  And using a 
filesystem would mean that you could do all this without adding 
syscalls, by using special (poll-able!) files in the filesystem for 
control and notification purposes.

	Jeff



