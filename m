Return-Path: <linux-kernel-owner+w=401wt.eu-S965084AbXADWsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbXADWsg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 17:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbXADWsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 17:48:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37790 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965084AbXADWsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 17:48:35 -0500
Message-ID: <459D842C.4060900@redhat.com>
Date: Thu, 04 Jan 2007 16:48:12 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Mitchell Blank Jr <mitch@sfgoth.com>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted bad_inode_ops
 return values
References: <20070104105430.1de994a7.akpm@osdl.org> <Pine.LNX.4.64.0701041104021.3661@woody.osdl.org> <20070104191451.GW17561@ftp.linux.org.uk> <Pine.LNX.4.64.0701041127350.3661@woody.osdl.org> <20070104202412.GY17561@ftp.linux.org.uk> <20070104215206.GZ17561@ftp.linux.org.uk> <20070104223856.GA79126@gaz.sfgoth.com> <Pine.LNX.4.64.0701041428510.3661@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701041428510.3661@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
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
> and so on?

That's more or less what I sent at http://lkml.org/lkml/2007/1/3/244

+static int bad_file_readdir(struct file * filp, void * dirent,
+			filldir_t filldir)
+{
+	return -EIO;
+}

... etc

Thanks,
-Eric
