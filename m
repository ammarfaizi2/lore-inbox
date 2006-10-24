Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbWJXObq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWJXObq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 10:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbWJXObq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 10:31:46 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:41650 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1030398AbWJXObp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 10:31:45 -0400
Date: Tue, 24 Oct 2006 16:31:44 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17.13 on i386: tg3 related slab corruption
Message-ID: <20061024143144.GB12781@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-BotBait: val@frankvm.com, kuil@frankvm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On three different machine I catched this:

2.6.17.13:
Oct 24 08:26:41 lahti kernel: Slab corruption: start=c2750ef8, len=2048
Oct 24 08:26:41 lahti kernel: Redzone: 0x5a2cf071/0x5a2cf071.
Oct 24 08:26:41 lahti kernel: Last user: [release_mem+232/496](release_mem+0xe8/0x1f0)
Oct 24 08:26:41 lahti kernel: 0b0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b ff ff ff ff
Oct 24 08:26:41 lahti kernel: 0c0: 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Oct 24 08:26:41 lahti kernel: Prev obj: start=c27506ec, len=2048
Oct 24 08:26:41 lahti kernel: Redzone: 0x170fc2a5/0x170fc2a5.
Oct 24 08:26:41 lahti kernel: Last user: [tg3_alloc_rx_skb+123/368](tg3_alloc_rx_skb+0x7b/0x170)
Oct 24 08:26:41 lahti kernel: 000: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
Oct 24 08:26:41 lahti kernel: 010: 5a 5a 00 13 72 ad 5b ba 00 50 56 00 02 d6 08 06
Oct 24 08:26:41 lahti kernel: Next obj: start=c2751704, len=2048
Oct 24 08:26:41 lahti kernel: Redzone: 0x170fc2a5/0x170fc2a5.
Oct 24 08:26:41 lahti kernel: Last user: [tg3_alloc_rx_skb+123/368](tg3_alloc_rx_skb+0x7b/0x170)
Oct 24 08:26:41 lahti kernel: 000: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
Oct 24 08:26:41 lahti kernel: 010: 5a 5a 00 13 72 ad 5b ba 00 0e 0c bc 74 a5 08 00

2.6.17.8:
Oct 24 16:06:20 jaala kernel: Slab corruption: start=e582d0c4, len=2048
Oct 24 16:06:20 jaala kernel: Redzone: 0x5a2cf071/0x5a2cf071.
Oct 24 16:06:20 jaala kernel: Last user: [release_mem+232/496](release_mem+0xe8/0x1f0)
Oct 24 16:06:20 jaala kernel: 0b0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b ff ff ff ff
Oct 24 16:06:20 jaala kernel: 0c0: 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Oct 24 16:06:20 jaala kernel: Prev obj: start=e582c8b8, len=2048
Oct 24 16:06:20 jaala kernel: Redzone: 0x170fc2a5/0x170fc2a5.
Oct 24 16:06:20 jaala kernel: Last user: [tg3_alloc_rx_skb+123/368](tg3_alloc_rx_skb+0x7b/0x170)
Oct 24 16:06:20 jaala kernel: 000: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
Oct 24 16:06:20 jaala kernel: 010: 5a 5a 00 14 22 4c b1 01 00 12 3f 84 84 fe 08 00

2.6.17.13:
Oct  5 18:02:28 espoo kernel: Slab corruption: start=c221cb78, len=2048
Oct  5 18:02:28 espoo kernel: Redzone: 0x5a2cf071/0x5a2cf071.
Oct  5 18:02:28 espoo kernel: Last user: [release_mem+232/496](release_mem+0xe8/0x1f0)
Oct  5 18:02:28 espoo kernel: 0b0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b ff ff ff ff
Oct  5 18:02:28 espoo kernel: 0c0: 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Oct  5 18:02:28 espoo kernel: Prev obj: start=c221c36c, len=2048
Oct  5 18:02:28 espoo kernel: Redzone: 0x170fc2a5/0x170fc2a5.
Oct  5 18:02:28 espoo kernel: Last user: [tg3_alloc_rx_skb+123/368](tg3_alloc_rx_skb+0x7b/0x170)
Oct  5 18:02:28 espoo kernel: 000: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
Oct  5 18:02:28 espoo kernel: 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
Oct  5 18:02:28 espoo kernel: Next obj: start=c221d384, len=2048
Oct  5 18:02:28 espoo kernel: Redzone: 0x170fc2a5/0x170fc2a5.
Oct  5 18:02:28 espoo kernel: Last user: [tg3_alloc_rx_skb+123/368](tg3_alloc_rx_skb+0x7b/0x170)
Oct  5 18:02:28 espoo kernel: 000: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
Oct  5 18:02:28 espoo kernel: 010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a


Since I saw some other discussions regarding TSO: According to ethtool it is off.

-- 
Frank
