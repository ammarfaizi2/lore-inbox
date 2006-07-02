Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWGBRmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWGBRmx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 13:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbWGBRmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 13:42:53 -0400
Received: from terminus.zytor.com ([192.83.249.54]:50885 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751569AbWGBRmw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 13:42:52 -0400
Message-ID: <44A8058D.3030905@zytor.com>
Date: Sun, 02 Jul 2006 10:42:37 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@osdl.org>, Edgar Hucek <hostmaster@ed-soft.at>,
       LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #4]
References: <44A04F5F.8030405@ed-soft.at>	<Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>	<44A0CCEA.7030309@ed-soft.at>	<Pine.LNX.4.64.0606262318341.3927@g5.osdl.org>	<44A304C1.2050304@zytor.com> <m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>>>
>> You probably don't want to put it in the bootloader.  The kernel is easier to
>> upgrade than the bootloader, which is easier to upgrade than the firmware, so it
>> makes more sense for the kernel to be as self-sufficient as is possible, or at
>> least practical.
> 
> Regardless it would be nice if the efi implementation hacks were removed.
 >
> My favorite is this one in init/main.c 
> #ifdef CONFIG_X86
> 	if (efi_enabled)
> 		efi_enter_virtual_mode();
> #endif
> 
> Which pretty much guarantees efi won't be a distro supported feature
> any time soon because it breaks kexec the ability of a kexec'd kernel
> to boot and thus crash dump support. Or it does if you ever use efi
> callbacks, and if you don't use efi callbacks there is no point in
> calling that function.  Why are efi callbacks not always done in
> physical mode?
> 

If nothing else, they should be isolated, and in the early kernel build 
a datastructure like the e820 data structure, so the downstream kernel 
doesn't deal with it.

I have no idea what the above does; it sounds to me like something that 
should be possible to do differently, though.

	-hpa

