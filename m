Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWEPPYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWEPPYX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWEPPYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:24:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:31004 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751205AbWEPPYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:24:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=BfJpSSKe4xiwZvRrwi8KC5QD74z+V0BzS8lE4akSd4ZK0O4ZVL3lc3Ek77/zcPAjwFWW+GL9gOa6y7DT7PMq+aGV72lUvTB7/HhCwuhrfr/ttpVzDJ6TLPMvewUzrTp/DWnyrOndWWGgBszId+NO/M5XN5JrS/RGM8CR1YpfWik=
Date: Tue, 16 May 2006 19:23:05 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       James Morris <jmorris@namei.org>
Subject: [PATCH] selinux: endian fix
Message-ID: <20060516152305.GI10143@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3231,7 +3231,7 @@ static int selinux_socket_sock_rcv_skb(s
 		goto out;
 
 	/* Handle mapped IPv4 packets arriving via IPv6 sockets */
-	if (family == PF_INET6 && skb->protocol == ntohs(ETH_P_IP))
+	if (family == PF_INET6 && skb->protocol == htons(ETH_P_IP))
 		family = PF_INET;
 
  	read_lock_bh(&sk->sk_callback_lock);

