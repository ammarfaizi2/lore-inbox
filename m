Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265396AbUF2ENq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265396AbUF2ENq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 00:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbUF2ENq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 00:13:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:35533 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265396AbUF2ENn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 00:13:43 -0400
Date: Mon, 28 Jun 2004 21:12:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bryce Harrington <bryce@osdl.org>
Cc: ltp-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Recent changes in LTP test results
Message-Id: <20040628211244.298293e1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.33.0406281833380.13977-100000@osdlab.pdx.osdl.net>
References: <Pine.LNX.4.33.0406281833380.13977-100000@osdlab.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryce Harrington <bryce@osdl.org> wrote:
>
>  Here is a listing of LTP results for the linux kernel.  For the 2.6.x
>  series LTP results have been pretty constant, but they've gotten
>  interesting lately:
> 
>  Patch Name           TestReq#     CPU  PASS  FAIL  WARN  BROK  RunTime
>  ----------------------------------------------------------------------
>  patch-2.4.27-rc2       294321  2-way  7226     6     3     6    69.0
>  linux-2.6.7            294027  2-way  7225     6     3     6    46.0
>  linux-2.6.7            294004  1-way  7225     6     3     6    42.2
>  patch-2.6.7-bk1        294069  2-way  7224     7     3     6    45.9
>  patch-2.6.7-bk2        294081  2-way  7224     7     3     6    45.9
>  patch-2.6.7-bk3        294103  2-way  7224     7     3     6    46.4
>  patch-2.6.7-bk4        294165  2-way  7187     7     3     6    48.7
>  patch-2.6.7-bk5        294181  2-way  7181     7     3     6    45.5
>  patch-2.6.7-bk6        294204  2-way  7224     7     3     6    47.1
>  patch-2.6.7-bk7        294228  2-way  7224     7     3     6    49.0
>  patch-2.6.7-bk8        294304  2-way  7223    10     3     7    47.5
>  patch-2.6.7-bk9        294333  2-way  7224     7     3     6    46.1
>  patch-2.6.7-bk10       294403  2-way  7223    10     3     7    42.9
>  patch-2.6.7-bk11       294423  2-way  7178    46     3     6    47.8
>  2.6.7-mm1              294146  2-way  7185    46     3     6    59.1
>  2.6.7-mm1              294126  1-way  7185    46     3     6    52.9
>  2.6.7-mm2              294271  2-way  7181    47     3     6    44.9
>  2.6.7-mm3              294363  1-way  7185    46     3     6    41.0
>  2.6.7-rc3-mm2          293949  2-way  7223     8     3     6    46.5
> 
>  We usually always see 6-7 fails on the 2.6.x kernels, so the increase is
>  unusual.
> 
>  I've generated some detailed LTP test result reports on a few of the
>  above runs, with specifics about the test runs and failures.  These are
>  available here:
> 
>      http://developer.osdl.org/bryce/ltp/

Seems that the new failures are all related to failing to return -EFAULT
when passing a bad filename address into filesystem syscalls.

Perhaps this was fixed recently - they work OK here.

vmm:/usr/src/ltp-full-20031002# ./testcases/kernel/syscalls/access/access03       
access03    1  PASS  :  access((char *)-1,R_OK) failed as expected with errno 14 (EFAULT) : Bad address
access03    2  PASS  :  access((char *)-1,W_OK) failed as expected with errno 14 (EFAULT) : Bad address
access03    3  PASS  :  access((char*)-1,X_OK) failed as expected with errno 14 (EFAULT) : Bad address
access03    4  PASS  :  access((char*)-1,F_OK) failed as expected with errno 14 (EFAULT) : Bad address
access03    5  PASS  :  access((char*)sbrk(0)+1,R_OK) failed as expected with errno 14 (EFAULT) : Bad address
access03    6  PASS  :  access((char*)sbrk(0)+1,W_OK) failed as expected with errno 14 (EFAULT) : Bad address
access03    7  PASS  :  access(high_address,X_OK) failed as expected with errno 14 (EFAULT) : Bad address
access03    8  PASS  :  access((char*)sbrk(0)+1,F_OK) failed as expected with errno 14 (EFAULT) : Bad address
vmm:/usr/src/ltp-full-20031002# ./testcases/kernel/syscalls/access/access05
access05    1  PASS  :  access() fails, Read Access denied on file, errno:13
access05    2  PASS  :  access() fails, Write Access denied on file, errno:13
access05    3  PASS  :  access() fails, Execute Access denied on file, errno:13
access05    4  PASS  :  access() fails, Access mode invalid, errno:22
access05    5  PASS  :  access() fails, Address beyond address space, errno:14
access05    6  PASS  :  access() fails, Negative address, errno:14
access05    7  PASS  :  access() fails, Pathname is empty, errno:2
access05    8  PASS  :  access() fails, Pathname too long, errno:36
vmm:/usr/src/ltp-full-20031002# ./testcases/kernel/syscalls/chdir/chdir04  
chdir04     1  PASS  :  expected failure - errno = 36 : File name too long
chdir04     2  PASS  :  expected failure - errno = 2 : No such file or directory
chdir04     3  PASS  :  expected failure - errno = 14 : Bad address
