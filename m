Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263954AbTDJERH (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 00:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263959AbTDJERG (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 00:17:06 -0400
Received: from [203.197.168.150] ([203.197.168.150]:3846 "HELO
	mailscanout256k.tataelxsi.co.in") by vger.kernel.org with SMTP
	id S263954AbTDJERF (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 00:17:05 -0400
Message-ID: <3E94EEB9.29002F86@tataelxsi.co.in>
Date: Thu, 10 Apr 2003 09:40:33 +0530
From: "Prasanta Sadhukhan" <prasanta@tataelxsi.co.in>
X-Mailer: Mozilla 4.6 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: CONFIG_X86_L1_CACHE_SHIFT problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
In linux RH 7.3 and 8.0.
    When we are trying to compile our driver, it is giving the following
error
In file included from /usr/src/linux-2.4/include/linux/prefetch.h:13,
                       from /usr/src/linux-2.4/include/linux/list.h:6,
                        from
/usr/src/linux-2.4/include/linux/module.h:12,
                        from k_compat.h:103,
                       from madgecb.c:31:
/usr/src/linux-2.4/include/asm/processor.h:56 :
`CONFIG_X86_L1_CACHE_SHIFT' undeclared here (not in a function)
/usr/src/linux-2.4/include/asm/processor.h:56 : requested alignmnet is
not a constant
make : ***[madgecb.o] Error 1

We have used our own k_compat.h because with 7.1 pcmcia package,
k_compat.h was not provided.
We tried compiling with pcmcia/k_compat.h also. It is giving the same
problem.

But if we copied /usr/include/asm/processor.h to
/usr/src/linux-2.4/include/asm/processor.h
then the problem is going..

The difference between the header inclusion in
/usr/src/linux-2.4/include/asm/processor.h and
/usr/include/asm/processor.h is in
/usr/src/linux-2.4/include/asm/processor.h there is an extra
<linux.cache.h>
cache.h is including <linux/config.h> and <asm/cache.h>
<linux/config.h> is including <linux/autoconf.h> where
CONFIG_X86_L1_CACHE_SHIFT is defined.then why this problem is coming.

What can be wrong?

--
-----------------------------------------------------------------------
|            __    __          | Tata Elxsi Ltd         |
|           / ,, /| |'-.       | http://www.tataelxsi.com             |
|          .\__/ || |   |      |===================================== |
|       _ /  `._ \|_|_.-'      | Prasanta Sadhukhan                   |
|      | /  \__.`=._) (_       |  mailto:prasanta_sadhukhan@yahoo.com |
|      |/ ._/  |"""""""""|     |  Bangalore                           |
|      |'.  `\ |         |     |  India                               |
|      ;"""/ / |         |     |                                      |
|       ) /_/| |.-------.|     |                                      |
|      '  `-`' "         "     |                                      |
----------------------------------------------------------------------


