Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265329AbUAYWnZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 17:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265340AbUAYWnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 17:43:25 -0500
Received: from mail.medianet-world.de ([213.157.0.167]:33218 "HELO
	mail.medianet-world.de") by vger.kernel.org with SMTP
	id S265329AbUAYWnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 17:43:22 -0500
Mime-Version: 1.0 (Apple Message framework v609)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DF6611C8-4F87-11D8-B999-000393DC9DA0@freakmail.de>
Content-Transfer-Encoding: 7bit
From: =?ISO-8859-1?Q?Marius_M=FCller?= <m.mueller@freakmail.de>
Subject: 2.4.24 from kernel.org
Date: Sun, 25 Jan 2004 23:43:19 +0100
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.609)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I just tried to compile linux-2.4.24.tar.bz2 from 
http://www.kernel.org/pub/linux/kernel/v2.4/
The date of the archive I downloaded was 05-Jan-2004 5:54. After 
configuring the options for compiling I started the process by "make 
dep" and then "make bzImage". After a few minutes I got the following 
error message:

ipt_ECN.c:16: linux/netfilter_ipv4/ipt_ECN.h: No such file or directory
ipt_ECN.c:26: warning: `struct ipt_ECN_info' declared inside parameter 
list
ipt_ECN.c:26: warning: its scope is only this definition or 
declaration, which is probably not what you want.
(...)
ipt_ECN.c:156: dereferencing pointer to incomplete type
ipt_ECN.c:156: `IPT_ECN_OP_SET_ECE' undeclared (first use in this 
function)
ipt_ECN.c:156: `IPT_ECN_OP_SET_CWR' undeclared (first use in this 
function)
make[3]: *** [ipt_ECN.o] Error 1
make[3]: Leaving directory `/WorX/linux-2.4.24/net/ipv4/netfilter'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/WorX/linux-2.4.24/net/ipv4/netfilter'
make[1]: *** [_subdir_ipv4/netfilter] Error 2
make[1]: Leaving directory `/WorX/linux-2.4.24/net'
make: *** [_dir_net] Error 2

I then discovered that the file linux/netfilter_ipv4/ipt_ECN.h that 
could not be found and caused the following errors really doesn't exist 
but there is a file ipt_ECN.1.h in linux/netfilter_ipv4/. I searched 
for more of the .1.h files and found the following:

.//include/linux/netfilter_ipv4/ipt_DSCP.1.h
.//include/linux/netfilter_ipv4/ipt_ECN.1.h
.//include/linux/netfilter_ipv4/ipt_mark.1.h
.//include/linux/netfilter_ipv4/ipt_tcpmss.1.h
.//include/linux/netfilter_ipv4/ipt_tos.1.h
.//include/linux/netfilter_ipv6/ip6t_mark.1.h
.//net/ipv4/netfilter/ipt_DSCP.1.c
.//net/ipv4/netfilter/ipt_ecn.1.c
.//net/ipv4/netfilter/ipt_mark.1.c
.//net/ipv4/netfilter/ipt_tcpmss.1.c
.//net/ipv4/netfilter/ipt_tos.1.c
.//net/ipv6/netfilter/ip6t_mark.1.c

I searched contents of the sources with grep for any occurrences of the 
above header-files but the only occurrences found were for the exact 
same files but without the .1.h but with .h only. I renamed all the 
above files from .1.h to .h and finally succeeded in compiling without 
any problems.
I don't know if get something very wrong here but it looked like some 
sort wrong file names for me.
Hopefully I haven't wasted your time with "fake" problems.

Marius

-- 

- powered by Mac OS X - sends other UNIX boxes to /dev/null -

