Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbVKHSuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbVKHSuK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbVKHSuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:50:10 -0500
Received: from thunk.org ([69.25.196.29]:43481 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030307AbVKHSuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:50:07 -0500
Date: Tue, 8 Nov 2005 13:49:57 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Parag Warudkar <kernel-stuff@comcast.net>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compatible fstat()
Message-ID: <20051108184957.GF6129@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Al Viro <viro@ftp.linux.org.uk>,
	Parag Warudkar <kernel-stuff@comcast.net>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0511081040580.3894@chaos.analogic.com> <3587A59B-14FA-4E0F-A598-577E944FCF36@comcast.net> <20051108172244.GR7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108172244.GR7992@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 05:22:44PM +0000, Al Viro wrote:
> On Tue, Nov 08, 2005 at 12:10:25PM -0500, Parag Warudkar wrote:
> > 
> > On Nov 8, 2005, at 10:48 AM, linux-os ((Dick Johnson)) wrote:
> > 
> > >The Linux fstat() doesn't return any information number of blocks,
> > >or the byte-length of a physical hard disk.
> > 
> > I don't think (f)stat returns size and blocks information about a  
> > block device on any UNIX platform.
> > 
> > But I don't know for sure how to get it - perhaps ioctl on the  
> > device? BLKGETSIZE?
> 
> 	fd = open(bdev, O_RDONLY);
> 	lseek(fd, SEEK_END, 0);
> 	size = lseek(fd, SEEK_SET, 0);
> 	close(fd);
> 
> i.e. same as for regular files.  Won't be portable, though...

As I recall, this didn't always work; e2fsprogs falls back to using a
binary search using SEEK_SET to find the device size.  Folks who need
to do this should look at lib/ext2fs/getsize.c in the e2fsprogs
sources; it has ioctl's and other procedures for determining block
device size for Linux, *BSD, MacOSX, as well a generalized binary
search algorithm.

						- Ted

