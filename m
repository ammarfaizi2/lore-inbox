Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267246AbTAUWSk>; Tue, 21 Jan 2003 17:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267247AbTAUWSk>; Tue, 21 Jan 2003 17:18:40 -0500
Received: from mail.rpi.edu ([128.113.2.7]:40103 "EHLO mail.rpi.edu")
	by vger.kernel.org with ESMTP id <S267246AbTAUWSj>;
	Tue, 21 Jan 2003 17:18:39 -0500
Date: Tue, 21 Jan 2003 17:27:38 -0500 (EST)
From: Hua Qin <qinhua@networks.ecse.rpi.edu>
To: linux-kernel@vger.kernel.org
Subject: tcp_tw_bucket is broken at "tcp_timewait_kill"
Message-ID: <Pine.GSO.4.10.10301211725240.14931-100000@poisson.ecse.rpi.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

I was running  2.4.18 kernel, after very heavy networking traffic, my
machine was panic.
at
     START: tcp_timewait_kill at c021e08c
  [f0adfe94] tcp_twkill__thr at c021e87e
  [f0adfeac] tasklet_action at c0124644
  [f0adfec8] do_softirq at c0124441
  [f0adfee8] .text.lock.tcp at c020f692
  [f0adff0c] do_generic_file_read at c01345ea
  [f0adff38] inet_setsockopt at c0228063
  [f0adff54] sys_setsockopt at c01e7c44
  [f0adff80] sys_socketcall at c01e8303
  [f0adffc0] system_call at c0108f53

I looked at tcp_tw_death_row:
tcp_tw_death_row = $13 =
 {0xd4b4d380, 0x2, 0xf3089100, 0xd4728a80, 0xe0a51300, 0xd99c2580,
0xdab52a00, 0xeb568280}

You can see the second one "0x2" is not a structure of tcp_tw_bucket.

So my question is how this wrong info could possibly being added into
tcp_tw_death_row. or is this because this memory was not clean somewhere?

Thanks!
Hua




