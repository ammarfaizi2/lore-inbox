Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbTJMJD2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 05:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTJMJD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 05:03:28 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:49101
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261601AbTJMJD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 05:03:27 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: Hermes wireless 802.11b card lost its marbles under -test6.
Date: Mon, 13 Oct 2003 03:26:56 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310130326.56169.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Snippet from the log:

Oct 13 02:05:55 localhost dhclient: DHCPACK from 192.168.200.1
Oct 13 02:05:55 localhost dhclient: bound to 192.168.200.67 -- renewal in 236 
seconds.                                                                          
Oct 13 02:07:13 localhost kernel: eth0: New link status: AP Out of Range 
(0004) Oct 13 02:09:51 localhost dhclient: DHCPREQUEST on eth0 to 
192.168.200.1 port 67Oct 13 02:10:41 localhost last message repeated 3 times                         
Oct 13 02:12:01 localhost last message repeated 5 times                         
Oct 13 02:13:58 localhost last message repeated 2 times                         
Oct 13 02:15:18 localhost dhclient: DHCPREQUEST on eth0 to 255.255.255.255 
port 67                                                                              
Oct 13 02:15:56 localhost kernel: hermes @ IO 0x100: Card removed while 
waiting for command completion.                                                         
Oct 13 02:15:56 localhost kernel: eth0: Error -19 disabling MAC port            
Oct 13 02:15:57 localhost kernel: hermes @ IO 0x100: Card removed while 
waiting for command completion.                                                         
Oct 13 02:15:57 localhost kernel: eth0: Error -19 setting MAC address           
Oct 13 02:15:57 localhost kernel: eth0: Error -19 configuring card              
Oct 13 02:15:57 localhost kernel: hermes @ IO 0x100: Card removed while 
waiting for command completion.                                                         
Oct 13 02:15:57 localhost kernel: eth0: Error -19 setting MAC address           
Oct 13 02:15:57 localhost kernel: eth0: Error -19 configuring card              
Oct 13 02:15:58 localhost dhclient: DHCPDISCOVER on eth0 to 255.255.255.255 
port 67 interval 6
Oct 13 02:15:58 localhost dhclient: send_packet: Network is down
Oct 13 02:15:58 localhost dhclient: receive_packet failed on eth0: Network is 
down

Due to a signal fluctuation, the access port "went out of range", and this was 
interpreted as the card having been ejected.  (Removing the card would 
require half an hour with a screwdriver; it's built in to this laptop.)

I tried "ifconfig eth0 down; ifconfig eth0 up", and it said no such device...

Logically, the link status toggled.  This should be no different than 
unplugging and plugging in a cat 5 cable.  It is NOT synonymous with a 
cardbus eject...

Rob


