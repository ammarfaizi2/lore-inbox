Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136191AbRAGR7m>; Sun, 7 Jan 2001 12:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136212AbRAGR7d>; Sun, 7 Jan 2001 12:59:33 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:31757 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S136191AbRAGR7Q>;
	Sun, 7 Jan 2001 12:59:16 -0500
Message-ID: <3A58BD44.1381D182@candelatech.com>
Date: Sun, 07 Jan 2001 12:02:28 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
In-Reply-To: <E14FG60-0002eP-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > + *      NOTE:  That is no longer true with the addition of VLAN tags.  Not
> > + *             sure which should go first, but I bet it won't make much
> > + *             difference if we are running VLANs.  The good news is that
> 
> It makes a lot of difference tha the vlan goes 2nd. Most sane people wont
> have vlans active on a high load interface.

Um, what about people running their box as just a VLAN router/firewall?
That seems to be one of the principle uses so far.  Actually, in that case
both VLAN and IP traffic would come through, so it would be a tie if VLAN
came first, but non-vlan traffic would suffer worse.

So, how can I make sure that it is second in the list?

> 
> >                       strcpy(dev->name, buf);
> >                       return i;
> >               }
> >       }
> > -     return -ENFILE; /* Over 100 of the things .. bail out! */
> > +     return -ENFILE; /* Over 8192 of the things .. bail out! */
> 
> So fix the algorithm. You want the list sorted at this point, or to generate
> a bitmap of free/used entries and scan the list then scan the map

Actually, VLAN code no longer uses this method to generate it's name,
it uses it's own mechanism (which, by the way, the hashed name lookup
makes much faster.)  So, this part of the patch can be removed.

> 
> Question: How do devices with hardware vlan support fit into your model ?

I don't know of any, and I'm not sure how they would be supported.

> 
> Alan

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
