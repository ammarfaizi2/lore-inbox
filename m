Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264975AbTGBNA0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 09:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264982AbTGBNA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 09:00:26 -0400
Received: from gate.corvil.net ([213.94.219.177]:19982 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S264975AbTGBNAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 09:00:24 -0400
Message-ID: <3F02D964.7050301@draigBrady.com>
Date: Wed, 02 Jul 2003 14:08:52 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nf@hipac.org
CC: Pekka Savola <pekkas@netcore.fi>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [ANNOUNCE] nf-hipac v0.8 released
References: <Pine.LNX.4.44.0307020826530.23232-100000@netcore.fi> <200307021426.56138.nf@hipac.org>
In-Reply-To: <200307021426.56138.nf@hipac.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Bellion and Thomas Heinz wrote:
> Hi Pekka
> 
> 
>>Thanks for your clarification.  We've also conducted some tests with
>>bridging firewall functionality, and we're very pleased with nf-hipac's
>>performance!  Results below.
> 
> 
> Great, thanks a lot. Your tests are very interesting for us as we haven't done 
> any gigabit or SMP tests yet. 
> 
>>In the measurements, tests were run through a bridging Linux firewall,
>>with a netperf UDP stream of 1450 byte packets (launched from a different
>>computer connected with gigabit ethernet), with a varying amount of
>>filtering rules checks for each packet.
>>I don't have the specs of the Linux PC hardware handy, but I recall
>>they're *very* highend dual-P4's, like 2.4Ghz, very fast PCI bus, etc.
> 
> Since real world network traffic always consists of a lot of different sized 
> packets taking maximum sized packets is very euphemistic. 1450 byte packets 
> at 950 Mbit/s correspond to approx. 80,000 packets/sec.
> We are really interested in how our algorithm performs at higher packet rates. 
> Our performance tests are based on 100 Mbit hardware so we coudn't test with 
> more than approx. 80,000 packets/sec even with minimum sized packets.

Interrupt latency is the problem here. You'll require napi et. al
to get over this hump.

> At this 
> packet rate we were hardly able to drive the algorithm to its limit, even 
> with more than 25000 rules involved (and our test system was 1.3 GHz 
> uniprocessor).

Cool. The same sort of test with ordinary netfilter that
I did showed it could only handle around 125 rules at this
packet rate on a 1.4GHz PIII, e1000 @ 100Mb/s.

# ./readprofile -m /boot/System.map | sort -nr | head -30
   6779 total                                      0.0047
   4441 default_idle                              69.3906
    787 handle_IRQ_event                           7.0268
    589 ip_packet_match                            1.6733
    433 ipt_do_table                               0.6294
    106 eth_type_trans                             0.5521
     56 kfree                                      0.8750
     46 skb_release_data                           0.3194
     37 add_timer_randomness                       0.1542
     35 alloc_skb                                  0.0781
     30 __kmem_cache_alloc                         0.1172
     27 kmalloc                                    0.3375
     23 ip_rcv                                     0.0342
     22 do_gettimeofday                            0.1964
     20 netif_rx                                   0.0521
     19 __kfree_skb                                0.0540
     18 add_entropy_words                          0.1023
     15 __constant_c_and_count_memset              0.0938
     13 batch_entropy_store                        0.0813
     12 kfree_skbmem                               0.1071
     11 netif_receive_skb                          0.0208
      7 nf_iterate                                 0.0437
      7 nf_hook_slow                               0.0175
      6 process_backlog                            0.0221
      5 batch_entropy_process                      0.0223
      5 add_interrupt_randomness                   0.0781
      3 kmem_cache_free                            0.0625
      2 ipt_hook                                   0.0312
      1 write_profile                              0.0156
      1 ip_promisc_rcv_finish                      0.0208

Pádraig.

