Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751531AbWDAOaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbWDAOaR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 09:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbWDAOaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 09:30:17 -0500
Received: from swan.nt.tuwien.ac.at ([128.131.67.158]:16265 "EHLO
	swan.nt.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1751531AbWDAOaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 09:30:15 -0500
Date: Sat, 1 Apr 2006 16:30:11 +0200
From: Thomas Zeitlhofer <tzeitlho+lkml@nt.tuwien.ac.at>
To: linux-kernel@vger.kernel.org
Subject: bridge+netfilter broken for IP fragments in 2.6.16?
Message-ID: <20060401143011.GA28333@swan.nt.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have set up a bridge with two ports:

# brctl show br0
bridge name     bridge id               STP enabled     interfaces
br0             8000.000021f23d58       no              eth1
                                                        tap1

Using 2.6.16/.1 non fragmented IP packets are passing the bridge without
problems, but fragmented IP packets do not show up on the outgoing
interface. E.g., for fragmented traffic coming in from tap1 and going
out via eth1 tcpdump shows:

  1) on tap1: fragmented packets
  2) on br0: the defragmented packet (connection tracking)
  3) on eth1: no packet!?

This breaks IPsec connections for example.


Doing the same on 2.6.15.x shows:

  1) on tap1: fragmented packets
  2) on br0: the defragmented packet (connection tracking)
  3) on eth1: fragmented packets

and IPsec connections are ok.


If I disable netfilter for bridged traffic in 2.6.16/.1 

# echo 0 > /proc/sys/net/bridge/bridge-nf-call-iptables 

then the fragmented traffic passes the bridge without problems.


Is this a known issue?

--
Thomas
