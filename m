Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270986AbTG1G3h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 02:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270995AbTG1G3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 02:29:36 -0400
Received: from xcin.phys.ntu.edu.tw ([140.112.101.186]:22147 "EHLO
	xcin.phys.ntu.edu.tw") by vger.kernel.org with ESMTP
	id S270986AbTG1G3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 02:29:23 -0400
From: Tung-Han Hsieh <thhsieh@xcin.phys.ntu.edu.tw>
Date: Mon, 28 Jul 2003 14:44:28 +0800
To: linux-kernel@vger.kernel.org
Cc: jamagallon@able.es
Subject: malloc problem to allocate very large blocks
Message-ID: <20030728064428.GA32138@xcin>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am developing applications which requires more than 2GB memory.
But I found that in my Linux system the malloc() cannot allocate
more than 2GB memory. Here is the details of my system:

CPU:    Pentium 4 2.53 GHz
RAM:    2 GB
Swap:   512 MB
OS:	Debian-3.0 stable
Kernel: 2.4.20
gcc:	2.95.4 20011002
glibc:  2.2.5-6

In theory, in a 32-bits machine the maximum allocatable memory
is up to 4GB. But in the following very simple testing program:

=====================================================================
#include <stdio.h>
#include <stdlib.h>

main()
{
    size_t l;
    char *s1=NULL, *s2=NULL;

    l = 1024*1024*1024;

    s1 = malloc(l);
    s2 = malloc(l);
    if (! s1) printf("s1 malloc failed\n");
    if (! s2) printf("s2 malloc failed\n");
}
=====================================================================

only the block for s1 can be allocated. Further, if I change the
program to

=====================================================================
#include <stdio.h>
#include <stdlib.h>

main()
{
    size_t l;
    char *s1=NULL;

    l = 2*1024*1024*1024;

    s1 = malloc(l);
    if (! s1) printf("s1 malloc failed\n");
}
=====================================================================

the gcc complier complain to me that "foo.c:9: warning: integer overflow
in expression" during the compilation (I use: "gcc foo.c" to compile it),
and the block for s1 cannot be allocated at all. I am wondering if there
is any way to overcome the 2GB limit.

Thank you very much for your reply in advance.


Best Regards,

T.H.Hsieh
