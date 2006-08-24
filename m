Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWHXCyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWHXCyh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 22:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWHXCyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 22:54:37 -0400
Received: from smtp-out.google.com ([216.239.45.12]:57930 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030221AbWHXCyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 22:54:37 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:to:subject:cc:message-id:date:from;
	b=UKfJTNawVlGBu3A4rim63LOS/cx/zMk9VYxmPvklqJF+Lbx+MunBypXaeRwUv0uhR
	PC8Nla+KQeiNgBo/pz7XA==
To: davidel@xmailserver.org
Subject: eventpoll.c compile fix
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-Id: <20060824025425.219471FAC65E@localhost>
Date: Wed, 23 Aug 2006 19:54:25 -0700 (PDT)
From: masouds@google.com (Masoud Asgharifard Sharbiani)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
The following patch fixes two compile failures in eventpoll.c code which would 
happen if DEBUG_EPOLL is bigger than zero.
cheers,
Masoud

Signed off by: Masoud Sharbiani <masouds@google.com>

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 19ffb04..3a35674 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1168,7 +1168,7 @@ static int ep_unlink(struct eventpoll *e
 eexit_1:
 
 	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: ep_unlink(%p, %p) = %d\n",
-		     current, ep, epi->file, error));
+		     current, ep, epi->ffd.file, error));
 
 	return error;
 }
@@ -1236,7 +1236,7 @@ static int ep_poll_callback(wait_queue_t
 	struct eventpoll *ep = epi->ep;
 
 	DNPRINTK(3, (KERN_INFO "[%p] eventpoll: poll_callback(%p) epi=%p ep=%p\n",
-		     current, epi->file, epi, ep));
+		     current, epi->ffd.file, epi, ep));
 
 	write_lock_irqsave(&ep->lock, flags);
 
