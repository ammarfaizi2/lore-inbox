Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263417AbTDVThq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263511AbTDVThq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:37:46 -0400
Received: from cave-fxp0.tnc.ru ([81.211.38.202]:14477 "HELO hsys.msk.ru")
	by vger.kernel.org with SMTP id S263417AbTDVTho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:37:44 -0400
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] implement __GFP_REPEAT, __GFP_NOFAIL, __GFP_NORETRY
From: Alexey Mahotkin <alexm@hsys.msk.ru>
Date: Tue, 22 Apr 2003 23:49:46 +0400
Message-ID: <87bryy9usl.fsf@192.168.10.23>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Common Lisp,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Maybe I am wrong, but recent patch added 

+#define __GFP_NORETRY	0x1000	/* Do not retry.  Might fail */


which conflicts numerically with 

#define	SLAB_NO_GROW		0x00001000UL	/* don't grow a cache */


e.g., mm/slab.c contains the following snippet:

        if (flags & ~(SLAB_DMA|SLAB_LEVEL_MASK|SLAB_NO_GROW))
                BUG();
        if (flags & SLAB_NO_GROW)
                return 0;


while SLAB_LEVEL_MASK actually contains SLAB_NO_GROW.

--alexm
