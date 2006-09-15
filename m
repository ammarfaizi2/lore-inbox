Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWIONvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWIONvV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWIONvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:51:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:49707 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751457AbWIONvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:51:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=pKzifx4d3k+ktdTNnhbIdTDFoNv6CAtjGFLM4Zxo6ascYe5L9bX1dk0n5/PNxgH7/3Z78JTkWbcgAOG/Q/qgHMDP7BaQF4oo7tV9Nt+i8uw/pdnmNobwQbHeGR1o/qrqV4CkOtaF+MP14p89xlDo6uORfPTaeqs/Spo2mBiDWlQ=
Date: Fri, 15 Sep 2006 15:50:23 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: cachefiles on latest -mm fails to build on powerpc
Message-ID: <20060915155023.GC2876@slug>
References: <20060915123132.GA4817@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060915123132.GA4817@cathedrallabs.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 09:31:34AM -0300, Aristeu Sergio Rozanski Filho wrote:
> currently on latest -mm, cachefiles fail to compile on powerpc
> (ARCH=powerpc) at least:
> 
>   MODPOST 592 modules
>   WARNING: "copy_page" [fs/cachefiles/cachefiles.ko] undefined!
>   make[1]: *** [__modpost] Error 1
>   make: *** [modules] Error 2
> 
> config file attached
> 
Does the following patch help?

Thanks,
Frederik


diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index b151c53..703dbaf 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -4,6 +4,7 @@ #define _LINUX_HIGHMEM_H
 #include <linux/fs.h>
 #include <linux/mm.h>
 
+#include <asm/page.h>
 #include <asm/cacheflush.h>
 
 #ifndef ARCH_HAS_FLUSH_ANON_PAGE
