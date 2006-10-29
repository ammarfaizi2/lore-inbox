Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965322AbWJ2Rwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965322AbWJ2Rwe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 12:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965318AbWJ2Rwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 12:52:34 -0500
Received: from main.gmane.org ([80.91.229.2]:51617 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965319AbWJ2Rwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 12:52:33 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH -mm] replacement for broken kbuild-dont-put-temp-files-in-the-source-tree.patch
Date: Sun, 29 Oct 2006 17:52:11 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnek9qv0.2vm.olecom@flower.upol.cz>
References: <20061028230730.GA28966@quickstop.soohrt.org> <200610281907.20673.ak@suse.de> <20061029120858.GB3491@quickstop.soohrt.org> <200610290816.55886.ak@suse.de>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>, Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>, Jan Beulich <jbeulich@novell.com>, Sam Ravnborg <sam@ravnborg.org>, jpdenheijer@gmail.com, linux-kernel@vger.kernel.org, dsd@gentoo.org, draconx@gmail.com, kernel@gentoo.org
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-10-29, Andi Kleen wrote:
>> Why not use -o /dev/null, as Daniel Drake already suggested in [1]? In
>> both as-instr and ld-option, the tmp file is being deleted
>> unconditionally right after its creation anyways.
>
> Because then when the compilation runs as root some as versions
> will delete /dev/null on a error. This has happened in the past.

OK, but let users, who still build kernels as root, alone.

In `19-rc3/include/Kbuild.include', just below `as-instr' i see:
,--
|cc-option = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
|             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi ;)
|
|# cc-option-yn
|# Usage: flag := $(call cc-option-yn, -march=winchip-c6)
|cc-option-yn = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
|                 > /dev/null 2>&1; then echo "y"; else echo "n"; fi;)
`--
so, change to `-o /dev/null' in `as-instr' will just follow this.
____

