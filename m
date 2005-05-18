Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbVERQCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVERQCk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVERQCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:02:00 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:7040 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262251AbVERPvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:51:15 -0400
Message-ID: <428B646C.3030501@ammasso.com>
Date: Wed, 18 May 2005 10:51:08 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Christopher Li <lkml@chrisli.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: sparse error: unable to open 'stdarg.h'
References: <428A661C.1030100@ammasso.com> <20050517201148.GA12997@64m.dyndns.org> <428B4C67.5090307@ammasso.com> <20050518123854.GA13452@64m.dyndns.org>
In-Reply-To: <20050518123854.GA13452@64m.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Li wrote:

> That is wired.  Can you try to edit a test.c contain just one line:
> 
> #include <stdarg.h>
> 
> run sparse on that test.c and see if you get any complain or not?

I did "sparse test.c" and got no output whatsoever.  No files were created, either.

> 
> If you still get complain about file not found. Can you run
> "strace -e trace=file ./check test.c" and show me the out put?

I get the same thing:

execve("sparse-bk/check", ["sparse-bk/check", "test.c"], [/* 57 vars */]) = 0
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=74426, ...}) = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
fstat64(3, {st_mode=S_IFREG|0755, st_size=1359489, ...}) = 0
open("test.c", O_RDONLY)                = 3
open("/usr/include/stdarg.h", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/local/include/stdarg.h", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/gcc-lib/i586-suse-linux/3.3.4/include/stdarg.h", O_RDONLY) = 3

There must be something specific about how kbuild calls sparse.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
