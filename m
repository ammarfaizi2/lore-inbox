Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbTDWSuG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264280AbTDWSuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:50:06 -0400
Received: from air-2.osdl.org ([65.172.181.6]:28114 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264277AbTDWStI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:49:08 -0400
Date: Wed, 23 Apr 2003 11:59:52 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Kirilenko <icedank@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Searching for string problems
Message-Id: <20030423115952.7b132f22.rddunlap@osdl.org>
In-Reply-To: <200304232125.22270.icedank@gmx.net>
References: <200304231958.43235.icedank@gmx.net>
	<200304232105.38722.icedank@gmx.net>
	<Pine.LNX.4.53.0304231412450.25545@chaos>
	<200304232125.22270.icedank@gmx.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003 21:25:22 +0300 Andrew Kirilenko <icedank@gmx.net> wrote:

| Hello!
| 
| > > > scan:	movw	%cs, %ax
| > > > 	movw	%ax, %ds
| > > > 	movw	%ax, %es
| > > > 	movw	$where_in_BIOS_to_start, %bx
| > > > 	cld
| > > > 1:	movw	$cl_id_str, %si		# Offset of search string
| > > > 	movw	$cl_id_end, %cx		# Offset of string end + 1
| > > > 	subw	%si, %cx		# String length
| > > > 	decw	%cx			# Don't look for the \0
| > > > 	movw	%bx, %di		# ES:DI = where to look
| > > > 	repz	cmpsb			# Loop while the same
| > > > 	jz	found			# Found the string
| > > > 	incb	%bx			# Next starting offset
| > > > 	cmpb	$_BIOS_END, %bx		# Check for limit
| > > > 	jb	1b			# Continue
| > > > never_found_anywhere:
| > > >
| > > > found:
| > >
| > > I've written something similar to this before - and it wont' work, so
| > > I've reimplemented it. The problem is, that I don't know how to set ES
| > > properly. I only know, that BIOS data (and code) is located in
| > > 0xe000..0xf000 (real address).
| >
| > Yeah. So. I set ES and DS to be exactly where CS is. This means that
| > if your &!)(^$&_ code executes it will work. So, instead of trying
| > it, you just blindly ignore it and state that it won't work.
| >
| > Bullshit. I do this for a living and I gave you some valuable time
| > which you rejected out-of-hand. Have fun.
| 
| Of course, I've tried your code as well - the same result! Sorry, if you 
| haven't understand me.
| 
| The problem is, that I don't know where this BIOS code is relative to current 
| code segment (CS). I only know (hope), that it should be in 
| 0x0:0xe000...0x0:0xf000. I have tried to set ES to 0 (xor %ax, %ax; mov %ax, 
| %es) - no luck as well. BTW, `strings /dev/mem | grep "REQUESTED STRING"` 
| founds it perfectly...

You shouldn't need to know where the BIOS code is "relative to
current code segment."  It "should be" in hex 0:e000-ffff.
You should be able to use some segment reg. = 0 to search.

I see that Dick just corrected this, just as I was about to do:
Typical PC BIOSen are at segment 0xe000:0 thru 0xf000:ffff,
not segment 0 and offsets as you have them listed.
Are you using a typical PC BIOS or something else?

--
~Randy
