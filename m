Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136236AbRAGSHM>; Sun, 7 Jan 2001 13:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136262AbRAGSHC>; Sun, 7 Jan 2001 13:07:02 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:37133 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S136236AbRAGSGv>;
	Sun, 7 Jan 2001 13:06:51 -0500
Message-ID: <3A58BF04.D7304A0A@candelatech.com>
Date: Sun, 07 Jan 2001 12:09:56 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
In-Reply-To: <E14FGD4-0002f7-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Suppose I bind a raw socket to device vlan4001 (ie I have 4k in the list
> > before that one!!).  Currently, that means a linear search on all devices,
> > right?  In that extreme example, I would expect the hash to be very
> > useful.
> 
> At this point you have to ask 'why is vlan4001 an interface'. Would it not
> be cleaner to add the vlan id to the entries in the list of addresses per
> interface ?

Among other things, some VLAN switches won't work unless you can change
the MAC address on your VLANs to be different from the rest of the
VLAN MACs on that physical interface.  For OSPF you also need to
have multicast work on them, and other things that look very much like
a real interface.

Also, by making the VLANs a net_device, the rest of the kernel and
user-space code (ip, ifconfig, for example), works as expected, with
no changes.

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
