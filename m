Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267553AbUIUJ4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUIUJ4J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 05:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267551AbUIUJ4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 05:56:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:2269 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267553AbUIUJ4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 05:56:06 -0400
Date: Tue, 21 Sep 2004 02:53:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: sct@redhat.com, gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: journal aborted, system read-only
Message-Id: <20040921025356.38b2b550.akpm@osdl.org>
In-Reply-To: <20040921015020.7372faac.akpm@osdl.org>
References: <200409121128.39947.gene.heskett@verizon.net>
	<1095088378.2765.18.camel@sisko.scot.redhat.com>
	<20040921015020.7372faac.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> This should fix.

scrub that, it hangs.  Third time lucky.

--- 25/kernel/wait.c~wait_on_bit-must-loop	2004-09-21 01:57:14.000000000 -0700
+++ 25-akpm/kernel/wait.c	2004-09-21 02:48:18.596420024 -0700
@@ -157,7 +157,7 @@ __wait_on_bit(wait_queue_head_t *wq, str
 	int ret = 0;
 
 	prepare_to_wait(wq, &q->wait, mode);
-	if (test_bit(q->key.bit_nr, q->key.flags))
+	while (test_bit(q->key.bit_nr, q->key.flags) && !ret)
 		ret = (*action)(q->key.flags);
 	finish_wait(wq, &q->wait);
 	return ret;
_

