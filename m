Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVF2Exj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVF2Exj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 00:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVF2Exj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 00:53:39 -0400
Received: from [213.184.187.99] ([213.184.187.99]:44036 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S262278AbVF2Exg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 00:53:36 -0400
Message-Id: <200506290453.HAA14580@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Kswapd flaw
Date: Wed, 29 Jun 2005 07:53:14 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20050628143932.GA14545@logos.cnet>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcV8HlGc65gGM+IAQyG9LSrqtDxJgwARSo6Q
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo wrote: {
On Tue, Jun 28, 2005 at 11:00:14PM +0300, Al Boldi wrote:
> Hi,
> I read Documentation/vm/overcommit-accounting, thank you!
> It's for 2.6. Values are 0,1,2. What is needed is 2.
> In 2.4 values are 0,1. What is needed is 0, which is default, which is 
> the problem.
> Kswapd overcommits anyway.
> Can this be fixed/adjusted?

Can you please try this

--- linux-2.4.30/mm/mmap.c.orig 2005-06-28 17:15:27.000000000 -0300
+++ linux-2.4.30/mm/mmap.c      2005-06-28 17:15:29.000000000 -0300
@@ -70,7 +70,7 @@
            return 1;

        /* The page cache contains buffer pages these days.. */
-       free = page_cache_size;
+//     free = page_cache_size;
        free += nr_free_pages();
        free += nr_swap_pages;

> CONFIG_OOM_KILLER does not disable/enable OOM-Killer.
> It merely selects a different style of killing.

What you mean? What happens if you disable CONFIG_OOM_KILLER?
}

1. Thanks for the patch pointer. Can someone work on this?

2 .You only need OOM-Killer if you overcommit.


