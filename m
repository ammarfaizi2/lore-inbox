Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbTEEJXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 05:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTEEJXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 05:23:00 -0400
Received: from mail3a.westend.com ([212.117.79.77]:64700 "EHLO
	mail3a1.westend.com") by vger.kernel.org with ESMTP id S262117AbTEEJW6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 05:22:58 -0400
Date: Mon, 5 May 2003 11:35:23 +0200
From: Christian Hammers <ch@westend.com>
To: linux-kernel@vger.kernel.org
Subject: icmp_ratelimit seems to be too low (related to NAT?)
Message-ID: <20030505093523.GE15625@westend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

icmp_ratelimit has, as of kernel 2.4.20, a default of 100 (which unit
btw?). This seems to be too low as I have packet loss when doing two
"mtr" to the same 4 hops away host simultaneously. As this suggerates
packet loss on the network to the administrator, a too low limit will 
certainly annoy network admins as it gives wrong information.

My tests gave the following results:

src. linux --> SNAT'ing linux router --> cisco1 --> cisco2 --> dst. linux

On the src linux host I opened _two_ mtr at the same time and watched
the packet loss at the first host after 30 rounds (seconds).

	icmp_ratelimit | loss at hop1 for both mtr
	0		 0
	10		 0
	20		 0
	40		 0
	80		 34% and 37%
	100		 44% and 57%	(default)
	160		 64% and 75%
	320		 87% and 83%
	999		 100% and 100%

For 2*(4*icmp_request + 4*icmp_timeexceeded/reply) = 16 packets per 
second the loss seems to be a bit high at the default value of 100.

Is this related to any other setting? Maybe NAT?
My /proc/net/ip_conntrack only has 1200 lines and the max in 
/proc/sys/net/ipv4/ip_conntrack_max is 32767.

bye,

-christian-

-- 
Christian Hammers             WESTEND GmbH  |  Internet-Business-Provider
Technik                       CISCO Systems Partner - Authorized Reseller
                              Lütticher Straße 10      Tel 0241/701333-11
ch@westend.com                D-52064 Aachen              Fax 0241/911879

