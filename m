Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131967AbRAGNl5>; Sun, 7 Jan 2001 08:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132056AbRAGNlq>; Sun, 7 Jan 2001 08:41:46 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37646 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132021AbRAGNlj>; Sun, 7 Jan 2001 08:41:39 -0500
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
To: greearb@candelatech.com (Ben Greear)
Date: Sun, 7 Jan 2001 13:42:50 +0000 (GMT)
Cc: davem@redhat.com (David S. Miller), linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
In-Reply-To: <3A57EB5E.966C91DA@candelatech.com> from "Ben Greear" at Jan 06, 2001 09:06:54 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FG60-0002eP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> + *      NOTE:  That is no longer true with the addition of VLAN tags.  Not
> + *             sure which should go first, but I bet it won't make much
> + *             difference if we are running VLANs.  The good news is that

It makes a lot of difference tha the vlan goes 2nd. Most sane people wont
have vlans active on a high load interface.

>  			strcpy(dev->name, buf);
>  			return i;
>  		}
>  	}
> -	return -ENFILE;	/* Over 100 of the things .. bail out! */
> +	return -ENFILE;	/* Over 8192 of the things .. bail out! */

So fix the algorithm. You want the list sorted at this point, or to generate
a bitmap of free/used entries and scan the list then scan the map

Question: How do devices with hardware vlan support fit into your model ?

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
