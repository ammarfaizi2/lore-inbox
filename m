Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbTDRI0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 04:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbTDRI0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 04:26:18 -0400
Received: from hera.cwi.nl ([192.16.191.8]:17129 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262934AbTDRI0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 04:26:17 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 18 Apr 2003 10:38:12 +0200 (MEST)
Message-Id: <UTC200304180838.h3I8cCO25742.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, adilger@clusterfs.com
Subject: Re: [PATCH] struct loop_info
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Andreas Dilger <adilger@clusterfs.com>

    > In this struct the occurrences of dev_t have been replaced by their
    > actual values (short int / int / long int).

    Even better, have specific sized types (__u16, __u32, __u64) for the
    fields, so there is no ambiguity (e.g. sparc64, or 32-bit code running
    on x86-64).

I replaced the dev_t's by the actual thing they were typedef'd to.
That is guaranteed to preserve correctness.

    > In the patch below I remove the definition for this struct from
    > <linux/loop.h> and put it in <asm/loopinfo.h>.

    Great.  Now we have 20 copies of asm-foo/loopinfo.h.  Couldn't you
    just have asm-generic/loopinfo.h and each of the arch-specific
    pieces just include that?

Yes, a bit ugly. I could have saved kernel source (20 small files)
by using __legacy_dev_t in loop.h, with a typedef of __legacy_dev_t
in <asm/posix_types.h>.

Maybe I should have done that. The reason I did what I did is
that all these defined types give lots of complications in
user space code. Maintainability of the union of kernel and
user space source is increased by just saying explicitly
what these types are.

Andries
