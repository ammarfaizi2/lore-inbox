Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbVKIDXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbVKIDXc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 22:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbVKIDXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 22:23:32 -0500
Received: from thunk.org ([69.25.196.29]:37345 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030415AbVKIDXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 22:23:31 -0500
Date: Tue, 8 Nov 2005 22:23:24 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Al Viro <viro@ftp.linux.org.uk>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compatible fstat()
Message-ID: <20051109032324.GA21282@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Parag Warudkar <kernel-stuff@comcast.net>,
	Al Viro <viro@ftp.linux.org.uk>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0511081040580.3894@chaos.analogic.com> <3587A59B-14FA-4E0F-A598-577E944FCF36@comcast.net> <20051108172244.GR7992@ftp.linux.org.uk> <20051108184957.GF6129@thunk.org> <AD464EBF-4A7C-4079-923D-C060D379C69B@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AD464EBF-4A7C-4079-923D-C060D379C69B@comcast.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 02:12:24PM -0500, Parag Warudkar wrote:
> 
> On Nov 8, 2005, at 1:49 PM, Theodore Ts'o wrote:
> 
> >e2fsprogs falls back to using a
> >binary search using SEEK_SET to find the device size.
> 
> Binary search of what? 

Of the device size; it doubles the guessed size of the disk until
lseek+read returns an error, and then uses binary search to figure out
the size of the disk.  I did this because it works on pretty much any
OS.

>  I tried to read the relevant code in getsize.c  
> but apart from suspecting that the binary search thing might be  
> specific to ext2fs I didn't quite understand what's going on in the  
> code.  (Will it work irrespective of the file system presence on the  
> device?)

Yes, it works irrespective of what's on the disk.  In fact, if the
Linux-specific ioctl's are not available, it's what will be used by
mke2fs to figure out the size of the device.

					- Ted
