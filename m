Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132764AbRDIOzS>; Mon, 9 Apr 2001 10:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132765AbRDIOzJ>; Mon, 9 Apr 2001 10:55:09 -0400
Received: from CRUSH.REM.CMU.EDU ([128.2.81.185]:27046 "EHLO crush.hunch.net")
	by vger.kernel.org with ESMTP id <S132764AbRDIOyx>;
	Mon, 9 Apr 2001 10:54:53 -0400
Date: Mon, 9 Apr 2001 09:59:02 -0400 (EDT)
From: John Langford <l_k_account@crush.hunch.net>
To: linux-kernel@vger.kernel.org
Subject: New loopback bug
Message-ID: <Pine.LNX.4.21.0104090943220.23713-100000@crush.hunch.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've encountered a loopback bug on kernel-2.4.3+international_patch.  I
haven't been able to pin down what the bug is exactly, but these are the
conditions under which it manifests:

1. connect file to loopback device
2. build fs on loopback device
3. mount fs and use it
4. read the file
5. lockup, about 1 out 5 times.

The lockup occurs randomly and seems to have random effects.  Sometimes
user-space scheduling is lost and sometimes there is a total lockup.  This
is all I could extract from /var/log/messages in several crashes:

Apr  9 04:04:48 gs176 kernel: kernel BUG at dcache.c:658!
Apr  9 04:04:48 gs176 kernel: invalid operand: 0000
Apr  9 04:04:48 gs176 kernel: CPU:    0

-John

Stats:
Linux version 2.4.3 + patch-int-2.4.3.1
compiler - redhat's hacked 2.96 (I'll try gcc->kgcc next.)
Also appeared with 2.4.2 + patch-2.4.3-pre4 + patch-int-2.4.0.3
compiler egcs-1.1.2

