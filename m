Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbUCDCIj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 21:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbUCDCIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 21:08:39 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:21010 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S261400AbUCDCIi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 21:08:38 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: lkml <linux-kernel@vger.kernel.org>
Subject: ip a flush problem on 2.6 kernels (fine on 2.4 kernels)
Date: Thu, 4 Mar 2004 03:08:15 +0100
User-Agent: KMail/1.6.1
Cc: netdev@oss.sgi.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403040308.15880.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that

ip a a 192.168.0.1/24 dev eth0
ip link set eth0 down
ip a flush dev eth0

Here on my vanilla 2.6.2 it locks eating CPU - it does netlink 
communication over and over. This ,,hang'' doesn't happen when 
interface is in UP state. Also doesn't happen on 2.4 kernels.

I've tried it on different 2.6 kernels (one from fedora, one from PLD) with 
different versions of iproute2 (usually latest). Friend tried it also with 
iproute2 from slackware - same result.

Same happens when using lo interface instead of ethX.

More description in RH bugzilla:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=116982

ps. doing that on Broadcom Corporation BCM4401 100Base-T ethX interface (using 
b44 driver) causes lock (but sysrq works) on 2.4.25 kernel. Would be nice if 
someone with that hardware could verify this.
-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
