Return-Path: <linux-kernel-owner+w=401wt.eu-S1423161AbWLVAmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423161AbWLVAmR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 19:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423160AbWLVAmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 19:42:17 -0500
Received: from ip127.bb146.pacific.net.hk ([202.64.146.127]:51906 "EHLO
	mailhub.stlglobal.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423157AbWLVAmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 19:42:16 -0500
X-Greylist: delayed 3025 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 19:42:16 EST
Message-ID: <458B1E06.1030209@tausq.org>
Date: Fri, 22 Dec 2006 07:51:34 +0800
From: Randolph Chung <randolph@tausq.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
CC: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
 that again
References: <20061221152621.GB3958@flint.arm.linux.org.uk> <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu> <20061221171739.GE3958@flint.arm.linux.org.uk> <E1GxS8x-0000q5-00@dorka.pomaz.szeredi.hu> <20061221181156.GG3958@flint.arm.linux.org.uk> <E1GxSgF-0000uV-00@dorka.pomaz.szeredi.hu> <20061221185512.GH3958@flint.arm.linux.org.uk> <E1GxTED-0000yy-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1GxTED-0000yy-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I understand now.  I'm not sure how the PARISC implementation can be
> correct in this light.

According to cachetlb.txt:

   void flush_anon_page(struct page *page, unsigned long vmaddr)
         When the kernel needs to access the contents of an anonymous
         page, it calls this function (currently only
         get_user_pages()).  Note: flush_dcache_page() deliberately
         doesn't work for an anonymous page.  The default
         implementation is a nop (and should remain so for all coherent
         architectures).  For incoherent architectures, it should flush
         the cache of the page at vmaddr in the current user process.
                                                ^^^^^^^^^^^^^^^^^^^^

Is the documentation wrong?

randolph
