Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266193AbUGONKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266193AbUGONKH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 09:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266194AbUGONKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 09:10:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25991 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266193AbUGONJ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 09:09:56 -0400
Message-ID: <40F68212.2020405@pobox.com>
Date: Thu, 15 Jul 2004 09:09:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: axboe@suse.de, wli@holomorphy.com, B.Zolnierkiewicz@elka.pw.edu.pl,
       akpm@osdl.org, dgilbert@interlog.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] drivers/scsi/sg.c gcc341 inlining fix
References: <200407150946.i6F9kqXn010635@harpo.it.uu.se>
In-Reply-To: <200407150946.i6F9kqXn010635@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> On Wed, 14 Jul 2004 23:12:54 -0700, William Lee Irwin III wrote:
> 
>>Jeff Garzik <jgarzik@pobox.com> wrote:
>>
>>>>>Or you could just call it "gcc is dumb" rather than a compiler bug.
>>
>>On Wed, Jul 14 2004, Andrew Morton wrote:
>>[... code snippet ...]
>>
>>>>is pretty dumb too.  I don't see any harm if this compiler feature/problem
>>>>pushes us to fix the above in the obvious way.
>>
>>On Thu, Jul 15, 2004 at 07:56:56AM +0200, Jens Axboe wrote:
>>
>>>Excuse my ignorance, but why on earth would that be dumb? Looks
>>>perfectly legit to me, and I have to agree with Jeff that the compiler
>>>is exceedingly dumb if it fails to inline that case.
>>
>>Enter gcc...
>>
>>Maybe "the obvious way" is sending a someone off to whip gcc into shape,
>>or possibly reporting it as a gcc problem.
> 
> 
> It shows you guys aren't compiler writers.

Actually, I have written most of a [simple] compiler backend.


> Compilers for top-down (define-before-use) languages like C
> have traditionally also worked in a top-down fashion, processing
> one top-level declaration at a time. Forward references are
> either errors, or are (when a proper declaration is in scope)
> left to the linker to resolve.
> 
> Processing an entire compilation-unit (e.g. whole C file)
> as a single unit is typically _only_ done when either the
> language semantics requires it (not C, but e.g. Haskell),
> or when very high optimisation levels are requested.

Or in the case where you parse the entire file, then generate code for 
the entire file in a separate pass.  Which does NOT imply 
unit-at-a-time, for the readers at home.  It just implies generation of 
the AST.


> In the case of gcc-3.4.1 failing to inline, you are asking
> gcc to do something (peeking forward) which it never has
> promised to do. And with the kernel using -fno-unit-at-a-time
> for stack conservation reasons, gcc is actually being _told_
> not to do global compilation.
> 
> This is not a gcc bug, nor is it being "exceedingly dumb".

Actually, yes it is.

	Jeff


