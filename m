Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290494AbSBKVJB>; Mon, 11 Feb 2002 16:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290475AbSBKVIv>; Mon, 11 Feb 2002 16:08:51 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:30992 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S290491AbSBKVIf>; Mon, 11 Feb 2002 16:08:35 -0500
Message-ID: <3C6832CC.D9D27F2F@linux-m68k.org>
Date: Mon, 11 Feb 2002 22:08:28 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: thread_info implementation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently wondering how to implement the recent thread_info changes
for m68k, unfortunately I can't find any discussion about it on lkml,
why it was done this way.

1. I more liked the previous byte fields instead of the bitmasks.
bitfield/bitmask instructions are at least 2 bytes longer than a simple
test instruction for m68k. I got this now nicely optimized (see
http://linux-m68k-cvs.apia.dhs.org/c/cvsweb/linux/arch/m68k/kernel/entry.S?rev=1.6&content-type=text/x-cvsweb-markup)
and changing it back to bitmasks would make it worse again.
2. I can understand that we split the task structure from the stack, but
why have thread_info and task_struct to be two different pointers? I'd
prefer two keep one pointer, through everything is accessed, that means
thread_info would be part of task_struct.

bye, Roman
