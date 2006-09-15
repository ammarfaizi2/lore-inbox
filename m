Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWIOP7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWIOP7z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 11:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWIOP7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 11:59:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:5774 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932116AbWIOP7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 11:59:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=SjK1MXk62+RWWOD0e9nEYc8li17TFK6sgovz/rDDWO4k++x3St0iPBYYq/y3P+wjEiStdgyMN6cH/cVsfLW8YkXSChCtqq9kLDS/ZtniEl65QmNiSbaKkV392hZTGq3cawyhw1iZCrqGC7hahtWYdhHIJUhFHc4ACf6TGW2A9G0=
Date: Fri, 15 Sep 2006 17:58:56 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: David Howells <dhowells@redhat.com>
Cc: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [-mm patch] add missing page_copy export for ppc and powerpc (was Re: cachefiles on latest -mm fails to build on powerpc)
Message-ID: <20060915175856.GF2876@slug>
References: <20060915173546.GE2876@slug> <20060915123132.GA4817@cathedrallabs.org> <20060915155023.GC2876@slug> <20060915151724.GA8098@cathedrallabs.org> <5069.1158334773@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5069.1158334773@warthog.cambridge.redhat.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 04:39:33PM +0100, David Howells wrote:
> Frederik Deweerdt <deweerdt@free.fr> wrote:
> 
> > +EXPORT_SYMBOL(copy_page);
> 
> But only if !__powerpc64__.  Otherwise you need copy_4K_page to be exported
> instead.
> 
Oops, thanks, here's a corrected patch. From a quick look, it seems that
the ppc needs the same kind of export.
This adds a missing copy_page export for the powerpc and ppc arches.

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 39d3bfc..23ccd5d 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -93,6 +93,12 @@ EXPORT_SYMBOL(__strncpy_from_user);
 EXPORT_SYMBOL(__strnlen_user);
 
 #ifndef  __powerpc64__
+EXPORT_SYMBOL(copy_page);
+#else
+EXPORT_SYMBOL(copy_4K_page);
+#endif
+
+#ifndef  __powerpc64__
 EXPORT_SYMBOL(__ide_mm_insl);
 EXPORT_SYMBOL(__ide_mm_outsw);
 EXPORT_SYMBOL(__ide_mm_insw);
diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
index d173540..3045cc3 100644
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -106,6 +106,8 @@ EXPORT_SYMBOL(__clear_user);
 EXPORT_SYMBOL(__strncpy_from_user);
 EXPORT_SYMBOL(__strnlen_user);
 
+EXPORT_SYMBOL(copy_page);
+
 /*
 EXPORT_SYMBOL(inb);
 EXPORT_SYMBOL(inw);
