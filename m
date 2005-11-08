Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbVKHRWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbVKHRWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 12:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbVKHRWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 12:22:47 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:16528 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965139AbVKHRWq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 12:22:46 -0500
Date: Tue, 8 Nov 2005 17:22:44 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compatible fstat()
Message-ID: <20051108172244.GR7992@ftp.linux.org.uk>
References: <Pine.LNX.4.61.0511081040580.3894@chaos.analogic.com> <3587A59B-14FA-4E0F-A598-577E944FCF36@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3587A59B-14FA-4E0F-A598-577E944FCF36@comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 12:10:25PM -0500, Parag Warudkar wrote:
> 
> On Nov 8, 2005, at 10:48 AM, linux-os ((Dick Johnson)) wrote:
> 
> >The Linux fstat() doesn't return any information number of blocks,
> >or the byte-length of a physical hard disk.
> 
> I don't think (f)stat returns size and blocks information about a  
> block device on any UNIX platform.
> 
> But I don't know for sure how to get it - perhaps ioctl on the  
> device? BLKGETSIZE?

	fd = open(bdev, O_RDONLY);
	lseek(fd, SEEK_END, 0);
	size = lseek(fd, SEEK_SET, 0);
	close(fd);

i.e. same as for regular files.  Won't be portable, though...
