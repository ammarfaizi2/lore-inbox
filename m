Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQLBAT5>; Fri, 1 Dec 2000 19:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129437AbQLBATr>; Fri, 1 Dec 2000 19:19:47 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:27140 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129231AbQLBATm>; Fri, 1 Dec 2000 19:19:42 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14888.14578.170916.312224@wire.cadcamlab.org>
Date: Fri, 1 Dec 2000 17:49:06 -0600 (CST)
To: "T. Camp" <campt@openmars.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mutliple root devs (take II)
In-Reply-To: <20001201163525.A25464@wire.cadcamlab.org>
	<Pine.LNX.4.21.0012011529070.4856-100000@magic.skylab.org>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Tracy Camp]
> I was unsure if it was okay to be using kmalloc during early stages
> of init/main.c so I decided to follow the example allready set and
> just use a static array - can anyone advise on being able to do this
> dynamically?

Have a static 'char *' somewhere.  In the "root=" callback function,
just set this variable.  Do not parse it until you are ready to
actually mount root, then just parse one dev at a time.  No allocation
needed.

Note that this approach doesn't support the "multiple root=" feature,
which brings us to...

> I guess I can't think of any really good reason why having multiple
> root= is a necissary feature.

Agreed, and there *is* good reason not to support this, since it is
useful to be able to override a root= given in a config file.


> Yeah you would need to patch lilo as well to handle the new syntax
> amongst other things.

Hmm.  LILO shouldn't care, but it does, because it has a 'root='
parameter which it handles specially, by patching the 16-bit device
number into the kernel image at runtime.  Your patch should be fully
functional, though, as long as people just use 'append="root=..."'
instead of simply 'root=...'.  The append= forces LILO not to treat the
root dev specially.  (This tip brought to you by the devfs docs.)

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
