Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWJJTAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWJJTAV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWJJTAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:00:21 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:16822 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751089AbWJJS7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:59:55 -0400
Date: Tue, 10 Oct 2006 11:59:40 -0700
From: Paul Jackson <pj@sgi.com>
To: "David S. Miller" <davem@sunset.davemloft.net>
Cc: linux-kernel@vger.kernel.org, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Andrew Morton <akpm@osdl.org>
Subject: Sparc64 stopped building - sigset_t unrecognized in compat.h
Message-Id: <20061010115940.4c25ae83.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometime on or about the change to include/linux/compat.h:

    changeset:   39069:fefadae8104d
    parent:      38900:a2856d056930
    user:        David S. Miller <davem@sunset.davemloft.net>
    date:        Tue Oct  3 04:24:18 2006 +0700
    summary:     [SPARC64]: Move signal compat bits to new header file.

which added the line:

    extern void sigset_from_compat(sigset_t *set, compat_sigset_t *compat);

my crosstool compile of sparc64 for 2.6.18-mm3 stopped building.

    $ make init/main.o

fails on the "sigset_t *set", with:

    In file included from include/asm/signal.h:11,
		     from include/linux/signal.h:4,
		     from include/linux/sched.h:67,
		     from include/linux/module.h:9,
		     from init/main.c:13:
    include/linux/compat.h:231: error: parse error before '*' token
    include/linux/compat.h:231: warning: function declaration isn't a prototype
    make[1]: *** [init/main.o] Error 1
    make: *** [init/main.o] Error 2

P.S. -- Looks like I'm not the first to notice.  Adding Dr. von Brand
        and Andrew to my cc list.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
