Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVKHQPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVKHQPN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVKHQPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:15:12 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:21437 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932384AbVKHQPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:15:11 -0500
Subject: Re: Access other file system's symbols
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: johnpw <johnpw@TwinPeakSoft.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200511072256.jA7MufJ07565@TwinPeakSoft.com>
References: <200511072256.jA7MufJ07565@TwinPeakSoft.com>
Content-Type: text/plain
Date: Tue, 08 Nov 2005 10:15:06 -0600
Message-Id: <1131466506.9383.31.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 14:43 -0800, johnpw wrote:
> Greetings,
> 
> I need to access some ext3 and nfs file system
> symbols from a new file system module we are 
> developing. For example, the nfs_file_inode_operations
> and ext3_dir_inode_operations. What functions 
> or mechanism in the kernel are available for 
> doing that? Any suggestions and advice is 
> appreciated.

First question: Is your new file system going to be licensed under the
GPL?  If not, read no more.  You shouldn't be trying.

I have to wonder why you want to do this.  A file system usually
provides its own inode_operations.  If you are interested in a file
system that sits on top of ext3 and/or nfs, you may be want to look at
FiST: http://www.filesystems.org/

Otherwise, it seems to be a bad idea to use another file system's code.
The inode operations are specific to those file systems, and the
developers won't be concerned about making changes that could break your
file system.

If you really believe the code to be generic enough to be used outside
of ext3 or nfs, the code could be moved to the vfs, and called from the
individual file systems.  See the code in fs/libfs.c for examples.  I
really don't think that the inode_operations for these file systems
would fall into that category though.

> John W.
-- 
David Kleikamp
IBM Linux Technology Center

