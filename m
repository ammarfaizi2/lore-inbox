Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129035AbRBFMhB>; Tue, 6 Feb 2001 07:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129058AbRBFMgv>; Tue, 6 Feb 2001 07:36:51 -0500
Received: from [195.6.125.97] ([195.6.125.97]:29961 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S129035AbRBFMgk>;
	Tue, 6 Feb 2001 07:36:40 -0500
Message-Id: <l0310280ab6a59b6a53d3@[172.30.8.86]>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="============_-1230659375==_============"
Date: Tue, 6 Feb 2001 13:38:37 +0100
To: linux-kernel@vger.kernel.org
From: Eric Berenguier <Eric.Berenguier@sycomore.fr>
Subject: PATCH: ipfwadm IP accounting (2.4.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--============_-1230659375==_============
Content-Type: text/plain; charset="us-ascii"

Hello,


Using ipfwadm on a 2.4.1 kernel, some ip accouting rules for outgoing
packets have theirs packet and byte counter stuck to 0 value. There is no
such problem with incoming packets.

For example try this one: ipfwadm -A out -a -W eth0 -S 0/0 -D 0/0

The included patch solves this problem (this was probably a typo).
I've only tested it with ipfwadm and with simple rules like the one above.


Eric Berenguier

--============_-1230659375==_============
Content-Type: text/plain; name="2.4.1_ipfwadm_ip_acct_out_patch"; charset="us-ascii"
Content-Disposition: attachment; filename="2.4.1_ipfwadm_ip_acct_out_patch"

--- linux-2.4.1/net/ipv4/netfilter/ip_fw_compat.c	Tue Feb  6 11:10:01
2001
+++ linux/net/ipv4/netfilter/ip_fw_compat.c	Tue Feb  6 09:03:17 2001
@@ -132,7 +132,7 @@
 		if (ret == FW_ACCEPT || ret == FW_SKIP) {
 			if (fwops->fw_acct_out)
 				fwops->fw_acct_out(fwops, PF_INET,
-						   (struct net_device *)in,
+						   (struct net_device *)out,
 						   (*pskb)->nh.raw, &redirpt,
 						   pskb);
 			confirm_connection(*pskb);

--============_-1230659375==_============
Content-Type: text/plain; charset="us-ascii"

--
Eric Berenguier

-----------------------------------------------------------------
                    SYCOMORE Groupe EADS
63 Ter, Av. Edouard Vaillant - 92517 Boulogne-Billancourt Cedex
  Tel. : +33 (0)1 46 08 61 55 - Fax : +33 (0)1 46 08 63 19
                    http://www.sycomore.fr
-----------------------------------------------------------------


--============_-1230659375==_============--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
