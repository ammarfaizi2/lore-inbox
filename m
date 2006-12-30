Return-Path: <linux-kernel-owner+w=401wt.eu-S1755176AbWL3RPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176AbWL3RPA (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 12:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755177AbWL3RPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 12:15:00 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:38061 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755176AbWL3RO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 12:14:59 -0500
Date: Sat, 30 Dec 2006 18:14:35 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Netfilter Mailing List <netfilter@lists.netfilter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ip_tables init broken
Message-ID: <Pine.LNX.4.61.0612301738001.32449@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


when the ip_tables module is loaded automatically when inserting the 
first rule, something gets screwed up, as -L -v -n shows:


17:39 ichi:~ # lsmod | grep ip_tables
17:39 ichi:~ # iptables -t mangle -A FORWARD -i eth1 -j MARK --set-mark 161
17:39 ichi:~ # iptables -t mangle -A FORWARD -i eth1 -j MARK --set-mark 161
17:39 ichi:~ # iptables -t mangle -L -v -n | grep eth1
p b targ pr opt in  out src       dst
0 0 MARK 0  -- eth1 *   0.0.0.0/0 0.0.0.0/0  0xa1
0 0 MARK 0  -- eth1 *   0.0.0.0/0 0.0.0.0/0  MARK set 0xa1

Everything is fine if ip_tables was loaded before.

This box runs 2.6.18.5. Can anyone confirm this bug?


	-`J'
-- 
