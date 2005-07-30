Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262892AbVG3V3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262892AbVG3V3U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 17:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVG3V3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 17:29:20 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:5600 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S262892AbVG3V3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 17:29:17 -0400
Message-ID: <42EBF131.60507@m1k.net>
Date: Sat, 30 Jul 2005 17:29:21 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [HOWTO] set extra_cflags to indicate compilation against -mm kernels
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the addition of topdir-mm.patch into the -mm tree (since 
2.6.13-rc3-mm2), it is now possible for Makefile to detect whether a cvs 
subtree is being built against -mm or not...  -mm kernels now have a .mm 
file in the top level directory.

inside Makefile:

mm-kernel := $(TOPDIR)/.mm
ifneq ($(mm-kernel),)
MM_KERNEL_CFLAGS	:= -DMM_KERNEL=$(shell cat $(mm-kernel) 2> /dev/null)
ifneq ($(MM_KERNEL_CFLAGS),-DMM_KERNEL=)
EXTRA_CFLAGS		+= $(MM_KERNEL_CFLAGS)
endif
endif


inside C files:
#ifdef MM_KERNEL
/* code needed by -mm kernel only */
#else
/* original code for compilation against -linus */
#endif


This should probably be documented somewhere, but I don't know where it 
goes.......

-- 
Michael Krufky

