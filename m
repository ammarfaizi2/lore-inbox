Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129116AbRBDRAf>; Sun, 4 Feb 2001 12:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129304AbRBDRAZ>; Sun, 4 Feb 2001 12:00:25 -0500
Received: from Cantor.suse.de ([213.95.15.193]:59399 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129116AbRBDRAK>;
	Sun, 4 Feb 2001 12:00:10 -0500
To: "Hen, Shmulik" <shmulik.hen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel memory allocations alignment
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B2711B@hasmsx52.iil.intel.com>
From: Andi Kleen <ak@suse.de>
Date: 04 Feb 2001 18:00:05 +0100
In-Reply-To: "Hen, Shmulik"'s message of "4 Feb 2001 17:18:50 +0100"
Message-ID: <oup66iq8ju2.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hen, Shmulik" <shmulik.hen@intel.com> writes:

> Actually yes. We were warned that on IA64 architecture the system will halt
> when accessing any type of variable via a pointer if the pointer does not
> contain an aligned address matching that type. Until now we were using a

That will need to be fixed with a handler anyways, the network stack requires 
unaligned accesses. If the IA64 port doesn't handle that it it's buggy and 
trivially remotely crashable.

Of course it'll always be much faster to use aligned accesses that do not
need an exception.

> method of receiving a pointer to an array, casting it to a pointer of a
> struct (packed with #pragma pack(1) ) ,and retrieving fields directly from
> it with pointers.
> It seems we cannot do that any more and were wondering what are the
> alternatives.

get_unaligned() or a memcpy to a local variable is the standard method.
get_unaligned is normally slightly faster than relying on an unalignment
exception handler.

> One way we could think of is forget the packing and rearrange the fields in
> the struct in descending order so they all come out aligned, but we didn't
> know for sure if the first one will be aligned too.
> 
> Will that work ?

Yes, it's the best solution.

-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
