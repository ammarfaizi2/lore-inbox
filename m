Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267618AbTA3UDX>; Thu, 30 Jan 2003 15:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267621AbTA3UDX>; Thu, 30 Jan 2003 15:03:23 -0500
Received: from arnold.dormnet.his.se ([193.10.185.236]:48911 "HELO
	smtp.dormnet.his.se") by vger.kernel.org with SMTP
	id <S267618AbTA3UDW>; Thu, 30 Jan 2003 15:03:22 -0500
Date: Thu, 30 Jan 2003 21:08:41 +0100
From: Andreas Henriksson <andreas@fjortis.info>
To: "Randy\.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 87 potential array bounds error/buffer overruns in 2.5.53
Message-ID: <20030130200841.GA26758@foo>
References: <000001c2c5a4$5c4465d0$09830c80@stanfordja31z2> <Pine.LNX.4.33L2.0301301102575.4084-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0301301102575.4084-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> These (potential) reported errors are unfixed:
...
> 1	|	/sound/sb_card.c
...

The original message said:
---------------------------------------------------------
[BUG] what if the for loop above ends with i = 0?
/home/yxie/linux-2.5.53/sound/oss/sb_card.c:890:sb_isapnp_probe:
ERROR:BUFFER:890:890:Array bounds error (off < 0) (sb_isapnp_list[i],
max(off) = -1) 
}

if(!first || !reverse)
i = isapnpjump;
first = 0;

Error --->
while(sb_isapnp_list[i].card_vendor != 0) {
static struct pci_bus *bus = NULL;

while ((bus = isapnp_find_card(
---------------------------------------------------------


(Hopefully) Relevant loop:
    /* Count entries in sb_isapnp_list */
    for (i = 0; sb_isapnp_list[i].card_vendor != 0; i++);
    i--;

The loop will never end with i=0 unless the card list is
empty. And what use would a driver with an empty card list be? (so that
will never happen. Maybee the checker won't trigger if the cardlist is
marked as "const"? I vote for this to be marked as a non-bug, but
someone else should probably check it too.)

 -- Andreas Henriksson
