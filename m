Return-Path: <linux-kernel-owner+w=401wt.eu-S1030228AbXADVK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbXADVK3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbXADVK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:10:29 -0500
Received: from smtp.osdl.org ([65.172.181.24]:53221 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030228AbXADVK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:10:28 -0500
Date: Thu, 4 Jan 2007 13:10:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted
 bad_inode_ops return values
Message-Id: <20070104131008.1d95cb0c.akpm@osdl.org>
In-Reply-To: <459D6BD1.7050406@redhat.com>
References: <459C4038.6020902@redhat.com>
	<20070103162643.5c479836.akpm@osdl.org>
	<459D3E8E.7000405@redhat.com>
	<20070104102659.8c61d510.akpm@osdl.org>
	<459D4897.4020408@redhat.com>
	<20070104105430.1de994a7.akpm@osdl.org>
	<Pine.LNX.4.64.0701041104021.3661@woody.osdl.org>
	<20070104191451.GW17561@ftp.linux.org.uk>
	<Pine.LNX.4.64.0701041127350.3661@woody.osdl.org>
	<20070104202412.GY17561@ftp.linux.org.uk>
	<20070104130028.39aa44b8.akpm@osdl.org>
	<459D6BD1.7050406@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jan 2007 15:04:17 -0600
Eric Sandeen <sandeen@redhat.com> wrote:

> Andrew Morton wrote:
> > On Thu, 4 Jan 2007 20:24:12 +0000
> > Al Viro <viro@ftp.linux.org.uk> wrote:
> > 
> >> So my main issue with fs/bad_inode.c is not even cast per se; it's that
> >> cast is to void *.
> > 
> > But Eric's latest patch is OK in that regard, isn't it?  It might confuse
> > parsers (in fixable ways), but it is type-correct and has no casts.  (Well,
> > it kinda has an link-time cast).
> 
> Even if it is, I'm starting to wonder if all this tricksiness is really
> worth it for 400 bytes or so.  :)
> 

Ah, but it's a learning opportunity!

btw, couldn't we fix this bug with a simple old

--- a/fs/bad_inode.c~a
+++ a/fs/bad_inode.c
@@ -15,7 +15,7 @@
 #include <linux/smp_lock.h>
 #include <linux/namei.h>
 
-static int return_EIO(void)
+static long return_EIO(void)
 {
 	return -EIO;
 }
_

?
