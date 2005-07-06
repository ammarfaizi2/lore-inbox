Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVGFT6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVGFT6J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVGFTzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:55:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1521 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261652AbVGFPbm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 11:31:42 -0400
Message-ID: <42CBF908.7060106@mvista.com>
Date: Wed, 06 Jul 2005 08:30:16 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Build TAGS problem with O=
References: <42C5B967.6040908@mvista.com>
In-Reply-To: <42C5B967.6040908@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleaned up to be a standard "p 1" patch.  Make the comments more concise.


  make O=/dir TAGS

  fails with:

    MAKE   TAGS
  find: security/selinux/include: No such file or directory
  find: include: No such file or directory
  find: include/asm-i386: No such file or directory
  find: include/asm-generic: No such file or directory


  The problem is in this line:
  ifeq ($(KBUILD_OUTPUT),)

KBUILD_OUTPUT is not defined (ever) after make reruns itself.  This line is used 
in the TAGS, tags, and cscope makes.

Here is a fix:

Signed-off-by:  George Anzinger  <george@mvista.com>

--- linux-2.6.12-org/Makefile	2005-07-01 14:37:44.000000000 -0700
+++ linux-2.6.13-rc/Makefile	2005-07-05 19:45:00.588314304 -0700
@@ -1149,7 +1149,7 @@
  #(which is the most common case IMHO) to avoid unneeded clutter in the big
tags file.
  #Adding $(srctree) adds about 20M on i386 to the size of the output file!

-ifeq ($(KBUILD_OUTPUT),)
+ifeq ($(src),$(obj))
  __srctree =
  else
  __srctree = $(srctree)/



-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

