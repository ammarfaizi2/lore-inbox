Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbUKOWHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbUKOWHN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 17:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbUKOWHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 17:07:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:23531 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261441AbUKOWHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 17:07:05 -0500
Message-ID: <41992590.4060004@osdl.org>
Date: Mon, 15 Nov 2004 13:54:24 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Brian Gerst <bgerst@quark.didntduck.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Regparm for x86 machine check handlers
References: <4198EA70.202@quark.didntduck.org> <Pine.LNX.4.58.0411151201580.2222@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411151201580.2222@ppc970.osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 15 Nov 2004, Brian Gerst wrote:
> 
>>The patch to change traps and interrupts to the fastcall convention 
>>missed the machine check handlers.
> 
> 
> Thanks, that was silly.
> 
> Anybody want to write a script that verifies that the only remaining 
> "asmlinkage" entries are of the type "sys_xxxx()"? 

Is part of the problem definition missing here?
or I missed it?

E.g., printk() and vprint() are asmlinkage but not sys_xyz()...
but I have a suspicion that they are OK.

> "grep" shows that there's a number of incorrect ones left, but most of 
> them seem to take no arguments, so ir doesn't matter. And there's the FP 
> emulation stuff, which really -does- use the old interfaces.

so ignore the FP emulation, ignore functions with no arguments, right?

and omit "asmlinkage.*sys_xyz".  that leaves a handful of functions
which are <asm>, like:

acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state);
csum_partial(), csum_partial_copy_generic(),
schedule_tail(), aes_enc_blk(), aes_dec_blk().

I don't see others than need to be fixed, but a script
would be a safer way to check, so I'm trying to nail down
the requirements ... and what tool to use, like is there
already a PERL [or python or xyz] script that parses C,
or would you *coff* recommend sparse?

-- 
~Randy
