Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263815AbUHQGko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbUHQGko (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 02:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUHQGko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 02:40:44 -0400
Received: from dslsmtp.struer.net ([62.242.36.21]:18183 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S263815AbUHQGkj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 02:40:39 -0400
Message-ID: <44401.194.237.142.13.1092724838.squirrel@194.237.142.13>
In-Reply-To: <20040817062017.GL11200@holomorphy.com>
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
    <20040817062017.GL11200@holomorphy.com>
Date: Tue, 17 Aug 2004 08:40:38 +0200 (CEST)
Subject: Re: 2.6.8.1-mm1
From: sam@ravnborg.org
To: "William Lee Irwin III" <wli@holomorphy.com>
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Aug 16, 2004 at 02:37:10PM -0700, Andrew Morton wrote:
>> handle-undefined-symbols.patch
>>   Fail if vmlinux contains undefined symbols
>> sparc32-ignore-undefined-symbols-with-3-or-more-leading-underscores.patch
>>   sparc32: ignore undefined symbols with 3 or more leading underscores
>
> Okay, this patch has officially made my shitlist along with whatever
> introduced the second check. The following appears to be necessary to
> get sparc64 to link, which of course clashes wildly with the UML
> changes to get *it* to link.

rmk's ldchk in top-level Makefile needs to be backed out. The check
for undefined symbols are now moved to the mksysmap script.
The patch doing this was on top of Linus's tree therefore the confusion.

But I see this check causing almost only pain, so I hope during the
weekend to come up with something that allow us to specify
the final link rule in the arch Makefile.

Something like:
*/built-in.o =>
  vmlinux.o
  =>
    kallsyms steps
    =>
      arch specific link rule (vmlinux-arch.o)
      =>
        vmlinux


Challenge here is to make it elegant without causing changes for
architectures that do not need it.
The arm can have the dreadful "check for undefined symbols" if needed.

> This scripting crap is fragile and nightmarish. We should probably be
> examining the ELF bits directly in C.
I started looking into this but backed out in fear of doing
too much duplicated work.
If we do a kernel elf-tool then it should cover
also the need for btfixup.

   Sam

