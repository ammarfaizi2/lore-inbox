Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVCVQj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVCVQj5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 11:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVCVQjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 11:39:45 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:11965 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261422AbVCVQje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 11:39:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:organization:cc:mime-version:content-type:message-id;
        b=CB2sH81qouU55eWnU540ez1Maci4nU/p+cO28b3XzoM3y+kYohcPqjeQBWBChhhPDaqDaHxqihAHoORYeLwA1MUqeXt3aGT8pao93jg441bkvYE5Qukl6wliOUjrEhkElWZIXIjfP9sLDudS6Y1Xp0HmZVbFVq8tfi6YlF1Ke+s=
From: Vicente Feito <vicente.feito@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.12-rc1-mm1] net/ethernet/eth.c - eth_header
Date: Tue, 22 Mar 2005 13:38:08 +0000
User-Agent: KMail/1.7.1
Organization: none
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_A/BQCdrk2pbyfaF"
Message-Id: <200503221338.08834.vicente.feito@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_A/BQCdrk2pbyfaF
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
Please consider applying (or droping).
Thank you.

Description: This patch prevent drivers from calling eth_header with a 802.3 
frame using a len>1536. In such a case returns -EINVAL, which was hard to 
choose because the ETH_HLEN is supposed to return.

Signed-off-by: Vicente Feito <vicente.feito@gmail.com>

--Boundary-00=_A/BQCdrk2pbyfaF
Content-Type: text/x-diff;
  charset="us-ascii";
  name="eth.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="eth.patch"

--- linux-2.6.12-rc1-mm1/net/ethernet/eth.c.orig	2005-03-22 12:49:08.000000000 +0000
+++ linux-2.6.12-rc1-mm1/net/ethernet/eth.c	2005-03-22 12:49:36.000000000 +0000
@@ -78,6 +78,8 @@ int eth_header(struct sk_buff *skb, stru
 {
 	struct ethhdr *eth = (struct ethhdr *)skb_push(skb,ETH_HLEN);
 
+	if (type == ETH_P_802_3 && len >= 1536)
+		return -EINVAL;
 	/* 
 	 *	Set the protocol type. For a packet of type ETH_P_802_3 we put the length
 	 *	in here instead. It is up to the 802.2 layer to carry protocol information.

--Boundary-00=_A/BQCdrk2pbyfaF--
