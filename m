Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263334AbVGAVwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263334AbVGAVwT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 17:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbVGAVwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 17:52:15 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:49148 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262377AbVGAVqa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 17:46:30 -0400
Message-ID: <42C5B967.6040908@mvista.com>
Date: Fri, 01 Jul 2005 14:45:11 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Build TAGS problem with O=
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you try:
make O=/usr/src/ver/2.6.13-rc/obj/ -j5 LOCALVERSION=_2.6.13-rc TAGS ARCH=i386

it fails with:
   MAKE   TAGS
find: security/selinux/include: No such file or directory
find: include: No such file or directory
find: include/asm-i386: No such file or directory
find: include/asm-generic: No such file or directory


The problem seems to be this bit of the topdir Makefile:


#We want __srctree to totally vanish out when KBUILD_OUTPUT is not set
#(which is the most common case IMHO) to avoid unneeded clutter in the big tags 
file.
#Adding $(srctree) adds about 20M on i386 to the size of the output file!

ifeq ($(KBUILD_OUTPUT),)
__srctree =
else
__srctree = $(srctree)/
endif

It would appear that the "ifeq ($(KBUILD_OUTPUT),)" is doing the wrong thing.  I 
am not a make expert, but I have had a lot of BAD experience trying to use this 
construct.  Any one up to proposing a fix?

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
