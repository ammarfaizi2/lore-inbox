Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbTIDSTx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265436AbTIDSTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:19:53 -0400
Received: from 67.106.152.115.ptr.us.xo.net ([67.106.152.115]:35376 "EHLO
	amperion01.amperion.com") by vger.kernel.org with ESMTP
	id S265227AbTIDSSQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:18:16 -0400
X-MIMEOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: SLAB_LEVEL_MASK question
Date: Thu, 4 Sep 2003 14:18:15 -0400
Message-ID: <C6D44AA99ECEB540A5498F15F92DA07DCF0DB0@amperion01>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SLAB_LEVEL_MASK question
Thread-Index: AcNzDtZt/ET/PUCXSlilosdXOFhmgAAADjXA
From: "Henry Qian" <henry@amperion.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a kernel panic at:

static int kmem_cache_grow (kmem_cache_t * cachep, int flags)
{
        .....

        /*
         * The test for missing atomic flag is performed here, rather
than
         * the more obvious place, simply to reduce the critical path
length
         * in kmem_cache_alloc(). If a caller is seriously mis-behaving
they
         * will eventually be caught here (where it matters).
         */
        if (in_interrupt() && (flags & SLAB_LEVEL_MASK) != SLAB_ATOMIC)
                BUG();
        ...
}

The kernel panics because in the flags variable, I have other flags
(0x1f0) besides SLAB_ATOMIC.

I modified it to:

        if (in_interrupt() && (flags & SLAB_ATOMIC) != SLAB_ATOMIC)
                BUG();

It seems working fine.

Is this good?

Henry Qian
