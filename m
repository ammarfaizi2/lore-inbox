Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbTEZRpE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTEZRpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:45:04 -0400
Received: from pointblue.com.pl ([62.89.73.6]:32529 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261918AbTEZRpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:45:02 -0400
Subject: OUPS 2.5.69-bk19 coda-inode.c/slab.c
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: lkml <linux-kernel@vger.kernel.org>
Cc: jaharkes@cs.cmu.edu, codalist@TELEMANN.coda.cs.cmu.edu
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1053971135.1968.6.camel@nalesnik.localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 May 2003 18:45:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

following BUG() is started when coda is included into kernel. I have not
tried module, but i bet it will couse the same error.

coda_init_inodecache runs kmem_cache_create which couses oups.
Removing following lines from slab.c renders system stable.
But this is not a cure. As i am not using coda it self, i really don't
know if it is running stable.

slab.c snip:


        /*
         * Always checks flags, a caller might be expecting debug
         * support which isn't available.
         */
         /*
        if (flags & ~CREATE_MASK){
                        printk("dupa2\n");
                        _BUG();
                BUG();
        }

this is in kmem_cache_create fn.

 
-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

