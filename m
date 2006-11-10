Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946745AbWKJQff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946745AbWKJQff (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946773AbWKJQff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:35:35 -0500
Received: from ns1.suse.de ([195.135.220.2]:53713 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1946745AbWKJQfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:35:34 -0500
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: 2.6.19-rc5: Bad page state in process 'swapper'
Date: Fri, 10 Nov 2006 17:35:29 +0100
User-Agent: KMail/1.9.5
Cc: Andre Noll <maan@systemlinux.org>, linux-kernel@vger.kernel.org
References: <20061110121151.GC29040@skl-net.de> <20061110133633.GE29040@skl-net.de> <20061110161005.GF29040@skl-net.de>
In-Reply-To: <20061110161005.GF29040@skl-net.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611101735.29828.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 November 2006 17:10, Andre Noll wrote:
> On 14:36, Andre Noll wrote:
> 
> > > Does it help when you apply 
> > > 
> > > ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/e820-small-entries ? 
> > 
> > OK I will try this. Can't promise if I will be able to do so today, as I
> > have to wait until the currently running jobs are finished.
> 
> I could check it already today: Your patch doesn't help unfortunately,
> i.e. I get the same "Bad page state in process 'swapper'" messages also
> with this patch. Again, nothing containing "e820" in the log.

If you apply the following debug patch you should get a shorter log.
Can you post it please?

-Andi

Index: linux/mm/page_alloc.c
===================================================================
--- linux.orig/mm/page_alloc.c
+++ linux/mm/page_alloc.c
@@ -188,6 +188,11 @@ static inline int bad_range(struct zone 
 
 static void bad_page(struct page *page)
 {
+	static int flag;
+	if (flag)
+		return;
+	flag = 1;
+
 	printk(KERN_EMERG "Bad page state in process '%s'\n"
 		KERN_EMERG "page:%p flags:0x%0*lx mapping:%p mapcount:%d count:%d\n"
 		KERN_EMERG "Trying to fix it up, but a reboot is needed\n"
