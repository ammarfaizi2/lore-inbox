Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVDCPvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVDCPvt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 11:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVDCPvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 11:51:49 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:55304 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261168AbVDCPvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 11:51:47 -0400
Date: Sun, 3 Apr 2005 12:51:44 -0300
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, davem@davemloft.net
Subject: Re: initramfs linus tree breakage in last day
Message-ID: <20050403155144.GD640@conectiva.com.br>
Mail-Followup-To: acme@ghostprotocols.net,
	Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
	davem@davemloft.net
References: <9e473391050401181824d9e50f@mail.gmail.com> <9e47339105040119302e6bb405@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105040119302e6bb405@mail.gmail.com>
X-Url: http://advogato.org/person/acme
User-Agent: Mutt/1.5.6i
From: acme@ghostprotocols.net (Arnaldo Carvalho de Melo)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 01, 2005 at 10:30:42PM -0500, Jon Smirl escreveu:
> This is what I see on boot.
> 
> -- 
> Jon Smirl
> jonsmirl@gmail.com
> 
> Linux version 2.6.12-rc1 (jonsmirl@jonsmirl.smirl.net) (gcc version
> 3.4.2 200410
> 17 (Red Hat 3.4.2-6.fc3)) #21 SMP Fri Apr 1 22:09:28 EST 2005
> found SMP MP-table at 000fe710                              

OK, SMP, could you please try this patch by James Bottomley that fixes
a brown paper bag bug in my proto_register patch?

Regards,

- Arnaldo


===== net/core/sock.c 1.67 vs edited =====
--- 1.67/net/core/sock.c	2005-03-26 17:04:35 -06:00
+++ edited/net/core/sock.c	2005-04-02 13:37:20 -06:00
@@ -1352,7 +1352,7 @@
 
 EXPORT_SYMBOL(sk_common_release);
 
-static rwlock_t proto_list_lock;
+static DEFINE_RWLOCK(proto_list_lock);
 static LIST_HEAD(proto_list);
 
 int proto_register(struct proto *prot, int alloc_slab)
