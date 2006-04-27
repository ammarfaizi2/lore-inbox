Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWD0GMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWD0GMl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 02:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWD0GMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 02:12:41 -0400
Received: from pproxy.gmail.com ([64.233.166.178]:24191 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964951AbWD0GMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 02:12:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=nzEXmFmmORMQy1M2cULtvEsJ8/0KkolHyvqbhgFM2xwI7SLCTD3PuIZlgoOqCyCGq48bdUFDmpWILuDPEFOgxyeYTjfwu5feYf5AqVT6tJbYWr80qMl63cJA9RiCVjU5DzPKr+gcJYXXqisw3W9Sw2Zd8VLs2fSnqOByyS9SlGI=
Date: Wed, 26 Apr 2006 23:10:50 -0700 (PDT)
To: akpm@osdl.org, dwalker@mvista.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Profile likely/unlikely macros -v2
In-Reply-To: <Pine.LNX.4.64.0604262156100.11930@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0604262309190.2329@localhost.localdomain>
References: <Pine.LNX.4.64.0604262156100.11930@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From: Hua Zhong <hzhong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, this seems a better fix. Clearly the unlikely and that particular kmalloc don't play well together. However, the same setup a couple of lines later have no issue.

Signed-off-by: Hua Zhong <hzhong@gmail.com>

diff --git a/arch/i386/kernel/cpu/intel_cacheinfo.c b/arch/i386/kernel/cpu/intel_cacheinfo.c
index c8547a6..9dfcf0e 100644
--- a/arch/i386/kernel/cpu/intel_cacheinfo.c
+++ b/arch/i386/kernel/cpu/intel_cacheinfo.c
@@ -572,7 +572,7 @@ static int __cpuinit cpuid4_cache_sysfs_
 
 	/* Allocate all required memory */
 	cache_kobject[cpu] = kmalloc(sizeof(struct kobject), GFP_KERNEL);
-	if (unlikely(cache_kobject[cpu] == NULL))
+	if (cache_kobject[cpu] == NULL)
 		goto err_out;
 	memset(cache_kobject[cpu], 0, sizeof(struct kobject));
 
