Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbVEVTrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbVEVTrb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 15:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVEVTrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 15:47:31 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:43102 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261275AbVEVTr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 15:47:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=lo24WPf4/dBh9tUCfQ4PO7L+uzk/yww2TJqhHxGNuE4TN8c5Htq7AXvCH537idblSnzyrm0iTHnjTtL1Ue/vfFJGvxnqwV+bDKJFbsLNOsNfsj8G8hW6G3zDO6AvLTla7c9TtSouZvyAhg7Cx6sLPSgc//0d0RzOHJ01Wwyy5uU=
Message-ID: <4290E1C6.9070709@gmail.com>
Date: Sun, 22 May 2005 21:47:18 +0200
From: Eric BEGOT <eric.begot@gmail.com>
Reply-To: eric.begot@gmail.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH] UML - 2.6.12-rc4-mm2 Compile error
References: <200505201436.j4KEZxjh006235@ccure.user-mode-linux.org>
In-Reply-To: <200505201436.j4KEZxjh006235@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch to correct a compile error on linux 2.6.12-rc4-mm2 for uml.
At the compilation of init/main.c, it complains because it doens't find 
the 2 constants FIXADDR_USER_START and FIXADDR_USER_END


--- linux-2.6.12-rc4-mm2/include/asm/fixmap.h.orig 2005-05-22 
21:37:13.000000000 +0200
+++ linux-2.6.12-rc4-mm2/include/asm/fixmap.h 2005-05-22 
21:38:17.000000000 +0200
@@ -60,7 +60,8 @@ extern unsigned long get_kmem_end(void);

#define FIXADDR_TOP (get_kmem_end() - 0x2000)
#define FIXADDR_SIZE (__end_of_fixed_addresses << PAGE_SHIFT)
-#define FIXADDR_START (FIXADDR_TOP - FIXADDR_SIZE)
+#define FIXADDR_USER_START (FIXADDR_TOP - FIXADDR_SIZE)
+#define FIXADDR_USER_END FIXADDR_TOP

#define __fix_to_virt(x) (FIXADDR_TOP - ((x) << PAGE_SHIFT))
#define __virt_to_fix(x) ((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
@@ -91,7 +92,7 @@ static inline unsigned long fix_to_virt(

static inline unsigned long virt_to_fix(const unsigned long vaddr)
{
- BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
+ BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_USER_START);
return __virt_to_fix(vaddr);
}

