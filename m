Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422872AbWJRU0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422872AbWJRU0x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422889AbWJRU0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:26:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:19852 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422904AbWJRU0v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:26:51 -0400
Message-ID: <45368E0A.1030503@fr.ibm.com>
Date: Wed, 18 Oct 2006 22:26:50 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, Gabriel C <nix.or.die@googlemail.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc2-mm1
References: <20061016230645.fed53c5b.akpm@osdl.org> <45367210.4040507@googlemail.com> <200610182118.31371.rjw@sisk.pl> <4536818E.3060505@fr.ibm.com> <453683A6.9090106@yahoo.com.au>
In-Reply-To: <453683A6.9090106@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This fix will work. You should really call the non atomic version
> though, just so it is clear (and maybe some architectures care).

ok. I've updated the patch.

> Because we must service a fault if it happens here. The
> fault_in_pages_readable and comments are wrong AFAIKS.

hmm. It says :

		/*
		 * Bring in the user page that we will copy from _first_.
		 * Otherwise there's a nasty deadlock on copying from the
		 * same page as we're writing to, without it being marked
		 * up-to-date.
		 */

How can we improve it ? 

thanks,


C.


Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>
---
 mm/filemap_xip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: 2.6.19-rc2-mm1/mm/filemap_xip.c
===================================================================
--- 2.6.19-rc2-mm1.orig/mm/filemap_xip.c
+++ 2.6.19-rc2-mm1/mm/filemap_xip.c
@@ -317,7 +317,7 @@ __xip_file_write(struct file *filp, cons
                        break;
                }

-               copied = filemap_copy_from_user(page, offset, buf, bytes);
+               copied = filemap_copy_from_user_nonatomic(page, offset, buf, bytes);
                flush_dcache_page(page);
                if (likely(copied > 0)) {
                        status = copied;

