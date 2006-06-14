Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWFNWW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWFNWW2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 18:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWFNWW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 18:22:26 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:48986 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932415AbWFNWWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 18:22:20 -0400
Message-ID: <44909A48.905@oracle.com>
Date: Wed, 14 Jun 2006 16:22:48 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
CC: marcel@holtmann.org
Subject: [Ubuntu PATCH] Make btsco headset (a bluetooth device) work
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make btsco headset (a bluetooth device) work.
Reference: https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/48910

http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=e9cb99036e650dabc5e9d7037d5a728176b42aca

Signed-off-by: Ben Collins <bcollins@ubuntu.com>
---

--- linux/net/bluetooth/hci_event.c	2006-01-31 07:52:07.000000000 +0100
+++ linux/net/bluetooth/hci_event.c	2006-02-13 10:46:30.000000000 +0100
@@ -320,9 +320,9 @@
 		}
 
 		hdev->acl_mtu  = __le16_to_cpu(bs->acl_mtu);
-		hdev->sco_mtu  = bs->sco_mtu ? bs->sco_mtu : 64;
+		hdev->sco_mtu  = (bs->sco_mtu < 64) ? 64 : bs->sco_mtu;
 		hdev->acl_pkts = hdev->acl_cnt = __le16_to_cpu(bs->acl_max_pkt);
-		hdev->sco_pkts = hdev->sco_cnt = __le16_to_cpu(bs->sco_max_pkt);
+		hdev->sco_pkts = hdev->sco_cnt = bs->sco_max_pkt ? __le16_to_cpu(bs->sco_max_pkt) : 8;
 
 		BT_DBG("%s mtu: acl %d, sco %d max_pkt: acl %d, sco %d", hdev->name,
 			hdev->acl_mtu, hdev->sco_mtu, hdev->acl_pkts, hdev->sco_pkts);

