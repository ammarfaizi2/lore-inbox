Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267709AbTACWug>; Fri, 3 Jan 2003 17:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267710AbTACWug>; Fri, 3 Jan 2003 17:50:36 -0500
Received: from 5-116.ctame701-1.telepar.net.br ([200.193.163.116]:59528 "EHLO
	5-116.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267709AbTACWue>; Fri, 3 Jan 2003 17:50:34 -0500
Date: Fri, 3 Jan 2003 20:58:50 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
cc: linux-kernel@vger.kernel.org
Subject: Re: [STUPID] Best looking code to transfer to a t-shirt
In-Reply-To: <Pine.LNX.4.44.0301031419560.11311-100000@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.50L.0301032057380.2429-100000@imladris.surriel.com>
References: <Pine.LNX.4.44.0301031419560.11311-100000@dns.toxicfilms.tv>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jan 2003, Maciej Soltysiak wrote:

> I am in a t-shirt transfering frenzy and was wondering which part of the
> kernel code it would be best to have on my t-shirt.

> How about we have a poll of the most frightening pieces of the kernel ?

How about drivers/net/sunhme.c ?

It's not scary, but it is absolutely hilarious, even to
people who don't even know C.

static void happy_meal_tcvr_write(struct happy_meal *hp,
                                  unsigned long tregs, int reg,
                                  unsigned short value)
{
        int tries = TCVR_WRITE_TRIES;

        ASD(("happy_meal_tcvr_write: reg=0x%02x value=%04x\n", reg,
value));

        /* Welcome to Sun Microsystems, can I take your order please? */
        if (!hp->happy_flags & HFLAG_FENABLE)
                return happy_meal_bb_write(hp, tregs, reg, value);

        /* Would you like fries with that? */
        hme_write32(hp, tregs + TCVR_FRAME,
                    (FRAME_WRITE | (hp->paddr << 23) |
                     ((reg & 0xff) << 18) | (value & 0xffff)));
        while (!(hme_read32(hp, tregs + TCVR_FRAME) & 0x10000) && --tries)
                udelay(20);

        /* Anything else? */
        if (!tries)
                printk(KERN_ERR "happy meal: Aieee, transceiver MIF write
bolixed\n");

        /* Fifty-two cents is your change, have a nice day. */
}


Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
