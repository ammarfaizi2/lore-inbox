Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbVIVNDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbVIVNDX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbVIVNDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:03:23 -0400
Received: from ns2.suse.de ([195.135.220.15]:61674 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030298AbVIVNDW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:03:22 -0400
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
Date: Thu, 22 Sep 2005 15:03:21 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       netdev@vger.kernel.org
References: <432EF0C5.5090908@cosmosbay.com> <43308324.70403@cosmosbay.com> <4331CFA7.50104@cosmosbay.com>
In-Reply-To: <4331CFA7.50104@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509221503.21650.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 1) No more central rwlock protecting each table (filter, nat, mangle, raw),
>     but one lock per CPU. It avoids cache line ping pongs for each packet.

Another useful change would be to not take the lock when there are no
rules. Currently just loading iptables has a large overhead.

-Andi
