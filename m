Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265850AbUFIRxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265850AbUFIRxZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 13:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265857AbUFIRxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 13:53:25 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:39660 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265850AbUFIRxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 13:53:20 -0400
Date: Wed, 9 Jun 2004 19:52:43 +0200
From: bert hubert <ahu@ds9a.nl>
To: davem@redhat.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [DOCUMENTATION PATCH] Missing net sysctls, some fixed, rest flagged
Message-ID: <20040609175242.GA13875@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, davem@redhat.com,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave, Lists, 

I ran the following (crappy) script:

for b in $(for a in $(find | grep -v eth0 | grep -v binfmt)
                do 
                        basename $a
                done | sort -u); 
                do 
                        if rgrep -q $b ~/download/linux-2.6.6/Documentation/ 
                        then
                                touch /tmp/script
                        else
                                echo $b missing
                        fi
                done

In /proc/sys/ and found a host of undocumented sysctls. This patch documents
a number of them, and at least mentions the rest as 'TODO'. Please verify my
code-inspired documentation before applying!

--- linux-2.6.6/Documentation/networking/ip-sysctl.txt.ahu	2004-06-09 18:53:29.000000000 +0200
+++ linux-2.6.6/Documentation/networking/ip-sysctl.txt	2004-06-09 19:46:15.000000000 +0200
@@ -17,6 +17,16 @@
 	Disable Path MTU Discovery.
 	default FALSE
 
+min_pmtu - INTEGER
+	default 562 - minimum discovered Path MTU
+
+mtu_expires - INTEGER
+	FIXME: unknown
+
+min_adv_mss - INTEGER
+	The advertised MSS depends on the first hop route MTU, but will
+	never be lower than this setting
+
 IP Fragmentation:
 
 ipfrag_high_thresh - INTEGER
@@ -340,6 +350,17 @@
 	more rapidly.
 	Default: 1
 
+
+tcp_frto - BOOLEAN
+	Enables F-RTO, an enhanced recovery algorithm for TCP retransmission
+	timeouts
+
+somaxconn - INTEGER
+	Limit of TCP listen backlog, known in userspace as SOMAXCONN.
+	Defaults to 128
+
+IP Variables:
+
 ip_local_port_range - 2 INTEGERS
 	Defines the local port range that is used by TCP and UDP to
 	choose the local port. The first number is the first, the 
@@ -581,6 +602,19 @@
 	The max value from conf/{all,interface}/arp_ignore is used
 	when ARP request is received on the {interface}
 
+app_solicit - INTEGER
+	The maximum number of probes to send to the user space ARP daemon
+	via netlink before dropping back to multicast probes (see
+	mcast_solicit).  Defaults to 0.
+
+disable_policy - BOOLEAN
+	Disable IPSEC policy (SPD) for this interface
+
+disable_xfrm - BOOLEAN
+	Disable IPSEC encryption on this interface, whatever the policy
+
+
+
 tag - INTEGER
 	Allows you to write a number, which can be used as required.
 	Default value is 0.
@@ -799,4 +833,25 @@
 	Default: 1
 
 
+UNDOCUMENTED:
+
+dev_weight FIXME
+discovery_slots FIXME
+discovery_timeout FIXME
+fast_poll_increase FIXME
+ip6_queue_maxlen FIXME
+lap_keepalive_time FIXME
+lo_cong FIXME
+max_baud_rate FIXME
+max_dgram_qlen FIXME
+max_noreply_time FIXME
+max_tx_data_size FIXME
+max_tx_window FIXME
+min_tx_turn_time FIXME
+mod_cong FIXME
+no_cong FIXME
+no_cong_thresh FIXME
+slot_timeout FIXME
+warn_noreply_time FIXME
+
 $Id: ip-sysctl.txt,v 1.20 2001/12/13 09:00:18 davem Exp $
--- linux-2.6.6/Documentation/filesystems/proc.txt.ahu	2004-06-09 19:31:17.000000000 +0200
+++ linux-2.6.6/Documentation/filesystems/proc.txt	2004-06-09 19:32:09.000000000 +0200
@@ -1628,7 +1628,8 @@
 
 Writing to this file results in a flush of the routing cache.
 
-gc_elastic, gc_interval, gc_min_interval, gc_tresh, gc_timeout
+gc_elasticity, gc_interval, gc_min_interval, gc_tresh, gc_timeout,
+gc_thresh, gc_thresh1, gc_thresh2, gc_thresh3
 --------------------------------------------------------------
 
 Values to  control  the  frequency  and  behavior  of  the  garbage collection


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
