Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRBIAgh>; Thu, 8 Feb 2001 19:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129093AbRBIAg1>; Thu, 8 Feb 2001 19:36:27 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:18448 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S129084AbRBIAgQ>; Thu, 8 Feb 2001 19:36:16 -0500
Date: Thu, 8 Feb 2001 16:36:15 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: "David S. Miller" <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: dentry cache order 7 is broken
In-Reply-To: <14978.21605.98365.252519@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33.0102081624510.21439-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

that appears to do it :)

-dean

On Thu, 8 Feb 2001, David S. Miller wrote:

>
> dean gaudet writes:
>  > also, for order > 7, was the real intention to use a shift of
>  > (order*2)&31?
>
> No, the whole thing is buggered.  How stupid, my fault.
> It was the 64-bit platform fascist at work :-)
>
> How does this work for you (against 2.4.x)?
>
> --- fs/dcache.c.~1~	Tue Feb  6 23:00:58 2001
> +++ fs/dcache.c	Thu Feb  8 00:09:10 2001
> @@ -696,7 +696,8 @@
>  static inline struct list_head * d_hash(struct dentry * parent, unsigned long hash)
>  {
>  	hash += (unsigned long) parent / L1_CACHE_BYTES;
> -	hash = hash ^ (hash >> D_HASHBITS) ^ (hash >> D_HASHBITS*2);
> +	hash = hash ^ (hash >> D_HASHBITS) ^
> +		(hash >> (D_HASHBITS+(D_HASHBITS/2)));
>  	return dentry_hashtable + (hash & D_HASHMASK);
>  }
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
