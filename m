Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVJDJhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVJDJhE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 05:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVJDJhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 05:37:04 -0400
Received: from xproxy.gmail.com ([66.249.82.201]:18418 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751203AbVJDJhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 05:37:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=de4ZkwaaAg5QDdM9oteblDyo/DpeNo0TREDVpgGCkOks+tKBfAHQFjx6buMm24uFvNTS1sReCzvrDh5lU/T0ip+Ql5txy8X2wJlD2C8NFnyKk8KpvdI3s7cDm4uO+W+vExLXGPe3nw5kp9lcaceMIS94upBCowNqlgzI3itwMuE=
Date: Tue, 4 Oct 2005 18:36:54 +0900
From: Tejun Heo <htejun@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH linux-2.6] vm: remove redundant assignment from __pagevec_release_nonlru()
Message-ID: <20051004093654.GA30986@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Andrew.

 This patch removes redundant assignment from
__pagevec_release_nonlru().  pages_to_free.cold is set to pvec->cold
by pagevec_init() call right above the assignment.

 Thanks.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/mm/swap.c b/mm/swap.c
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -270,7 +270,6 @@ void __pagevec_release_nonlru(struct pag
 	struct pagevec pages_to_free;
 
 	pagevec_init(&pages_to_free, pvec->cold);
-	pages_to_free.cold = pvec->cold;
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
 
