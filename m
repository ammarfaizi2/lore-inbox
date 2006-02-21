Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161469AbWBUKip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161469AbWBUKip (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 05:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161471AbWBUKip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 05:38:45 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:8982 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161470AbWBUKio convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 05:38:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DljqgKKOz037E69USHu/UZVVEk8zIhl3IHR1Um+V7b+qJMBw+d+2guDsVj0FfEB9qYLDbpoNch/aqebGvYVqE0Bihi7xLW/kAvQ6DzGFIhB9+bH+lhZnKipPEmzXBemXEQOd3EvX6GK7iP6qL/NfHIuB4R3gFkpzxfpbdFd8IH0=
Message-ID: <5b7f8a0d0602210238y46bdcfb9i4189331abfdec280@mail.gmail.com>
Date: Tue, 21 Feb 2006 16:08:43 +0530
From: nkml00 <nkml00@gmail.com>
To: trivial@kernel.org
Subject: Re: [PATCH] trivial: unneeded zero adding to per_cpu_pages->count
Cc: linux-kernel@vger.kernel.org, nkml00@gmail.com
In-Reply-To: <5b7f8a0d0602210215p60039c6fp5f7c7f94daed891b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5b7f8a0d0602210215p60039c6fp5f7c7f94daed891b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/06, nkml00 <nkml00@gmail.com> wrote:
> Unneeded addition (of zero). Compiler could optimize this, but "looks" illogical
>

Sorry, patch was not in patch -p1 format.

--- l1/mm/page_alloc.c-orig	2006-02-21 12:03:52.000000000 -0800
+++ l2/mm/page_alloc.c	2006-02-21 12:49:45.000000000 -0800
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
