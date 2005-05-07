Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVEGCD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVEGCD1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 22:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVEGCD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 22:03:27 -0400
Received: from fire.osdl.org ([65.172.181.4]:52361 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261502AbVEGCDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 22:03:23 -0400
Date: Fri, 6 May 2005 19:02:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: juhl-lkml@dif.dk, linux-kernel@vger.kernel.org, eokerson@quicknet.net,
       joe@perches.com
Subject: Re: [PATCH] kfree cleanups (remove redundant NULL checks) in
 drivers/telephony/ (actually ixj.c only)
Message-Id: <20050506190212.0d6a5300.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0505070345430.2384@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0505070254180.2384@dragon.hyggekrogen.localhost>
	<Pine.LNX.4.62.0505070345430.2384@dragon.hyggekrogen.localhost>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds behavioural changes:

-		if (j->read_buffer) {
-			kfree(j->read_buffer);
-			j->read_buffer = NULL;
-			j->read_buffer_size = 0;
-		}
+		j->read_buffer = NULL;
+		j->read_buffer_size = 0;

Now we'll zero ->read_buffer_size even if ->read_buffer was already NULL.

It's hard to believe that this could cause any problems, but please check
that.

