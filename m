Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWGBRjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWGBRjw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 13:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWGBRjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 13:39:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43419 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751444AbWGBRjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 13:39:51 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Edgar Hucek <hostmaster@ed-soft.at>,
       LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #4]
References: <44A04F5F.8030405@ed-soft.at>
	<Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>
	<44A0CCEA.7030309@ed-soft.at>
	<Pine.LNX.4.64.0606262318341.3927@g5.osdl.org>
	<44A304C1.2050304@zytor.com>
Date: Sun, 02 Jul 2006 11:39:16 -0600
In-Reply-To: <44A304C1.2050304@zytor.com> (H. Peter Anvin's message of "Wed,
	28 Jun 2006 15:37:53 -0700")
Message-ID: <m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Linus Torvalds wrote:
>> On Tue, 27 Jun 2006, Edgar Hucek wrote:
>>> So what is your suggestion to get the working funktionality
>>> from kernel 2.6.16 back ? 2.6.17 have broken it.
>> I'd really suggest just filling in the e820 table from the EFI information
>> early at boot.
>> (Even better would be for the EFI bootloader on x86 to just fill things in
>> _as_if_ it was filling in e820 data, but that's outside of the kernel, so if
>> you want the _kernel_ to be able to handle native EFI data, do it by just
>> translating it once into e820 mode, and you're done).
>> The translation from EFI to e820 format should be very straightforward
>> indeed. I think it's pretty much the same thing with different naming.
>>
>
> You probably don't want to put it in the bootloader.  The kernel is easier to
> upgrade than the bootloader, which is easier to upgrade than the firmware, so it
> makes more sense for the kernel to be as self-sufficient as is possible, or at
> least practical.

Regardless it would be nice if the efi implementation hacks were removed.

My favorite is this one in init/main.c 
#ifdef CONFIG_X86
	if (efi_enabled)
		efi_enter_virtual_mode();
#endif

Which pretty much guarantees efi won't be a distro supported feature
any time soon because it breaks kexec the ability of a kexec'd kernel
to boot and thus crash dump support. Or it does if you ever use efi
callbacks, and if you don't use efi callbacks there is no point in
calling that function.  Why are efi callbacks not always done in
physical mode?

Eric


