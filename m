Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbVBOWgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbVBOWgJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 17:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVBOWgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:36:09 -0500
Received: from tiere.net.avaya.com ([198.152.12.100]:53672 "EHLO
	tiere.net.avaya.com") by vger.kernel.org with ESMTP id S261919AbVBOWgH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:36:07 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [2.4 TTY] Lost wake-up of tty->write_wait due to race?
Date: Tue, 15 Feb 2005 15:35:34 -0700
Message-ID: <21FFE0795C0F654FAD783094A9AE1DFC07023513@cof110avexu4.global.avaya.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.4 TTY] Lost wake-up of tty->write_wait due to race?
Thread-Index: AcUTrqqGHVWuX5hMRwSFNoUMOL6iBg==
From: "Davda, Bhavesh P \(Bhavesh\)" <bhavesh@avaya.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the 2.4 kernels, is there a race window when a wake_up() of the
tty->write_wait queue from the underlying tty_driver can be lost in
la-la-land, while a task is sleeping on it from tty_wait_until_sent() ?

I am seeing something similar. I have the "pppd" daemon in the
TASK_INTERRUPTIBLE state stuck in tty_wait_until_sent() [determined from
wchan] as a result of its ioctl(fd, TIOCSETD, [N_TTY]) call while about
to exit.

The debug module is showing that the tty->write_wait queue is empty. As
a result, *nothing* will wake up pppd from its TASK_INTERRUPTIBLE state.

How could that be? Just to show that I've done my homework, attached is
my analysis of the issue.

I've seen references to race conditions in the changing of
line-disciplines in postings by Alan Cox, but none of those references
seems to explain what I am seeing.

Any insight will be greatly appreciated!

Thanks

- Bhavesh

Bhavesh P. Davda | Distinguished Member of Technical Staff | Avaya |
1300 West 120th Avenue | B3-B03 | Westminster, CO 80234 | U.S.A. |
Voice/Fax: 303.538.4438 | bhavesh@avaya.com
