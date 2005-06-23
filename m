Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262706AbVFWVRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbVFWVRK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVFWVNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:13:08 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:7184 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262636AbVFWVMc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:12:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=goj+Sa0vY68oDjcdMFz8s0MTg2UgHCKqw0pbI2j0rqKlXJEL/vpzyGAY/qz7AFxIkxbl80WhwuK3wegPbgeXNtSoII3nkk1joWNoIgqfhwDvEshnqofDxlEIq1cvBapuCzqZXahwPYxXN8e80stqtpoKErgtVnd99ZWgE/n+KYc=
Message-ID: <9e4733910506231412651fda6e@mail.gmail.com>
Date: Thu, 23 Jun 2005 17:12:23 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: REPOST PATCH: hpet_do_div.patch
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not appear to be in the mm or linus kernel. It has
been approved by the HPET maintainer.

On 6/14/05, Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> wrote:
> 
> Yes. It has to be plain '/' instead of do_div. Even the
> femto second quantity is guaranteed to fit in 32 bit
> variable here.
> 
> Thanks,
> Venki

--
Jon Smirl
jonsmirl@gmail.com

#Use correct div on 32 bits
#Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -834,7 +834,7 @@ int hpet_alloc(struct hpet_data *hdp)
 	printk("\n");
 
 	ns = hpetp->hp_period;	/* femptoseconds, 10^-15 */
-	do_div(ns, 1000000);	/* convert to nanoseconds, 10^-9 */
+	ns /= 1000000;		/* convert to nanoseconds, 10^-9 */
 	printk(KERN_INFO "hpet%d: %ldns tick, %d %d-bit timers\n",
 		hpetp->hp_which, ns, hpetp->hp_ntimer,
 		cap & HPET_COUNTER_SIZE_MASK ? 64 : 32);
