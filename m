Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267127AbUBSJgh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 04:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267134AbUBSJgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 04:36:37 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:7921 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S267127AbUBSJge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 04:36:34 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: sys_tux stolen @s390 in 2.6
Date: Thu, 19 Feb 2004 10:30:59 +0100
User-Agent: KMail/1.5.4
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402191030.59229.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete wrote:

> in 2.4, syscall #222 was reserved for tux on s390, but now it is used
> by sys_readahead. What do we do now?

In my copy of tux-3.2.13, the number 242 is used correctly. That number
is the one that is reserved in the official linux sources. Martin
allocated it exactly one year ago when I sent the patch enabling 
s390 in tux to Florian La Roche <laroche@redhat.com>.

If you have a really old version of the tux sources, there might
be the fallback to number 222 still there (which is a pretty dumb
idea, btw).

	Arnd <><

from tux.c:
#if defined(__powerpc__)
#define __NR_tux 225
#elif defined(__x86_64__)
#define __NR_tux 184
#elif defined(__alpha__)
#define __NR_tux 397
#elif defined(__s390__)
#define __NR_tux 242
#elif (defined (__i386__) || defined (__arm__))
#define __NR_tux 222
#else
#warning unsupported architecture, guessing __NR_tux=222 like x86...
#define __NR_tux 222
#endif

