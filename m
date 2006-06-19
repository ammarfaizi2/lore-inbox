Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbWFSVwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbWFSVwR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWFSVwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:52:16 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:63693 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S964919AbWFSVwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:52:16 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44971C68.40708@s5r6.in-berlin.de>
Date: Mon, 19 Jun 2006 23:51:36 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>
CC: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 6/8] inode-diet: Move i_cindex from struct inode
 to struct file
References: <20060619152003.830437000@candygram.thunk.org> <20060619153110.075342000@candygram.thunk.org> <20060619193335.GL27946@ftp.linux.org.uk> <20060619193756.GM27946@ftp.linux.org.uk> <20060619205828.GA20362@thunk.org>
In-Reply-To: <20060619205828.GA20362@thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.883) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> On Mon, Jun 19, 2006 at 08:37:56PM +0100, Al Viro wrote:
>>>NAK.  Please, take it to the union into cdev part.
>>
>>Explanation: the whole point of that sucker is to avoid i_rdev use
>>in drivers, switching to i_cdev + i_cindex.  _Especially_ in open().
>>There is a bunch of other drivers that would get cleaner from that,
>>including a lot of tty code.
> 
> The problem is that we already have more stuff in the cdev union
> (list_head's are *big*, especially on Opterons), so moving it there
> doesn't actually save us anything.
> 
> Moving it into struct file however should be good enough clean up the
> character devices drivers that you are concerned about, however.  They
> are passed the struct file pointer in the file_operations->open call.
> So we can clean up the tty code, et. al, by using file->f_cindex just
> as easily.  
> 
> Furthermore, the inode->i_cindex isn't guaranteed to be valid until
> the high-level vfs open code is called anyway, so you might as well
> tell people to reference it from filp->f_cindex in the device driver's
> open() routine.
> 
> Does that make sense?

The patch is obviously proper for usage by any file_operations->open() 
users like the single current one (or two actually, dv1394_open() and 
video1394_open()). I don't know if there are any contrary usages planned 
in other subsystems.
-- 
Stefan Richter
-=====-=-==- -==- =--==
http://arcgraph.de/sr/
