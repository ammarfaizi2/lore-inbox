Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266174AbUGOJrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266174AbUGOJrh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 05:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUGOJrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 05:47:37 -0400
Received: from aun.it.uu.se ([130.238.12.36]:3289 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266163AbUGOJre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 05:47:34 -0400
Date: Thu, 15 Jul 2004 11:46:52 +0200 (MEST)
Message-Id: <200407150946.i6F9kqXn010635@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: axboe@suse.de, wli@holomorphy.com
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osdl.org, dgilbert@interlog.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, mikpe@csd.uu.se
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2004 23:12:54 -0700, William Lee Irwin III wrote:
>Jeff Garzik <jgarzik@pobox.com> wrote:
>>>> Or you could just call it "gcc is dumb" rather than a compiler bug.
>
>On Wed, Jul 14 2004, Andrew Morton wrote:
>[... code snippet ...]
>>> is pretty dumb too.  I don't see any harm if this compiler feature/problem
>>> pushes us to fix the above in the obvious way.
>
>On Thu, Jul 15, 2004 at 07:56:56AM +0200, Jens Axboe wrote:
>> Excuse my ignorance, but why on earth would that be dumb? Looks
>> perfectly legit to me, and I have to agree with Jeff that the compiler
>> is exceedingly dumb if it fails to inline that case.
>
>Enter gcc...
>
>Maybe "the obvious way" is sending a someone off to whip gcc into shape,
>or possibly reporting it as a gcc problem.

It shows you guys aren't compiler writers.

Compilers for top-down (define-before-use) languages like C
have traditionally also worked in a top-down fashion, processing
one top-level declaration at a time. Forward references are
either errors, or are (when a proper declaration is in scope)
left to the linker to resolve.

Processing an entire compilation-unit (e.g. whole C file)
as a single unit is typically _only_ done when either the
language semantics requires it (not C, but e.g. Haskell),
or when very high optimisation levels are requested.

In the case of gcc-3.4.1 failing to inline, you are asking
gcc to do something (peeking forward) which it never has
promised to do. And with the kernel using -fno-unit-at-a-time
for stack conservation reasons, gcc is actually being _told_
not to do global compilation.

This is not a gcc bug, nor is it being "exceedingly dumb".

/Mikael
