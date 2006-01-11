Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWAKUUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWAKUUU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 15:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWAKUUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 15:20:20 -0500
Received: from knorkaan.xs4all.nl ([213.84.240.34]:43933 "EHLO
	knorkaan.xs4all.nl") by vger.kernel.org with ESMTP id S964797AbWAKUUT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 15:20:19 -0500
Date: Wed, 11 Jan 2006 21:20:06 +0100 (CET)
From: Jerome Borsboom <j.borsboom@erasmusmc.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] no message type set in af_key.c, linux-2.6.15
Message-ID: <Pine.LNX.4.64.0601112108040.446@knorkaan.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When returning a message to userspace in reply to a SADB_FLUSH or 
SADB_X_SPDFLUSH message, the type was not set for the returned PFKEY 
message. The patch below corrects this problem.

Signed-off-by: Jerome Borsboom <j.borsboom@erasmusmc.nl>

--- linux-2.6.15/net/key/af_key.c	2006-01-03 09:50:44.000000000 +0100
+++ linux-2.6.15/net/key/af_key.c.new	2006-01-11 17:04:02.000000000 +0100
@@ -1526,6 +1526,7 @@
  	if (!skb)
  		return -ENOBUFS;
  	hdr = (struct sadb_msg *) skb_put(skb, sizeof(struct sadb_msg));
+	hdr->sadb_msg_type = SADB_FLUSH;
  	hdr->sadb_msg_satype = pfkey_proto2satype(c->data.proto);
  	hdr->sadb_msg_seq = c->seq;
  	hdr->sadb_msg_pid = c->pid;
@@ -2227,6 +2228,7 @@
  	if (!skb_out)
  		return -ENOBUFS;
  	hdr = (struct sadb_msg *) skb_put(skb_out, sizeof(struct sadb_msg));
+	hdr->sadb_msg_type = SADB_X_SPDFLUSH;
  	hdr->sadb_msg_seq = c->seq;
  	hdr->sadb_msg_pid = c->pid;
  	hdr->sadb_msg_version = PF_KEY_V2;
