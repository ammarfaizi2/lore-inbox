Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265245AbUFDBHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUFDBHh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 21:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265407AbUFDBHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 21:07:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23803 "EHLO
	orion.mvista.com") by vger.kernel.org with ESMTP id S265245AbUFDBHc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 21:07:32 -0400
Date: Thu, 3 Jun 2004 18:07:28 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: jsun@mvista.com, savl@dev.rtsoft.ru
Subject: input_event size mismatch between 64bit kernel and 32bit userland ...
Message-ID: <20040603180728.F25577@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pavel Kiryukhin discovered this problem while he is developing
64bit MIPS kernel.  With his permission I am forwarding this question
to lkml and we would be interested to know how x86_64 solves this
problem.

Thanks.

Jun

----------------------------------------------------------------------
Hi all,
I stuck in simple situation:
USB mouse (or keyboard). n64 kernel (2.4.20), n32 userland.

Userspace application tries to read "input_event" (16 bytes) from  
"/dev/input/event0" [ read(fd,&key_ev, sizeof(key_ev)) ],
input core driver treats "input_event" as 24 bytes structure. It is due
to different size of  "timeval" (and finally  "long") in n64 kernel and
n32 userland.

Application gets some garbage as mouse events . No solutions like "ioctl
wrappers" applicable in this case.

I don't want to change any arch independent files, but can not find any
acceptable solution. It looks like headers "/usr/include/linux/input.h"
in root file system and "/include/linux/input.h" in kernel should be the
same,
 (All works fine as soon as I declare a new "input_event" structure in
user application that corresponds in size to kernel
structure - but this is not acceptable).

Can anybody advice me what to do with the difference in "input_event"
structure sizes in o32/n32 userland and n64 kernel? Just a general
approach that can be used when  driver's read/write operation treat some
values as 64 bit while user application tries to read/write 32-bit
values (based on the same headers).

Please, don't kick me if solution is simple and obvious.

