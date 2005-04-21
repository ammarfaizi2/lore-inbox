Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVDUAo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVDUAo4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 20:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVDUAo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 20:44:56 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:19339
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261864AbVDUAoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 20:44:54 -0400
Date: Wed, 20 Apr 2005 17:38:20 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Tom Duffy <tduffy@sun.com>
Cc: roland@topspin.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH][MTHCA] fix sparc build WAS: Re: [openib-general]
 [PATCH][RFC][3/4] IB: userspace verbs mthca changes
Message-Id: <20050420173820.24c512ae.davem@davemloft.net>
In-Reply-To: <1114043831.18198.17.camel@duffman>
References: <200544159.AzH1nqpM3uTQZaKG@topspin.com>
	<1114043831.18198.17.camel@duffman>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2005 17:37:11 -0700
Tom Duffy <tduffy@sun.com> wrote:

> This breaks building on sparc64:
 ...
> This is ugly, but fixes the build.  Perhaps sparc needs
> pgprot_noncached() to be a noop?

No, it should actually do something, like so:

include/asm-sparc64/pgtable.h: af9bf175a223cf44310293287d50302e0fd3f9e9
--- a/include/asm-sparc64/pgtable.h
+++ b/include/asm-sparc64/pgtable.h
@@ -416,6 +416,11 @@ extern int io_remap_pfn_range(struct vm_
 			       unsigned long pfn,
 			       unsigned long size, pgprot_t prot);
 
+/* Clear virtual and physical cachability, set side-effect bit.  */
+#define pgprot_noncached(prot) \
+	(__pgprot((pgprot_val(prot) & ~(_PAGE_CP | _PAGE_CV)) | \
+	 _PAGE_E))
+
 /*
  * For sparc32&64, the pfn in io_remap_pfn_range() carries <iospace> in
  * its high 4 bits.  These macros/functions put it there or get it from there.
