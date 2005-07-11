Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVGKWx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVGKWx7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVGKWwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:52:00 -0400
Received: from unused.mind.net ([69.9.134.98]:9136 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262144AbVGKWt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:49:58 -0400
Date: Mon, 11 Jul 2005 15:48:30 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@infradead.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
In-Reply-To: <20050709130557.GA5763@elte.hu>
Message-ID: <Pine.LNX.4.58.0507111359400.13011@echo.lysdexia.org>
References: <200507061257.36738.s0348365@sms.ed.ac.uk>
 <200507081938.27815.s0348365@sms.ed.ac.uk> <20050708194827.GA22536@elte.hu>
 <200507082145.08877.s0348365@sms.ed.ac.uk> <20050709124105.GB4665@elte.hu>
 <20050709130557.GA5763@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Jul 2005, Ingo Molnar wrote:

> this patch reduces ip_setsockopt's stack footprint from 572 bytes to 164 
> bytes. (Note: needs review and testing as i could not excercise this 
> multicast codepath.)

This patch breaks multicast source group joins.  Here's the fix:

--- linux.old/net/ipv4/ip_sockglue.c	2005-07-11 01:50:19.000000000 -0700
+++ linux/net/ipv4/ip_sockglue.c	2005-07-11 13:54:34.000000000 -0700
@@ -738,7 +738,7 @@
 				break;
 			if (optlen != sizeof(struct group_source_req))
 				goto free_greqs_e_inval;
-			if (copy_from_user(&greqs, optval, sizeof(*greqs))) {
+			if (copy_from_user(greqs, optval, sizeof(*greqs))) {
 				err = -EFAULT;
 				goto free_greqs_break;
 			}

Cheers,
--ww
