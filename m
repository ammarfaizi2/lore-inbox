Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131904AbQLIVru>; Sat, 9 Dec 2000 16:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131931AbQLIVrb>; Sat, 9 Dec 2000 16:47:31 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:55817 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S131904AbQLIVrT>; Sat, 9 Dec 2000 16:47:19 -0500
Date: Sat, 9 Dec 2000 21:16:51 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
To: David Miller <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: skbuff.c BUG() pedantry
Message-ID: <Pine.LNX.4.10.10012092113440.32548-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that the BUG() at skbuff.c:175 (2.4.0test12pre7)
kills the machine dead; BUG() isn't (or doesn't appear to
be) interrupt safe:

alloc_skb called nonatomically from interrupt c0194b81
kernel BUG at skbuff.c:175!
invalid operand: 0000
[..]
Code: 0f 0b 83 c4 0c 89 f6 83 e7 fe be 20 c5 24 c0 83 3d 28 c5 24
Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In interrupt handler - not syncing


I guess it should probably be removed (or replace with a
call to something which doesn't try to kill the attached
process.

Matthew.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
