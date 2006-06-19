Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWFSHls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWFSHls (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 03:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWFSHls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 03:41:48 -0400
Received: from science.horizon.com ([192.35.100.1]:55098 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932235AbWFSHls
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 03:41:48 -0400
Date: 19 Jun 2006 03:41:47 -0400
Message-ID: <20060619074147.11641.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org, pasky@suse.cz
Subject: Re: Linux v2.6.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 	[torvalds@g5 linux]$ time git log v2.6.16..v2.6.17 > /dev/null 
>> 	
>> 	real    0m0.484s
>> 	user    0m0.448s
>> 	sys     0m0.036s
>> 
>> ie the logfile generation really is almost free. And yes, that's the 
>> _full_ big log (all 92 _thousand_ lines of it, from the 6113 commits in 
>> the 2.6.16->17 case) being generated in under half a second.

> I assume that this is with hot cache, which is something you shouldn't
> assume for a use like this - you likely aren't in the middle of doing
> stuff with the repository but just want to peek at the changes list.

Okay, a laptop with a cold cache:

$ time git log v2.6.16..v2.6.17 > /dev/null

real    0m2.815s
user    0m1.264s
sys     0m0.044s

And, just for fun, having warmed the cache with that:

$ time git log v2.6.12..v2.6.17 > /dev/null

real    0m2.343s
user    0m1.656s
sys     0m0.068s

All 368519 lines (14 MB) of it.  I have to hand it to Linus,
when you say "git", it gits.


(On a not very related point having to do with git and the kernel,
I usually edit the root Makefile to set INSTALL_PATH to where I want
"make bzlilo" to put it, but this results in my kernels being named
v.2.6.17-dirty.  I can set INSTALL_PATH by hand on the command line,
except when I forget and waste a reboot.  I can't install a symlink,
because the install provess renames the symlink.  Is there an easy way
to semi-permanently change INSTALL_PATH without triggering the -dirty
detection?  Create a GNUmakefile that includes the Makefile?)
