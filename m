Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129164AbRDWUD2>; Mon, 23 Apr 2001 16:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbRDWUDS>; Mon, 23 Apr 2001 16:03:18 -0400
Received: from dire.bris.ac.uk ([137.222.10.60]:36312 "EHLO dire.bris.ac.uk")
	by vger.kernel.org with ESMTP id <S129164AbRDWUDB>;
	Mon, 23 Apr 2001 16:03:01 -0400
Date: Mon, 23 Apr 2001 20:58:54 +0100 (BST)
From: Matt <madmatt@bits.bris.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: ioctl arg passing
In-Reply-To: <Pine.LNX.4.21.0104231648330.1089-100000@bits.bris.ac.uk>
Message-ID: <Pine.LNX.4.21.0104232051040.7619-100000@bits.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt aka Doofus festures mentioned the following:

| struct instruction_t local;
| __s16 *temp;
| 
| copy_from_user( &local, ( struct instruction_t * ) arg, sizeof( struct instruction_t ) );
| temp = kmalloc( sizeof( __s16 ) * local.rxlen, GFP_KERNEL );
| copy_from_user( temp, arg, sizeof( __s16 ) * local.rxlen );

I meant that last line to be:

copy_from_user( temp, local.rxbuf, sizeof( __s16 ) * local.rxlen );
                      ^^^^^^^^^^^

Which'd clear up any confusion as to why I'd want two copies of the same
argument.

That's the main crux of my query, can I retrieve the value of a pointer
in some struct passed via ioctl? In this case, the struct/chunk of memory
referenced by local.rxbuf, (which is rxlen x 2 bytes big).

Apologies, I'm a muppet.

Matt

PS. Thanks for the help so far, I'd meant to add error checking and what
not, I just kept it out to keep the e-mail smaller.

