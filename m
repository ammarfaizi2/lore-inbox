Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161184AbWJ3IOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbWJ3IOc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 03:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbWJ3IOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 03:14:31 -0500
Received: from gwmail.nue.novell.com ([195.135.221.19]:57493 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1161184AbWJ3IOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 03:14:31 -0500
Message-Id: <4545C2D8.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 30 Oct 2006 09:16:08 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: "Oleg Verych" <olecom@flower.upol.cz>, <dsd@gentoo.org>,
       <kernel@gentoo.org>, <draconx@gmail.com>, <jpdenheijer@gmail.com>,
       "Andrew Morton" <akpm@osdl.org>, "Andi Kleen" <ak@suse.de>,
       "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm] replacement for broken
	kbuild-dont-put-temp-files-in-the-source-tree.patch
References: <20061028230730.GA28966@quickstop.soohrt.org>
 <200610281907.20673.ak@suse.de>
 <20061029120858.GB3491@quickstop.soohrt.org>
 <200610290816.55886.ak@suse.de> <slrnek9qv0.2vm.olecom@flower.upol.cz>
 <20061029225234.GA31648@uranus.ravnborg.org>
In-Reply-To: <20061029225234.GA31648@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> In `19-rc3/include/Kbuild.include', just below `as-instr' i see:
>> ,--
>> |cc-option = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
>> |             > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi ;)
>> |
>> |# cc-option-yn
>> |# Usage: flag := $(call cc-option-yn, -march=winchip-c6)
>> |cc-option-yn = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
>> |                 > /dev/null 2>&1; then echo "y"; else echo "n"; fi;)
>> `--
>> so, change to `-o /dev/null' in `as-instr' will just follow this.
>
>gcc does not delete files specified with -o - but binutils does.
>So using /dev/null in this case is not an option.

While I fixed this quite some time ago (after running into it myself), it
obviously still is a problem with older versions. However, using as' -Z
option seems to help here.
On the other hand, I long wanted to compose a patch to do away
with all the .tmp_* things at the build root, and move them into a
single .tmp/ directory - this would also seem to make a nice place to
put all sort of other temporary files in... I just never found the time
to actually do that, sorry.

Jan
