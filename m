Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266176AbUGJHKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266176AbUGJHKy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 03:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266182AbUGJHKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 03:10:54 -0400
Received: from mail-relay-3.tiscali.it ([212.123.84.93]:48042 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S266176AbUGJHKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 03:10:46 -0400
Date: Sat, 10 Jul 2004 09:09:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "P. Benie" <pjb1008@eng.cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Message-ID: <20040710070958.GH20947@dualathlon.random>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <Pine.LNX.4.53.0407080707010.21439@chaos> <Pine.HPX.4.58L.0407081224460.28859@punch.eng.cam.ac.uk> <Pine.LNX.4.53.0407081030320.21855@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0407081030320.21855@chaos>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 10:32:32AM -0400, Richard B. Johnson wrote:
> On Thu, 8 Jul 2004, P. Benie wrote:
> > the integer 0 and null pointers are not the same, the compiler will
> > perform the appropriate conversion for you, so it is always correct to
> > define NULL as (void *)0.
> 
> That's NOT what is says. It states that a NULL pointer is converted to
> the appropriate type before any comparison is made. It does NOT say
> that 0 is a valid null-pointer.

0 when casted or assigned to a pointer will be converted to the null
pointer value by the compiler, that's why doing !ptr is equivalent to
ptr == NULL, even if ptr points to address 0xffffffff virtual in
reality. Still NULL is set to (void *) 0, or alternatively (void *) -1UL
(thought the latter I'm not 100% sure but I think it'll work in such a
case).

It's mostly theory though, I've never seen an arch with a compiler with
a null pointer not actually meaning virtual address 0UL (that's why we
used a C-breaking #define NULL ((void*)-1UL) once we needed it).
