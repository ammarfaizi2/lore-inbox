Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319074AbSHMWYE>; Tue, 13 Aug 2002 18:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319075AbSHMWYE>; Tue, 13 Aug 2002 18:24:04 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:26523 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S319074AbSHMWYD>; Tue, 13 Aug 2002 18:24:03 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "David S. Miller" <davem@redhat.com>
Date: Wed, 14 Aug 2002 08:27:46 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15705.34786.933680.708535@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2 NFS OOPS on sparc64
In-Reply-To: message from David S. Miller on Tuesday August 13
References: <Pine.GSO.4.43.0208131916340.16824-100000@romulus.cs.ut.ee>
	<20020813.102737.04335380.davem@redhat.com>
X-Mailer: VM 7.03 under Emacs 21.2.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 13, davem@redhat.com wrote:
>    From: Meelis Roos <mroos@linux.ee>
>    Date: Tue, 13 Aug 2002 19:21:30 +0300 (EEST)
> 
>    2 oopses from stock 2.4.20-pre2 during NFS startup 9mountd etc killed as
>    a result). Looks like a bad use of bitops inside sunrpc. egcs64 compiler
>    from debian.
>    
> Neil, sk_flags in struct svc_sock may not be an int, bitops require
> "long".

I knew that.... but obviously not at the right time.  Thanks.

Now if only Linus has told me (like you did) instead of just making
the change himself in 2.5, I would have got it right in 2.4..

Anyway, I'll make sure it gets to Marcelo (if he hasn't picked it up
already) and will feel suitably chastised.

NeilBrown

> 
> --- include/linux/sunrpc/svcsock.h.~1~	Tue Aug 13 10:37:10 2002
> +++ include/linux/sunrpc/svcsock.h	Tue Aug 13 10:37:15 2002
> @@ -22,7 +22,7 @@
>  
>  	struct svc_serv *	sk_server;	/* service for this socket */
>  	unsigned char		sk_inuse;	/* use count */
> -	unsigned int		sk_flags;
> +	unsigned long		sk_flags;
>  #define	SK_BUSY		0			/* enqueued/receiving */
>  #define	SK_CONN		1			/* conn pending */
>  #define	SK_CLOSE	2			/* dead or dying */
