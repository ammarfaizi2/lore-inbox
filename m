Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTDQA7m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 20:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbTDQA7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 20:59:42 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:7300 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262174AbTDQA7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 20:59:41 -0400
Date: Wed, 16 Apr 2003 21:11:31 -0400 (EDT)
From: Rik van Riel <riel@surriel.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: coreteam@netfilter.org
cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: [PATCH] compile fix ipfw
Message-ID: <Pine.LNX.4.44.0304162109530.12650-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the patch that went to marcelo a few days ago the reset
argument to ip_chain_procinfo() got removed, but there's still
a code block inside the function that references that variable.

This patch gets rid of that (presumably old) code block. Note
that I didn't cc this to Marcelo because I'm not 100% sure, so
please check it.

--- linux-2.4.20/net/ipv4/netfilter/ipfwadm_core.c.compile	2003-04-16 21:04:30.000000000 -0400
+++ linux-2.4.20/net/ipv4/netfilter/ipfwadm_core.c	2003-04-16 21:05:24.000000000 -0400
@@ -1176,12 +1176,6 @@ static int ip_chain_procinfo(int stage, 
 			len = last_len;
 			break;
 		}
-		else if(reset)
-		{
-			/* This needs to be done at this specific place! */
-			i->fw_pcnt=0L;
-			i->fw_bcnt=0L;
-		}
 		last_len = len;
 		i=i->fw_next;
 	}

