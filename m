Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVERPqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVERPqK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVERPo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:44:58 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:33520 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262234AbVERPnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:43:55 -0400
Date: Wed, 18 May 2005 08:38:54 -0400
From: Christopher Li <lkml@chrisli.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sparse error: unable to open 'stdarg.h'
Message-ID: <20050518123854.GA13452@64m.dyndns.org>
References: <428A661C.1030100@ammasso.com> <20050517201148.GA12997@64m.dyndns.org> <428B4C67.5090307@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428B4C67.5090307@ammasso.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 09:08:39AM -0500, Timur Tabi wrote:
> 
> Nope, that didn't fix it.  I deleted pre-process.h and re-ran "make", and 
> it created a new one:
> 
> #define GCC_INTERNAL_INCLUDE 
> "/usr/lib/gcc-lib/i586-suse-linux/3.3.4/include"
> 
> vic1:~/sparse-bk # ll 
> /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include/stdarg.h
> -rw-r--r--  1 root root 4325 Oct  1  2004 
> /usr/lib/gcc-lib/i586-suse-linux/3.3.4/include/stdarg.h
> 
That is wired.  Can you try to edit a test.c contain just one line:

#include <stdarg.h>

run sparse on that test.c and see if you get any complain or not?

If you still get complain about file not found. Can you run
"strace -e trace=file ./check test.c" and show me the out put?

Chris

PS, here is what I get:

[chrisl@64m sparse-be]$ strace -e trace=file ./check test.h 
execve("./check", ["./check", "test.h"], [/* 26 vars */]) = 0
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=58983, ...}) = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
fstat64(3, {st_mode=S_IFREG|0755, st_size=1539996, ...}) = 0
open("test.h", O_RDONLY)                = 3
open("/usr/include/stdarg.h", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/local/include/stdarg.h", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/gcc-lib/i386-redhat-linux/3.2.2/include/stdarg.h", O_RDONLY) = 3
[chrisl@64m sparse-be]$ 
