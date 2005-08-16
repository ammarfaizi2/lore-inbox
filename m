Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965209AbVHPNUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbVHPNUG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 09:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbVHPNUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 09:20:06 -0400
Received: from matou.sibbald.ch ([194.158.240.20]:38445 "EHLO
	matou.sibbald.com") by vger.kernel.org with ESMTP id S965209AbVHPNUF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 09:20:05 -0400
From: Kern Sibbald <kern@sibbald.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: blocking read on socket repeatedly returns EAGAIN
Date: Tue, 16 Aug 2005 15:19:39 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508161519.39719.kern@sibbald.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A read() on a TCP/IP socket, which should block returns -1 with errno=EAGAIN

Unless I am mistaken, the read() should block as the socket is active with no 
problems.  The only "unusual" items are that I have set the network buffer 
size to 32K (32 * 1024), IPTOS_THROUGHPUT, and keepalive.  In addition, I put 
a lot of data into the write side of the socket, then do the read().  The 
other end of the socket is perfectly alive, but does not read() the data I 
have written, nor does it write() anything.  When my read() is issued, I 
expect it to block, but it immediately returns with -1 and errno set to 
EAGAIN.  If the read() is re-issued, a CPU intensive loop results as long as 
the other end does not read() the data written to the socket.  This is a 
multi-threaded program, but the other threads are all blocked on something.

Kernel: Fedora FC4
Linux version 2.6.12-1.1398_FC4smp (bhcompile@tweety.build.redhat.com) (gcc 
version 4.0.0 20050519 (Red Hat 4.0.0-8)) #1 SMP Fri Jul 15 01:30:13 EDT 2005

This problem occurs in my network backup program, Bacula, so it would be a 
fair amount of work to send you a program that shows this behavior.

Best regards,

Kern
