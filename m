Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbTA1XY2>; Tue, 28 Jan 2003 18:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbTA1XY2>; Tue, 28 Jan 2003 18:24:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:33690 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261868AbTA1XY0>;
	Tue, 28 Jan 2003 18:24:26 -0500
Date: Tue, 28 Jan 2003 15:21:02 -0800 (PST)
Message-Id: <20030128.152102.12708956.davem@redhat.com>
To: benoit-lists@fb12.de
Cc: kuznet@ms2.inr.ac.ru, dada1@cosmosbay.com, cgf@redhat.com, andersg@0x63.nu,
       lkernel2003@tuxers.net, linux-kernel@vger.kernel.org, tobi@tobi.nu
Subject: Re: [TEST FIX] Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x,
 through Cisco PIX
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030128231201.A32048@turing.fb12.de>
References: <20030128201645.A29746@turing.fb12.de>
	<20030128.123413.51821993.davem@redhat.com>
	<20030128231201.A32048@turing.fb12.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Sebastian Benoit <benoit-lists@fb12.de>
   Date: Tue, 28 Jan 2003 23:12:01 +0100

   David S. Miller(davem@redhat.com)@2003.01.28 12:34:13 +0000:
   > Thanks for testing, how about this new patch at the end of this email?
   > Does it make the problem go away?
   
   this does it!
   
Alexey, my current suspect is skb->csum state on retransmit.

BTW, how come tcp_trim_head() can just set skb->ip_summed
blindly to CHECKSUM_HW and not setup skb->csum?  Even if you
can depend upon net/core/dev.c to do the checksum for
you, you still would need to setup skb->csum properly.
