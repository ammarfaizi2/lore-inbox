Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132533AbRCZSCd>; Mon, 26 Mar 2001 13:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132530AbRCZSCY>; Mon, 26 Mar 2001 13:02:24 -0500
Received: from colorfullife.com ([216.156.138.34]:28937 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132536AbRCZSCM>;
	Mon, 26 Mar 2001 13:02:12 -0500
Message-ID: <009201c0b61e$c83f7550$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <matthew@wil.cx>
Cc: <law@sgi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit block sizes on 32-bit systems
Date: Mon, 26 Mar 2001 20:01:21 +0200
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

>> I vaguely remember a discussion about this a few months back.
>> If I remember, the reasoning was it would unnecessarily slow
>> down smaller systems that would never have block devices in
>> the 4-28T range attached.
>
>4k page size * 2GB = 8TB.

Try it.
If your drive (array) is larger than 512byte*4G (4TB) linux will eat
your data.

drivers/block/ll_rw_blk.c, in submit_bh()
>    bh->b_rsector = bh->b_blocknr * (bh->b_size >> 9);

But it shouldn't cause data corruptions:
It was discussed a few months ago, and iirc LVM refuses to create too
large volumes.

--
    Manfred


