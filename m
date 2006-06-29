Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWF2LgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWF2LgJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWF2LgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:36:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64448 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751135AbWF2LgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:36:08 -0400
Date: Thu, 29 Jun 2006 13:11:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Erik Paulson <epaulson@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: file changes without updating mtime
Message-ID: <20060629111037.GA1710@elf.ucw.cz>
References: <20060627181010.GE25040@cobalt.cs.wisc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627181010.GE25040@cobalt.cs.wisc.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2006-06-27 13:10:10, Erik Paulson wrote:
> 
> Hello -
> 
> I'm seeing file content change without a change to the mtime for that
> file, and I'm trying to understand why. 
> 
> The filesystem is ext3, on a local IDE drive. It's a Centos 4.3 machine,
> with kernel version:  2.6.9-34.0.1.ELsmp
> 
> A shell script that in a loop prints the date, stats the file, and then runs 
> 'md5sum' gave me this output:
> 
> Fri Jun 23 04:03:24 CDT 2006
>   File: `/var/lib/rpm/__db.001'
>   Size: 16384           Blocks: 32         IO Block: 4096   regular file
> Device: 303h/771d       Inode: 6291609     Links: 1
> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2006-06-23 04:00:24.669054993 -0500
> Modify: 2006-06-18 21:42:43.685708137 -0500
> Change: 2006-06-18 21:42:43.685708137 -0500
> 37327d016d9741b0d74e4c9bd14d2956  /var/lib/rpm/__db.001
> 
> 
> Fri Jun 23 04:06:24 CDT 2006
>   File: `/var/lib/rpm/__db.001'
>   Size: 16384           Blocks: 32         IO Block: 4096   regular file
> Device: 303h/771d       Inode: 6291609     Links: 1
> Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2006-06-23 04:04:51.898420485 -0500
> Modify: 2006-06-18 21:42:43.685708137 -0500
> Change: 2006-06-18 21:42:43.685708137 -0500
> b2b25d452c94bb376f172e1789e8ab6e  /var/lib/rpm/__db.001
> 
> 
> So something else read the file at 4:04:51, and apparently changed
> it. 

I believe it is / was possible to change file using mmap without
affecting mtime. It might have been fixed in the meantime.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
