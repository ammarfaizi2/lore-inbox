Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264992AbTGBNd7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 09:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264993AbTGBNd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 09:33:59 -0400
Received: from indyio.rz.uni-saarland.de ([134.96.7.3]:3359 "EHLO
	indyio.rz.uni-saarland.de") by vger.kernel.org with ESMTP
	id S264992AbTGBNd6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 09:33:58 -0400
From: Michael Bellion and Thomas Heinz <nf@hipac.org>
Reply-To: nf@hipac.org
To: P@draigbrady.com
Subject: Re: [ANNOUNCE] nf-hipac v0.8 released
Date: Wed, 2 Jul 2003 15:48:19 +0200
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.44.0307020826530.23232-100000@netcore.fi> <200307021426.56138.nf@hipac.org> <3F02D964.7050301@draigBrady.com>
In-Reply-To: <3F02D964.7050301@draigBrady.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200307021548.19989.nf@hipac.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pádraig

> > Since real world network traffic always consists of a lot of different
> > sized packets taking maximum sized packets is very euphemistic. 1450 byte
> > packets at 950 Mbit/s correspond to approx. 80,000 packets/sec.
> > We are really interested in how our algorithm performs at higher packet
> > rates. Our performance tests are based on 100 Mbit hardware so we coudn't
> > test with more than approx. 80,000 packets/sec even with minimum sized
> > packets.
>
> Interrupt latency is the problem here. You'll require napi et. al
> to get over this hump.

Yes we know, but with 128 byte frame size you can archieve a packet rate of at 
most 97,656 packets/sec (in theory) on 100 Mbit hardware. We don't think this 
few more packets would have changed the results fundamentally, so it's 
probably not worth it on 100 Mbit.
Certainly you are right, that napi is required on gigabit to saturate the link 
with small sized packets. 

> Cool. The same sort of test with ordinary netfilter that
> I did showed it could only handle around 125 rules at this
> packet rate on a 1.4GHz PIII, e1000 @ 100Mb/s.
>
> # ./readprofile -m /boot/System.map | sort -nr | head -30
>    6779 total                                      0.0047
>    4441 default_idle                              69.3906
>     787 handle_IRQ_event                           7.0268
>     589 ip_packet_match                            1.6733
>     433 ipt_do_table                               0.6294
>     106 eth_type_trans                             0.5521
>     [...]

What do you want to show with this profile? Most of the time is spend in the 
idle loop and in icq handling and only a few percentage in ip_packet_match 
and ipt_do_table, so we don't quite get how this matches your statement 
above. Could you explain this in a few words?

Regards,

+-----------------------+----------------------+
|   Michael Bellion     |     Thomas Heinz     |
| <mbellion@hipac.org>  |  <creatix@hipac.org> |
+-----------------------+----------------------+

