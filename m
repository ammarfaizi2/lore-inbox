Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbVL2Kvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbVL2Kvv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 05:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVL2Kvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 05:51:51 -0500
Received: from bay23-f21.bay23.hotmail.com ([64.4.22.71]:16717 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932499AbVL2Kvu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 05:51:50 -0500
Message-ID: <BAY23-F21B799C42BAB6D34C0D762F7290@phx.gbl>
X-Originating-IP: [203.122.18.178]
X-Originating-Email: [pretorious_i@hotmail.com]
From: "pretorious ." <pretorious_i@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Redefinition error while compiling LKM
Date: Thu, 29 Dec 2005 16:21:49 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 29 Dec 2005 10:51:50.0179 (UTC) FILETIME=[DF27B730:01C60C65]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!
   I am facing problem in compiling an LKM. It seems Inclusion of 
<sys/stat.h> conflicts with definitions in time.h.


My linux kernal version is 2.4.21-4.EL


#include <linux/kernel.h>
#include <linux/module.h>

#if CONFIG_MODVERSIONS==1
#define MODVERSIONS
#include <linux/modversions.h>
#endif

#ifndef KERNEL_VERSION
#define KERNEL_VERSION(a,b,c) ((a)*65536+(b)*256+(c))
#endif

#include <linux/slab.h>
#include <asm/uaccess.h>
#include <sys/syscall.h>

#include <sys/stat.h>

#define CALLOFF 500
MODULE_LICENSE("GPL");
......
......


Inclusion of header file "sys/stat.h" gives variable redefinition error 
during compilation.

........
In file included from /usr/include/sys/stat.h:37,
                 from venky.c:18:
/usr/include/time.h:119: redefinition of `struct timespec'
In file included from /usr/include/sys/stat.h:105,
                 from venky.c:18:
/usr/include/bits/stat.h:37: redefinition of `struct stat'
......


The Compile string is ::

gcc -O2 -DMODULE -D__KERNEL__ -W -Wall -Wstrict-prototypes 
-Wmissing-prototypes -isystem /lib/modules/`uname -r`/build/include -I../ -c 
-o test.o test.c

Similar redefinition error message are there when trying to include header 
files like sys/types.h

It would be very helpfull if someone would point me in right direction.

Thanks

_________________________________________________________________
Tuff to bluff! Get Abhishek before he gets you! Enter the contest 
http://utv.movie-talkies.com/bluffmaster/contest.html

