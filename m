Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262597AbUKLRA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbUKLRA4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 12:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbUKLQ7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 11:59:01 -0500
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:33806 "EHLO
	smtp-vbr3.xs4all.nl") by vger.kernel.org with ESMTP id S262592AbUKLQ6f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 11:58:35 -0500
Date: Fri, 12 Nov 2004 17:58:10 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Libor Vanek <libor@conet.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Highmem fails to compile with 2.6.10-rc1-mm5
Message-ID: <20041112165810.GA28664@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <4194C9A3.6080106@conet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4194C9A3.6080106@conet.cz>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Libor Vanek <libor@conet.cz>
Date: Fri, Nov 12, 2004 at 03:33:07PM +0100
> Hi,
> I got problems when compiling latest 2.6.10-rc1-mm5 with enabled 
> highmem  (set to 4GB). I got this error:
> 
>  CC      arch/i386/mm/mmap.o
>  CC      arch/i386/mm/highmem.o
> arch/i386/mm/highmem.c:96: error: conflicting types for 
> 'kmap_atomic_to_page'
> include/asm/highmem.h:65: error: previous declaration of 
> 'kmap_atomic_to_page' was here
> arch/i386/mm/highmem.c:96: error: conflicting types for 
> 'kmap_atomic_to_page'
> include/asm/highmem.h:65: error: previous declaration of 
> 'kmap_atomic_to_page' was here
> make[1]: *** [arch/i386/mm/highmem.o] Error 1
> make: *** [arch/i386/mm] Error 2
> 
> I got gcc 3.4.2 (Fedora rawhide). I attach my .config.
> 
A patch was posted:


From: Andrew Morton <akpm@osdl.org>

Needs a fixup for CONFIG_HIGHMEM

--- linux-bix/include/asm/highmem.h~a	2004-11-11 03:07:37.105728944 -0800
+++ linux-bix-akpm/include/asm/highmem.h	2004-11-11 03:07:49.511842928 -0800
@@ -62,7 +62,7 @@ void kunmap(struct page *page);
 char *kmap_atomic(struct page *page, enum km_type type);
 void kunmap_atomic(char *kvaddr, enum km_type type);
 char *kmap_atomic_pfn(unsigned long pfn, enum km_type type);
-struct page *kmap_atomic_to_page(void *ptr);
+struct page *kmap_atomic_to_page(char *ptr);
 
 #define flush_cache_kmaps()	do { } while (0)
 
Also, to prevent needlessly large messages, could you filter out all the
'is not set' lines when posting your .config? They are not necessary for
anybody. Just grep "=" /usr/src/linux-x.x.xx/.config and you'll save
lots of bandwidth.

Kind regards,
Jurriaan
-- 
And you have the right to free speech, as long as you're not dumb
enough, to actually try it...
        The Clash - Know Your Rights
Debian (Unstable) GNU/Linux 2.6.9-mm1 2x6078 bogomips load 0.22
