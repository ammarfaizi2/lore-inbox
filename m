Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292275AbSBTUCM>; Wed, 20 Feb 2002 15:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292276AbSBTUCF>; Wed, 20 Feb 2002 15:02:05 -0500
Received: from petreley.org ([64.170.109.178]:28044 "EHLO petreley.com")
	by vger.kernel.org with ESMTP id <S292275AbSBTUBq>;
	Wed, 20 Feb 2002 15:01:46 -0500
Date: Wed, 20 Feb 2002 12:01:35 -0800
From: Nicholas Petreley <nicholas@petreley.com>
To: linux-kernel@vger.kernel.org
Subject: Re: patch to NVIDIA_kernel & kernel 2.5.5
Message-ID: <20020220200135.GA706@petreley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think you may not have meant to do this part of the patch in nv.c:

+/*         
             if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED))
+*/
+           if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
                return -EAGAIN;


How about this instead:

+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
             if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED))
                  return -EAGAIN;
+#else
+            if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
+                 return -EAGAIN;
+#endif




-- 
***********************************************************
Nicholas Petreley        http://www.VarLinux.org
nicholas@petreley.com    http://www.computerworld.com
http://www.petreley.org  http://www.linuxworld.com Eph 6:12
***********************************************************
