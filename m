Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129735AbQK0J0o>; Mon, 27 Nov 2000 04:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129874AbQK0J0e>; Mon, 27 Nov 2000 04:26:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:64938 "EHLO pizda.ninka.net")
        by vger.kernel.org with ESMTP id <S129735AbQK0J0Q>;
        Mon, 27 Nov 2000 04:26:16 -0500
Date: Mon, 27 Nov 2000 00:39:55 -0800
Message-Id: <200011270839.AAA28672@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: Werner.Almesberger@epfl.ch
CC: adam@yggdrasil.com, linux-kernel@vger.kernel.org
In-Reply-To: <20001127094139.H599@almesberger.net> (message from Werner
        Almesberger on Mon, 27 Nov 2000 09:41:39 +0100)
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <200011270556.VAA12506@baldur.yggdrasil.com> <20001127094139.H599@almesberger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date:   Mon, 27 Nov 2000 09:41:39 +0100
   From: Werner Almesberger <Werner.Almesberger@epfl.ch>

   egcs-2.91.66 indeed doesn't seem to make this optimization on i386.
   (Maybe the pointer increment or pointer offset solution would
   actually be slower - didn't check.) But I'm not sure if this is
   also true for other versions/architectures, or other code
   constructs.

There is no guarentee that contiguous data or bss section members
will appear contiguous and in the same order, in the final object.

In fact, a specific optimization done on MIPS and other platforms is
to place all data members under a certain size in a special
".small.data" section.  So for example:

static int a;
static struct foo b;
static int b;

Would not place 'b' at "&a + sizeof(a) + sizeof(b)"

Also I believe linkers are allowed to arbitrarily reorder members in
the data and bss sections.  I could be wrong on this one though.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
