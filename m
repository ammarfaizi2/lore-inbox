Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbTGBQny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 12:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264181AbTGBQnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 12:43:53 -0400
Received: from indyio.rz.uni-saarland.de ([134.96.7.3]:58687 "EHLO
	indyio.rz.uni-saarland.de") by vger.kernel.org with ESMTP
	id S264097AbTGBQnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 12:43:50 -0400
Message-ID: <3F030EFC.7090809@hipac.org>
Date: Wed, 02 Jul 2003 18:57:32 +0200
From: Michael Bellion and Thomas Heinz <nf@hipac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: de, en
MIME-Version: 1.0
To: P@draigbrady.com
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [ANNOUNCE] nf-hipac v0.8 released
References: <Pine.LNX.4.44.0307020826530.23232-100000@netcore.fi> <200307021426.56138.nf@hipac.org> <3F02D964.7050301@draigBrady.com> <200307021548.19989.nf@hipac.org> <3F02EAE2.8050609@draigBrady.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pádraig

You wrote:
> I was testing with 64 byte packets (so around 190Kpps). e100 cards at 
> least have a handy mode for continually sending a packet as fast as 
> possible. Also you can use more than one interface.

Yes, that's true. When we did the performance tests we had in mind to
compare the worst case behaviour of nf-hipac and iptables.
Therefore we designed a ruleset which models the worst case for both
iptables and nf-hipac. Of course, the test environment could have been
tuned a lot more, e.g. udp instead of tcp, FORWARD chain instead of
INPUT, tuned network parameters, more interfaces etc.

Anyway, we prefer independent, more sophisticated performance tests.

>>> # ./readprofile -m /boot/System.map | sort -nr | head -30
>>>   6779 total                                      0.0047
>>>   4441 default_idle                              69.3906
>>>    787 handle_IRQ_event                           7.0268
>>>    589 ip_packet_match                            1.6733
>>>    433 ipt_do_table                               0.6294
>>>    106 eth_type_trans                             0.5521
>>>    [...]
> 
> Confused me too. The system would lock up and start dropping
> packets after 125 rules. I.E. it would linearly degrade
> as more rules were added. I'm guessing there is a fixed
> interrupt overhead that is accounted for
> by default_idle?

Hm, but once the system starts to drop packets ip_packet_match and
ipt_do_table start to dominate the profile, don't they?


Regards,

+-----------------------+----------------------+
|   Michael Bellion     |     Thomas Heinz     |
| <mbellion@hipac.org>  |  <creatix@hipac.org> |
+-----------------------+----------------------+

