Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272319AbTHOXJs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 19:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272322AbTHOXJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 19:09:48 -0400
Received: from postoffice02.Princeton.EDU ([128.112.130.38]:37109 "EHLO
	Princeton.EDU") by vger.kernel.org with ESMTP id S272319AbTHOXJq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 19:09:46 -0400
Message-ID: <3F3D672D.1AF660B6@cs.princeton.edu>
Date: Fri, 15 Aug 2003 19:05:17 -0400
From: Yaoping Ruan <yruan@cs.princeton.edu>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel hangs up - possible sendfile() epoll() bug?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently we updated a user space web server to use the sendfile() and
epoll() interface, and tried to measure the performance with SpecWeb99
benchmark. As the load increases, e.g a SpecWeb99's target score of 600
connection, the kernel sometimes hangs up without any logging
information, and the only way left is to push the reset button to
reboot.

We also made similar updates to use sendfile() and kevent() on FreeBSD
and achieved a score of 1000 connections. Thus the possibility of
application bug is low (also it is a user space server). Before the
sendfile() and epoll() change, it was also fine but only could get a
SpecWeb99 score of 500.

The kernel we were using was 2.4.21 with the epoll patch applied. Since
the epoll man pages mention the interface is stabilized in 2.5.66, we
also tried 2.5.66 but didn't see anything better. The machine is a PIII
Xeon processor-based Intel server motherboard, with 2 CPU support but
only 1 is used, Maxtor Diamond IDE disk, Promise Ultra DMA 66
controller, and a single Netgear GA621 gigabit ethernet network adapter.

Is this possibly caused by the newly introduced interfaces?



