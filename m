Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271606AbTHDJq5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 05:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271691AbTHDJq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 05:46:57 -0400
Received: from hera.cwi.nl ([192.16.191.8]:55485 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S271606AbTHDJq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 05:46:56 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 4 Aug 2003 11:46:52 +0200 (MEST)
Message-Id: <UTC200308040946.h749kqm25083.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, akpm@osdl.org
Subject: Re: do_div considered harmful
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sometimes the slash-star operator comes in handy.

Certainly an improvement. Maybe it will help a little.

But really, do_div is not a C function, it has very
nonintuitive behaviour.
The two bugs are: (i) the name is wrong, it returns a
remainder but the name only talks about dividing, and
(ii) worst of all, it changes its first argument.

> + * uint32_t do_div(uint64_t *n, uint32_t base)

And the comment that you added, copied from elsewhere,
is confusing too. The first parameter is not uint64_t *.
This thing cannot be described in C.

I would still like to replace do_div by DO_DIV_AND_REM
as a big fat warning - this is a macro, read the definition.
And the common case, where no remainder is used, by DO_DIV
#define DO_DIV(a,b)	(void) DO_DIV_AND_REM(a,b)

Andries

[Perhaps DO_DIV64, to also indicate a type.]

[The same problem happens with sector_div. I recall having
to fix sector_div calls in scsi code. These functions are
bugs waiting to happen. Nobody expects that after
	res = func(a,b);
the value of a has changed.]
