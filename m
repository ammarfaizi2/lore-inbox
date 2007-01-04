Return-Path: <linux-kernel-owner+w=401wt.eu-S1030191AbXADXHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbXADXHL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 18:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbXADXHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 18:07:11 -0500
Received: from smtp.osdl.org ([65.172.181.24]:34621 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030256AbXADXHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 18:07:09 -0500
Date: Thu, 4 Jan 2007 15:06:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mitchell Blank Jr <mitch@sfgoth.com>, Al Viro <viro@ftp.linux.org.uk>,
       Eric Sandeen <sandeen@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted
 bad_inode_ops return values
Message-Id: <20070104150651.5bafddfc.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701041428510.3661@woody.osdl.org>
References: <20070104105430.1de994a7.akpm@osdl.org>
	<Pine.LNX.4.64.0701041104021.3661@woody.osdl.org>
	<20070104191451.GW17561@ftp.linux.org.uk>
	<Pine.LNX.4.64.0701041127350.3661@woody.osdl.org>
	<20070104202412.GY17561@ftp.linux.org.uk>
	<20070104215206.GZ17561@ftp.linux.org.uk>
	<20070104223856.GA79126@gaz.sfgoth.com>
	<Pine.LNX.4.64.0701041428510.3661@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007 14:35:09 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> Anybody want to send in the patch that just generates separate versions 
> for
> 
> 	loff_t eio_llseek(struct file *file, loff_t offset, int origin)
> 	{
> 		return -EIO;
> 	}
> 
> 	int eio_readdir(struct file *filp, void *dirent, filldir_t filldir)
> 	{
> 		return -EIO;
> 	..
> 

That's what I currently have queued.  It increases bad_inode.o text from 
200-odd bytes to 700-odd :(

<looks at sys_ni_syscall>
