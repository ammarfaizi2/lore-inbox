Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135954AbRDTQFM>; Fri, 20 Apr 2001 12:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135955AbRDTQFD>; Fri, 20 Apr 2001 12:05:03 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:48392 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S135954AbRDTQEn>;
	Fri, 20 Apr 2001 12:04:43 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200104201603.UAA00975@ms2.inr.ac.ru>
Subject: Re: CONFIG_PACKET_MMAP help
To: kambo@home.COM
Date: Fri, 20 Apr 2001 20:03:28 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <10336.010418@home.com> from "kambo@home.COM" at Apr 19, 1 04:15:05 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> 1. for tp_frame_size, I dont want to truncate any data on ethernet, I
> need 1514 bytes, is this the best way to do it and not waste space?

To select small snapsize (obtained from later experiments),
to set PACKET_COPY_THRESH to read larger packets via recvmsg().

> 2. what is tp_block_nr for?  I dont understand it, I just set it to 1
> and make tp_block_size big enough for all the frames I need, so its
> just one contiguous space, all I need is about a megabyte I think.

Kernel has problems with allocating large chunks of memory.
If you see problems with allocating large chuns, split them
to less ones.

> while(1) {
>    if (tp->status == 0) poll() for pollin on the socket  /* is there a
>    race here? */

No. poll returns, when new frame appears.


> 4. what does the copy threshold setsockopt tuning accomplish? doesnt it always
> have to copy anyway, to the mmaped area?

see anser to question 1. It has a sense when size of chunk is small enough.
Small packets are copied to ring, large ones (which are truncated) are queued
to socket to be received via recvmsg().

Alexey
