Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265627AbUAMVCE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 16:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265651AbUAMVBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 16:01:36 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:20061 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S265627AbUAMVAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 16:00:36 -0500
Date: Tue, 13 Jan 2004 16:00:32 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <selinux@tycho.nsa.gov>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH][SELINUX] 2/2 Add SEND_MSG and RECV_MSG controls
In-Reply-To: <Xine.LNX.4.44.0401131326240.6829-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0401131557590.7560-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004, James Morris wrote:

> This patch implements two new access controls for SELinux: SEND_MSG and 
> RECV_MSG, providing mediation of network packets based on destination 
> port (IPv4 only at this stage).
> 

After some further discussion, Stephen and I decided that it would be more 
useful for security to invert the sense of the RECV_MSG permission so that 
the source port is checked during packet reception.

This patch is relative to the previous patch, please let me know if you 
want the entire patch redone.


diff -urN -X dontdiff linux-2.6.1-mm2.p/security/selinux/hooks.c linux-2.6.1-mm2.w/security/selinux/hooks.c
--- linux-2.6.1-mm2.p/security/selinux/hooks.c	2004-01-13 15:59:04.153184216 -0500
+++ linux-2.6.1-mm2.w/security/selinux/hooks.c	2004-01-13 14:32:06.000000000 -0500
@@ -2773,7 +2773,7 @@
 
 		/* Fixme: make this more efficient */
 		err = security_port_sid(sk->sk_family, sk->sk_type,
-		                        sk->sk_protocol, ntohs(ad.u.net.dport),
+		                        sk->sk_protocol, ntohs(ad.u.net.sport),
 		                        &port_sid);
 		if (err)
 			goto out;

