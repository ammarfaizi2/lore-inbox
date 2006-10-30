Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWJ3NRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWJ3NRE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 08:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWJ3NRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 08:17:03 -0500
Received: from main.gmane.org ([80.91.229.2]:12165 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964869AbWJ3NRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 08:17:01 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH -mm] replacement for broken kbuild-dont-put-temp-files-in-the-source-tree.patch
Date: Mon, 30 Oct 2006 13:16:25 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnekbv60.2vm.olecom@flower.upol.cz>
References: <20061028230730.GA28966@quickstop.soohrt.org> <200610281907.20673.ak@suse.de> <20061029120858.GB3491@quickstop.soohrt.org> <200610290816.55886.ak@suse.de> <slrnek9qv0.2vm.olecom@flower.upol.cz> <20061029225234.GA31648@uranus.ravnborg.org> <4545C2D8.76E4.0078.0@novell.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>, "Jan Beulich" <jbeulich@novell.com>, "Sam Ravnborg" <sam@ravnborg.org>, <dsd@gentoo.org>, <kernel@gentoo.org>, <draconx@gmail.com>, <jpdenheijer@gmail.com>, "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@suse.de>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-10-30, Jan Beulich wrote:
>
>>> In `19-rc3/include/Kbuild.include', just below `as-instr' i see:
>>> ,--
>>> |cc-option = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
>>> |             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi ;)
>>> |
>>> |# cc-option-yn
>>> |# Usage: flag := $(call cc-option-yn, -march=winchip-c6)
>>> |cc-option-yn = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
>>> |                 > /dev/null 2>&1; then echo "y"; else echo "n"; fi;)
>>> `--
>>> so, change to `-o /dev/null' in `as-instr' will just follow this.
>>
>>gcc does not delete files specified with -o - but binutils does.
>>So using /dev/null in this case is not an option.

Hmm. What's the preblem to invoke `as' via the GNU C compiler, then?

> While I fixed this quite some time ago (after running into it myself), it
> obviously still is a problem with older versions. However, using as' -Z
> option seems to help here.
> On the other hand, I long wanted to compose a patch to do away
> with all the .tmp_* things at the build root, and move them into a
> single .tmp/ directory - this would also seem to make a nice place to
> put all sort of other temporary files in... I just never found the time
> to actually do that, sorry.

Maybe it's good idea, let me try, as i already bound to kbuild fixes.

But now, i'm just using KBUILD_OUTPUT=/tmp/, and /tmp/ is /dev/shm/.
It speeds up things on testing and small amounts of stuff to build.
Source tree is for patching only.
____

