Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136389AbRD2WHr>; Sun, 29 Apr 2001 18:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136390AbRD2WH3>; Sun, 29 Apr 2001 18:07:29 -0400
Received: from colorfullife.com ([216.156.138.34]:13574 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S136389AbRD2WHQ>;
	Sun, 29 Apr 2001 18:07:16 -0400
Message-ID: <001001c0d0f8$bf5ec5e0$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <frank@unternet.org>
Cc: "Alexander Viro" <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Severe trashing in 2.4.4
Date: Mon, 30 Apr 2001 00:06:52 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Apr 29, 2001 at 01:58:52PM -0400, Alexander Viro wrote:
> > Hmm... I'd say that you also have a leak in kmalloc()'ed stuff -
> > something in 1K--2K range. From your logs it looks like the
> > thing never shrinks and grows prettu fast...

You could enable STATS in mm/slab.c, then the number of alloc and free
calls would be printed in /proc/slabinfo.

> Yeah, those as well. I kinda guessed they were related...

Could you check /proc/sys/net/core/hot_list_length and skb_head_pool
(not available in /proc, use gdb --core /proc/kcore)? I doubt that this
causes your problems, but the skb_head code uses a special per-cpu
linked list for even faster allocations.

Which network card do you use? Perhaps a bug in the zero-copy code of
the driver?

--
    Manfred

