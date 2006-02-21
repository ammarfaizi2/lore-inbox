Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932726AbWBUKPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726AbWBUKPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 05:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbWBUKPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 05:15:19 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:51532 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932726AbWBUKPT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 05:15:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fdiLaf1i/hZAL+oQhiN4ymSlyrPen+xU4LjH7Nyn56SVXqpULYZ7BETu8BeOgQGyA/UnDyAuVZTcQi2uqa+dwerICxX8fMUe9PLdYL+1lVnl51C5/nvYq1SnGrtHfsQekPVuW672zv7wEQ4W48HWsnqq0M7U0ak1M3hWG9xIOJQ=
Message-ID: <5b7f8a0d0602210215p60039c6fp5f7c7f94daed891b@mail.gmail.com>
Date: Tue, 21 Feb 2006 15:45:18 +0530
From: nkml00 <nkml00@gmail.com>
To: trivial@kernel.org
Subject: [PATCH] trivial: unneeded zero adding to per_cpu_pages->count
Cc: linux-kernel@vger.kernel.org, nkml00@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unneeded addition (of zero). Compiler could optimize this, but "looks" illogical

--- page_alloc.c-orig	2006-02-21 12:03:52.000000000 -0800
+++ page_alloc.c	2006-02-21 12:49:45.000000000 -0800
@@ -774,7 +774,7 @@ again:
 		pcp = &zone_pcp(zone, cpu)->pcp[cold];
 		local_irq_save(flags);
 		if (!pcp->count) {
-			pcp->count += rmqueue_bulk(zone, 0,
+			pcp->count = rmqueue_bulk(zone, 0,
 						pcp->batch, &pcp->list);
 			if (unlikely(!pcp->count))
 				goto failed;

Signed-off-by: nkml00 <nkml00@gmail.com>
