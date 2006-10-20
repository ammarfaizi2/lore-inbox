Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422774AbWJTMnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422774AbWJTMnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 08:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030177AbWJTMnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 08:43:46 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:34133 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S964813AbWJTMnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 08:43:43 -0400
Message-ID: <4538C47B.9060808@tls.msk.ru>
Date: Fri, 20 Oct 2006 16:43:39 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Thunderbird 1.5.0.5 (X11/20060813)
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: bug reading /proc/sys/kernel/*: only first byte read.
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I were debugging a weird problem with busybox, and come across
this chunk of strace output:

open("/proc/sys/kernel/osrelease", O_RDONLY) = 3
read(3, "2", 1)                         = 1
read(3, "", 1)                          = 0
close(3)                                = 0

As you can see, after reading one byte from /proc/sys/kernel/osrelease,
next read() returns 0, which is treated as end-of-file by an application.

Why busybox does this single-byte reads is another question (many
shells does that, in order to be able to stop reading at newline).

But this is definitely a bug in kernel, and should be fixed....

It exists in 2.6.17 and 2.6.18

Thanks.

/mjt
