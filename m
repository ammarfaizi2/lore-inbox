Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269416AbUIYVta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269416AbUIYVta (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 17:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269417AbUIYVta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 17:49:30 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:1264 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S269416AbUIYVt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 17:49:28 -0400
From: plinius@comcast.net
To: linux-kernel@vger.kernel.org
Subject: security patch for drivers/char/n_tty.c
Date: Sat, 25 Sep 2004 21:49:27 +0000
Message-Id: <092520042149.27494.4155E7E70004FE9800006B6622007456729C9A070207049F@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jul 16 2004)
X-Authenticated-Sender: cGxpbml1c0Bjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Recently while examining the Linux tty code I noticed that my
root password was still in read_buf some time after logging in,
long after it was "read".

I thought it might be a good idea to add a fix to clear out 
characters after they're read. The patch seems to work all right.

This is for kernel 2.6.8.1 and the file is drivers/char/n_tty.c.

Enjoy,
Z Smith

Inline patch:

30a31,33
>  *
>  * 2004/09/20	by Z Smith (plinius@comcast.net): chars now truly erased upon
>  *		reading from read_buf for better security.
380a384
> 			tty->read_buf[head] = 0;
420a425
> 					tty->read_buf[tail] = 0;
1108a1114
> 				tty->read_buf[tty->read_tail] = 0;

-end-

