Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265650AbTF2MtF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 08:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265651AbTF2MtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 08:49:05 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:24524 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S265650AbTF2MtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 08:49:02 -0400
Message-ID: <3EFEE38C.1070307@colorfullife.com>
Date: Sun, 29 Jun 2003 15:03:08 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Oops in __change_page_attr Re: (was 2.5.73-mm2)
References: <Pine.LNX.4.53.0306290806230.1878@montezuma.mastecende.com> <Pine.LNX.4.53.0306290830080.1878@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.53.0306290830080.1878@montezuma.mastecende.com>
Content-Type: multipart/mixed;
 boundary="------------010509080307030806070302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010509080307030806070302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Could you try the attached patch?
The code tries to map/unmap highmem pages on the fly, and that fails, 
because highmem pages are never mapped.

--
    Manfred

--------------010509080307030806070302
Content-Type: text/plain;
 name="patch-dbg-4-unmap-fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-dbg-4-unmap-fix"

--- 2.5/arch/i386/mm/pageattr.c	2003-06-29 14:45:19.000000000 +0200
+++ build-2.5/arch/i386/mm/pageattr.c	2003-06-29 14:58:11.000000000 +0200
@@ -197,6 +197,8 @@
 #ifdef CONFIG_DEBUG_PAGEALLOC
 void kernel_map_pages(struct page *page, int numpages, int enable)
 {
+	if (page >= highmem_start_page) 
+		return;
 	/* the return value is ignored - the calls cannot fail,
 	 * large pages are disabled at boot time.
 	 */

--------------010509080307030806070302--

