Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbWBTP2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbWBTP2s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 10:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbWBTP2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 10:28:48 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:36231 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030241AbWBTP2s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 10:28:48 -0500
From: Dmitry Mishin <dim@openvz.org>
Organization: SWsoft
To: "David S. Miller" <davem@davemloft.net>
Subject: [NET][IA64] Unaligned access in sk_run_filter
Date: Mon, 20 Feb 2006 18:28:28 +0300
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       rusty@rustcorp.com.au, devel@openvz.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602201828.29098.dim@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We have an issue on ia64 box. It is easy triggerable 'kernel unaligned access' 
in sk_run_filter:
         ptr = load_pointer(skb, k, 4, &tmp);
         if (ptr != NULL) {
                  A = ntohl(*(u32 *)ptr); << here
                  continue;
         }

due to 'k' is coming from userspace it can be easy triggered, e.g.:
[root@node1 ~]# tcpdump -i eth0 'ip[1:2]=0'

Could you advise how to fix this?

-- 
Thanks,
Dmitry.
