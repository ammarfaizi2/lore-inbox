Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUJLODb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUJLODb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUJLOBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:01:53 -0400
Received: from [213.146.154.40] ([213.146.154.40]:51603 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263818AbUJLOBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:01:18 -0400
Subject: Re: [PATCH] PPC64 Replace cmp instructions with cmpw/cmpd
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, torvalds@osdl.org, anton@samba.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
In-Reply-To: <16742.10154.523798.177319@cargo.ozlabs.ibm.com>
References: <16742.10154.523798.177319@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1097589670.318.428.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 12 Oct 2004 15:01:10 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 15:37 +1000, Paul Mackerras wrote:
> This patch replaces cmp{,l}{,i} with cmp{,l}[wd]{,i} as appropriate.
> The original patch was from Segher Boessenkool, slightly modified by
> me.  Please apply.

And another....

Signed-Off-By: David Woodhouse <dwmw2@infradead.org>

===== arch/ppc64/mm/hash_low.S 1.7 vs edited =====
--- 1.7/arch/ppc64/mm/hash_low.S	Thu Oct  7 22:52:16 2004
+++ edited/arch/ppc64/mm/hash_low.S	Tue Oct 12 14:01:25 2004
@@ -263,7 +263,7 @@
 	/* if we failed because typically the HPTE wasn't really here
 	 * we try an insertion. 
 	 */
-	cmpi	0,r3,-1
+	cmpdi	0,r3,-1
 	beq-	htab_insert_pte
 
 	/* Clear the BUSY bit and Write out the PTE */


-- 
dwmw2

