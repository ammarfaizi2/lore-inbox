Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274707AbRITXfs>; Thu, 20 Sep 2001 19:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274702AbRITXfi>; Thu, 20 Sep 2001 19:35:38 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:16862 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S274699AbRITXfa>; Thu, 20 Sep 2001 19:35:30 -0400
Importance: Normal
Subject: Re: [PATCH] strict interface arp patch for Linux 2.4.2
To: linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OFEC0F6C6D.00C73EFF-ON85256ACD.00818C46@raleigh.ibm.com>
From: "Allen Lau" <pflau@us.ibm.com>
Date: Thu, 20 Sep 2001 19:34:21 -0400
X-MIMETrack: Serialize by Router on D04NMS38/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 09/20/2001 07:35:47 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Julian Anastasov <ja@ssi.bg> on 09/20/2001 06:19:04 PM

To:   Allen Lau/Raleigh/IBM@IBMUS
cc:   linux-kernel <linux-kernel@vger.kernel.org>
Subject:  Re: [PATCH] strict interface arp patch for Linux 2.4.2




     Hello,

On Thu, 20 Sep 2001, Allen Lau wrote:

>> I want to bring your attention to a Linux ARP patch we plan to use for
load balancing and server
>> clustering.  The available arp filter and hidden patch are not
completely satisfactory. The following

>    Can you explain what setup can't be build using arp_filter,
> hidden or rp_filter and particulary where "hidden" fails for clusters,
> it is very interesting?

The function provided by "hidden" is a necessary element but not
sufficient. I suppose arp_filter
has to be combined with the hidden patch. I dislike hiding an interface,
and the hidden patch is no
longer included in the major distributions which makes delivering a
solution difficult.

In this example, 1.1.1.11 2.2.2.22 are virtual ip's which can float between
boxes and interfaces.
I want virtual ip 1.1.1.11 to be known to clients through eth0 node1
(2.2.2.22 eth1 node2). Node1
can redirect 1.1.1.11 traffic to eth0 node2.
                          node1                                 node2
                      lo:1 1.1.1.11                          lo:1 1.1.1.11
                      lo:2 2.2.2.22                          lo:2 2.2.2.22

              eth0   1.1.1.1     eth1 2.2.2.1         eth0  1.1.1.2   eth1
2.2.2.2
              eth0:1 1.1.1.11
eth1:1 2.2.2.22

On node1, does hiding loopback hide 1.1.1.11? and can 2.2.2.1 be advertised
as source ip in arp
requests from eth0?

>> To generalize, each real server may have multiple nic's of different
types. The task becomes one of
?> maintaining strict identity of each of the real and virtual ip
addresses.  The Linux ARP has the
>> following behaviors which are problematic for maintaining strict
interface identify.
>>
>>    1) box responds to arp on all interfaces on the same wire for an IP
address (arp race)

>    rp_filter and arp_filter can help here but this "arp race" is not
> an evil in some setups

I believe "arp race" may cause purges in a switched network. It certainly
is counter to maintaining
strict interface identity.

Regards
Allen Lau
--
Julian Anastasov <ja@ssi.bg>





