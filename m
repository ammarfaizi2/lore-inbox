Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314468AbSESPRz>; Sun, 19 May 2002 11:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314475AbSESPRy>; Sun, 19 May 2002 11:17:54 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:35744 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S314468AbSESPRx>;
	Sun, 19 May 2002 11:17:53 -0400
Date: Sun, 19 May 2002 17:17:35 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: livio@cyclades.com
Cc: khc@pm.waw.pl, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: HDLC driver: Frame-relay Inverse ARP]
Message-ID: <20020519171735.A18735@fafner.intra.cogenit.fr>
In-Reply-To: <3CE40B22.199C4F07@cyclades.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Livio Ceci <livio@cyclades.com.br> :
[rfc2390 for linux fr]
> I attached a diff file with the changes I did, and also the sethdlc.
> Please analyse them and send me back your comments, and if possible,
> something that help me to "fill the blanks" I left as ??? in the code.

May be something like this:
net/ipv4/arp.c
/*
 *     Special case: We must set Frame Relay source Q.922 address
 */
        if (dev_type == ARPHRD_DLCI) {
                sha = dev->broadcast;
                if (arp->ar_op == __constant_htons(ARPOP_InREQUEST)) {
                        /*
                         * Use fib_lookup in order to comply with
                         * address selection in rfc2390 - 7.1 and
                         * set tip consequently
                         */
                        ...
                } else if (arp->ar_op == __constant_htons(ARPOP_InREPLY))
                        arp->ar_op = ARPOP_REPLY;
        }

Then one forces ARPOP_InREQUEST to follow the same path as ARPOP_REQUEST,
arp_send(ARPOP_InREPLY,...) being the sole difference.
               ^^
Remarks ?

-- 
Ueimor
