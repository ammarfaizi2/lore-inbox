Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312329AbSCYHMX>; Mon, 25 Mar 2002 02:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312328AbSCYHMM>; Mon, 25 Mar 2002 02:12:12 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:52867 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S312325AbSCYHMF>; Mon, 25 Mar 2002 02:12:05 -0500
Date: Mon, 25 Mar 2002 00:12:01 -0700
Message-Id: <200203250712.g2P7C1524455@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bit ops on unsigned long? 
In-Reply-To: <E16pOZP-00043F-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell writes:
> In message <200203250621.g2P6LG023329@vindaloo.ras.ucalgary.ca> you write:
> > > These changed are required because otherwise you try to do set_bit on
> > > something not aligned as a long on all archs.
> > 
> > But of course. I'm not denying that. Naturally the type should be
> > changed. I thought that was obvious so I didn't bother agreeing. But
> > in fact, it already *is* aligned on a long boundary. Better, in
> > fact. It's aligned on a 16 byte boundary. Even though the type was
> > __u32.
> 
> I'm confused:
> 
> @@ -212,7 +212,7 @@
>  struct minor_list
>  {
>      int major;
> -    __u32 bits[8];
> +    unsigned long bits[256 / BITS_PER_LONG];
>      struct minor_list *next;
>  };
> 
> How, exactly, did "bits" end up on a 16-bute boundary before this
> patch?

Oh, I wasn't talking about this part of the code at all. That's
actually broken in other ways as well (see the other thread where I
replied to Carsten Otte).

I'm just talking about the devfs_alloc_unique_number() implementation,
which *also* was using an array of __u32. That's where you cast doubt
upon the memset/memcpy, a few emails ago. Apart from the missing cast
to void *, I assert that devfs_alloc_unique_number() is 100% correct.
The type of the bitfield should be changed, of course, for cleanliness
reasons, but it isn't actually a bug.

Clear now? Or should I just telephone you for a few minutes rather
than go back and forth in a dozen more emails? :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
