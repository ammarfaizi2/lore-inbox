Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLKF3S>; Mon, 11 Dec 2000 00:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129591AbQLKF3H>; Mon, 11 Dec 2000 00:29:07 -0500
Received: from va-ext.webmethods.com ([208.234.160.252]:14680 "EHLO
	localhost.neuron.com") by vger.kernel.org with ESMTP
	id <S129226AbQLKF24>; Mon, 11 Dec 2000 00:28:56 -0500
Date: Mon, 11 Dec 2000 12:00:29 -0500 (EST)
From: <stewart@neuron.com>
To: linux-kernel@vger.kernel.org
Subject: kapm-idled : is this a bug?
Message-ID: <Pine.LNX.4.10.10012111151470.2070-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 I've recently begun testing my laptop on the latest 2.4.0-test12-pre[78]
 kernels. When freshly booted and nothing producing a load on the system,
 top reports a process called 'kapm-idled' consuming between 60% an 85%
 of CPU cycles. If I induce a load on the machine (by recompiling kernel
 modules, for example), this process slowly loses priotity and stops
 consuming cycles. Once the compilation is complete, it climbs back up to
 the top of the stack again. Here are top snapshots taken at about 90
 second intervals:

  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
    3 root      20   0     0    0     0 SW      0 81.7  0.0   1:14 kapm-idled
    3 root      20   0     0    0     0 SW      0 76.8  0.0   1:41 kapm-idled
*   3 root       9   0     0    0     0 SW      0  0.0  0.0   3:09 kapm-idled
    3 root      14   0     0    0     0 SW      0 60.5  0.0   3:39 kapm-idled
    3 root      20   0     0    0     0 SW      0 85.7  0.0   5:15 kapm-idled

* during re-compilation of kernel modules, kapm-idled was de-prioritized
  and took up no CPU cycles. after the compilation completed, the task
  priority increased until it was again consuming hi percentages.

 I've consistently re-produced this on my Dell Latitude CS laptop. I'm
 wondering if this will reduce battery life since the CPU is constantly
 being loaded instead of properly idled.

 Stewart

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
