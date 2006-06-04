Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWFDDtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWFDDtf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 23:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWFDDtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 23:49:35 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:3290 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932092AbWFDDte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 23:49:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=bAFCfQ1cvtM5QLtcvwxlfkn5V+i4Un2CzKLQMd8YdreLiBDDDFLqN3y34xwg3FgBopfbmnr5QdmaqcKR/Eb+PM1+Ku9yLfLucKuksk3ePdzH95COvk8uDutY9fKthgtGXxznG5PApXWKI2N/wUH/t35MBJ7n9U8SJBS14JxBuF0=
Date: Sun, 4 Jun 2006 12:49:16 +0900
From: Tejun Heo <htejun@gmail.com>
To: Jens Axboe <axboe@suse.de>, James Bottomley <James.Bottomley@SteelEye.com>,
       Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       mattjreimer@gmail.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       rmk@arm.linux.org.uk, lkml <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/5] (REPOST) arm: implement flush_kernel_dcache_page()
Message-ID: <20060604034916.GD8106@htj.dyndns.org>
References: <1149392479501-git-send-email-htejun@gmail.com> <1149392479281-git-send-email-htejun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149392479281-git-send-email-htejun@gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement flush_kernel_dcache_page() for arm.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Sorry, the patch contained in the previous post was generated against
the wrong base.  Please ignore it.

 include/asm-arm/cacheflush.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

fad719d62838161fb0d6f306c6e060f8ef2ddfd0
diff --git a/include/asm-arm/cacheflush.h b/include/asm-arm/cacheflush.h
index 746be56..7ab6ec3 100644
--- a/include/asm-arm/cacheflush.h
+++ b/include/asm-arm/cacheflush.h
@@ -331,6 +331,12 @@ #define flush_dcache_mmap_lock(mapping)
 #define flush_dcache_mmap_unlock(mapping) \
        write_unlock_irq(&(mapping)->tree_lock)

+static inline void flush_kernel_dcache_page(struct page *page)
+{
+       __cpuc_flush_dcache_page(page_address(page));
+}
+#define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+
 #define flush_icache_user_range(vma,page,addr,len) \
        flush_dcache_page(page)

--
1.3.2
