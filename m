Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWF0SKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWF0SKN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWF0SKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:10:13 -0400
Received: from cobalt.cs.wisc.edu ([128.105.121.30]:5571 "EHLO
	cobalt.cs.wisc.edu") by vger.kernel.org with ESMTP id S932510AbWF0SKL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:10:11 -0400
Date: Tue, 27 Jun 2006 13:10:10 -0500
From: Erik Paulson <epaulson@cs.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: file changes without updating mtime
Message-ID: <20060627181010.GE25040@cobalt.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello -

I'm seeing file content change without a change to the mtime for that
file, and I'm trying to understand why. 

The filesystem is ext3, on a local IDE drive. It's a Centos 4.3 machine,
with kernel version:  2.6.9-34.0.1.ELsmp

A shell script that in a loop prints the date, stats the file, and then runs 
'md5sum' gave me this output:

Fri Jun 23 04:03:24 CDT 2006
  File: `/var/lib/rpm/__db.001'
  Size: 16384           Blocks: 32         IO Block: 4096   regular file
Device: 303h/771d       Inode: 6291609     Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2006-06-23 04:00:24.669054993 -0500
Modify: 2006-06-18 21:42:43.685708137 -0500
Change: 2006-06-18 21:42:43.685708137 -0500
37327d016d9741b0d74e4c9bd14d2956  /var/lib/rpm/__db.001


Fri Jun 23 04:06:24 CDT 2006
  File: `/var/lib/rpm/__db.001'
  Size: 16384           Blocks: 32         IO Block: 4096   regular file
Device: 303h/771d       Inode: 6291609     Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2006-06-23 04:04:51.898420485 -0500
Modify: 2006-06-18 21:42:43.685708137 -0500
Change: 2006-06-18 21:42:43.685708137 -0500
b2b25d452c94bb376f172e1789e8ab6e  /var/lib/rpm/__db.001


So something else read the file at 4:04:51, and apparently changed it. 

I know that mtime can be reset, and that may very well be what's going on.
If that's the case, is there any other way I can from the file metadata
that it may have changed, short of reading it and checksumming? There are 
other files that appear to be changing without updating their mtimes - a
number of the kde screensavers, which I think might be the prelinker.

My end goal is to be able to determine when a file has changed without 
reading the contents, because I want to read the contents and compare them
to a previous version. If the content I read is not the same as the content
I read last time, I want to know if it's intentional or if there has been
some file corruption. (I am not worried about malicious users changing files
and hiding their tracks). The way I had hoped to go was to use the mtime
and filesize, but that appears not to be enough.

Thanks!

-Erik

