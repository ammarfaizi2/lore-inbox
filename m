Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbUBVPXa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 10:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbUBVPXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 10:23:30 -0500
Received: from [213.227.239.137] ([213.227.239.137]:30945 "EHLO
	berloga.shadowland") by vger.kernel.org with ESMTP id S261501AbUBVPXZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 10:23:25 -0500
Subject: buffer overflow in ip_options_echo
From: Alex Lyahkov <shadow@psoft.net>
To: "'lkml'" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1077463393.5404.6.camel@berloga.shadowland>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Sun, 22 Feb 2004 17:23:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All

When i trued to do stress testing my project i found strange bug in high
network activity. 
In test started four ab each with 1000 connections in same time.
after 25-60 minutes testing i found panic in network subsystem.
I patch my kernel with kgdb 1.6 and found that
Program received signal SIGSEGV, Segmentation fault.
0xc0255ad3 in ip_send_reply (sk=0x6e755320, skb=0x3232202c,
arg=0x62654620, len=808464928)
    at ip_output.c:982
982     ip_output.c: No such file or directory.
        in ip_output.c
(gdb) p replyopts.opt.optlen
$8 = 60 '<'
but functions reserved 40 byte for options and it do overflow.

-- 
Alex Lyahkov <shadow@psoft.net>
