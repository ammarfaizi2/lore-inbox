Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312392AbSDEIgy>; Fri, 5 Apr 2002 03:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312393AbSDEIgo>; Fri, 5 Apr 2002 03:36:44 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8247 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312392AbSDEIg1>; Fri, 5 Apr 2002 03:36:27 -0500
To: Martin Mares <mj@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, pic 16 4/9
In-Reply-To: <m11ydwu5at.fsf@frodo.biederman.org> <20020405080115.GA409@ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Apr 2002 01:29:49 -0700
Message-ID: <m1k7rmpmyq.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares <mj@ucw.cz> writes:

> Hello!
> 
> > Instead removes the assumption the code is linked to run at 0.  The
> > binary code is already PIC, this makes the build process the same way,
> > making the build requirements more flexible. 
> 
> What are the reasons to do this change? The assumption that "linked at 0"
> assumptions looks pretty harmless and the "-start"'s everywhere are ugly.

Short answer the current assembly is broken.

Long answer.

Without the "-start"'s the gas generates a relocation record for
every one of those instructions.  The correct syntax with gas is ugly.
If you can find the gas equivalent of an assume %ds ... directive I will use
it.   

The fact that you can't treat the generated .o as a normal object
is simply a maintenance nightmare.

With this change it is possible to write a linker script that
generates a bzImage.  I won't do it as every other build of ld
is broken with respect to interesting linker scripts.   But there are
still some subsets of that idea that make sense.

Eric
