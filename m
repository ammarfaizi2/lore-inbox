Return-Path: <linux-kernel-owner+w=401wt.eu-S1751583AbWL2LHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWL2LHI (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 06:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbWL2LHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 06:07:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:47810 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbWL2LHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 06:07:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=OBkEKP7O0jSJHUrw/oaUC6ALW8A+7BSj1P3yvNWLnkkdrl4egE4B97Gm2i7U0eHLVMq+hwz9z2rLyLtUSsHorn1Wy5lXfx+/ZbR+vO9sg4Pyqrgcbg97MG/6u9FDkAHpbT2qdVppuEoi2WM08DusPPXQ6eqzyD/s3um/qQFMj4A=
Date: Fri, 29 Dec 2006 11:05:18 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] add KM_SKB_DATA_SOFTIRQ to kmap_atomic debugging
Message-ID: <20061229110518.GB1441@slug>
References: <20061228024237.375a482f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228024237.375a482f.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 02:42:37AM -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc2/2.6.20-rc2-mm1/
> 
Andrew,

The kmap_atomic-debugging patch checks twice for (type !=
KM_SKB_SUNRPC_DATA). The right check would be to look for
KM_SKB_DATA_SOFTIRQ, as added by the following patch.  I've read the
mail, in which you mentioned that you spotted a copy-n-paste error in
kmap_atomic, I suppose that you refered to this, but just in case...

Regards,
Frederik

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

diff --git a/arch/i386/mm/highmem.c b/arch/i386/mm/highmem.c
index 1344c98..51e4205 100644
--- a/arch/i386/mm/highmem.c
+++ b/arch/i386/mm/highmem.c
@@ -46,7 +46,7 @@ void *kmap_atomic(struct page *page, enum km_type type)
 			if (type != KM_IRQ0 && type != KM_IRQ1 &&
 			    type != KM_SOFTIRQ0 && type != KM_SOFTIRQ1 &&
 			    type != KM_SKB_SUNRPC_DATA &&
-			    type != KM_SKB_SUNRPC_DATA) {
+			    type != KM_SKB_DATA_SOFTIRQ) {
 				WARN_ON(1);
 				warn_count--;
 			}
