Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUI0K7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUI0K7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 06:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUI0K7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 06:59:36 -0400
Received: from zero.aec.at ([193.170.194.10]:17164 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266663AbUI0K7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 06:59:04 -0400
To: "Jan Beulich" <JBeulich@novell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: i386 entry.S problems
References: <2J0sK-6Ot-5@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 27 Sep 2004 12:58:57 +0200
In-Reply-To: <2J0sK-6Ot-5@gated-at.bofh.it> (Jan Beulich's message of "Mon,
 27 Sep 2004 12:00:14 +0200")
Message-ID: <m3acvcf05q.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <JBeulich@novell.com> writes:
>
> I don't think so. Otherwise, why would arch/i386/Makefile specifically
> deal with this situation?

It shouldn't be enabled for 2.95, there are known miscompilations
caused by it there.  The i386 Makefile enforces this:

cflags-$(CONFIG_REGPARM) 	+= $(shell if [ $(GCC_VERSION) -ge 0300 ] ; then echo "-mregparm=3"; fi ;)

However this points to a bug in that when someone sets this
on 2.95 the assembly functions who check for CONFIG_REGPARM
explicitely will be subtly miscompiled. Perhaps having 
a #error for this case would be better, although that
would break allyesconfig on prehistoric compilers. Maybe 
it needs to be special cased in autoconf.h

-Andi

