Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131733AbRDWQKd>; Mon, 23 Apr 2001 12:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131484AbRDWQKY>; Mon, 23 Apr 2001 12:10:24 -0400
Received: from dire.bris.ac.uk ([137.222.10.60]:1187 "EHLO dire.bris.ac.uk")
	by vger.kernel.org with ESMTP id <S131562AbRDWQKQ>;
	Mon, 23 Apr 2001 12:10:16 -0400
Date: Mon, 23 Apr 2001 17:06:48 +0100 (BST)
From: Matt <madmatt@bits.bris.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: ioctl arg passing
Message-ID: <Pine.LNX.4.21.0104231648330.1089-100000@bits.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Righto, first post to the list, here goes:

I'm writing a char device driver for a dsp card that drives a motion
platform. The basic flow is I basically have to reset the card and upload
an executable file to it, and then poke the card to run it. Once this is
done, I can issue instructions to the card/code to pass and return data
from the card about the platform it's controlling.

To pass the instructions I'm using a generic ioctl which passes the data
between user & kernel-space using a struct which is basically like:

struct instruction_t {
	__s16 code;
	__s16 rxlen;
	__s16 *rxbuf;
	__s16 txlen;
	__s16 *txbuf;
};

(rx|tx)len is the length of the extra data that is provided/requested
in/to be in (rx|tx)buf. Got me so far?

Am I allowed to do this across the ioctl interface? In my ioctl
"handler" I'm attempting to do:

--8<--

struct instruction_t local;
__s16 *temp;

copy_from_user( &local, ( struct instruction_t * ) arg, sizeof( struct instruction_t ) );
temp = kmalloc( sizeof( __s16 ) * local.rxlen, GFP_KERNEL );
copy_from_user( temp, arg, sizeof( __s16 ) * local.rxlen );
local.rxbuf = temp;
temp = kmalloc( sizeof( __s16 ) * local.txlen, GFP_KERNEL );
...

--8<--

Is this going to work as expected? Or am I gonna generate oops-a-plenty?

Cheers

Matt

