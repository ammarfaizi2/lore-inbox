Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTH1ABR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 20:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbTH1ABR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 20:01:17 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:13195 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S262497AbTH1ABN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 20:01:13 -0400
Date: Wed, 27 Aug 2003 19:58:17 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: /proc/net/* read drops data (was: lost socket)
In-Reply-To: <Pine.GSO.4.33.0308271658370.7750-100000@sweetums.bluetronic.net>
Message-ID: <Pine.GSO.4.33.0308271935550.7750-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003, Ricky Beam wrote:
>This smells like a simple "off by one" bug, but I've been too busy to go
>look at the code.

Ah hah!  it's a block size problem... netstat reads 1024 at a time.

Using dd...

[root:pts/5{9}]gir:~/[7:55pm]:dd if=/proc/net/udp bs=1024 | wc
2+1 records in
2+1 records out
     18     216    2304
[root:pts/5{9}]gir:~/[7:56pm]:dd if=/proc/net/udp bs=2048 | wc
1+1 records in
1+1 records out
     19     228    2432
[root:pts/5{9}]gir:~/[7:56pm]:dd if=/proc/net/udp bs=4096 | wc
0+1 records in
0+1 records out
     20     240    2560
[root:pts/5{9}]gir:~/[7:56pm]:dd if=/proc/net/udp bs=8192 | wc
0+1 records in
0+1 records out
     20     240    2560
[root:pts/5{9}]gir:~/[7:56pm]:dd if=/proc/net/udp bs=32768 | wc
0+1 records in
0+1 records out
     20     240    2560
[root:pts/5{9}]gir:~/[7:56pm]:dd if=/proc/net/udp bs=1 | wc
2432+0 records in
2432+0 records out
     19     228    2432

--Ricky


