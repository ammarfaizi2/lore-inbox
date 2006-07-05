Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWGEJiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWGEJiI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 05:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWGEJiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 05:38:07 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:16008
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S932413AbWGEJiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 05:38:05 -0400
Message-ID: <44AB8878.7010203@ed-soft.at>
Date: Wed, 05 Jul 2006 11:38:00 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #4]
References: <44A04F5F.8030405@ed-soft.at>	<Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>	<44A0CCEA.7030309@ed-soft.at>	<Pine.LNX.4.64.0606262318341.3927@g5.osdl.org>	<44A304C1.2050304@zytor.com>	<m1ac7r9a9n.fsf@ebiederm.dsl.xmission.com>	<44A8058D.3030905@zytor.com> <m11wt3983j.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m11wt3983j.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agre with you to make efi use the e820 map as a long term solution.
But at the moment the efi part is completley broken without my patch.
At least on Intel Macs. 
Without the patch also my Imacfb driver makes no sense, since it is 
for efi booted Intel Macs. 

cu

Edgar (gimli) Hucek

Eric W. Biederman schrieb:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>> Eric W. Biederman wrote:
>>
>>>> You probably don't want to put it in the bootloader.  The kernel is easier to
>>>> upgrade than the bootloader, which is easier to upgrade than the firmware, so
>> it
>>>> makes more sense for the kernel to be as self-sufficient as is possible, or
>> at
>>>> least practical.
>>> Regardless it would be nice if the efi implementation hacks were removed.
>>>
>>> My favorite is this one in init/main.c #ifdef CONFIG_X86
>>> 	if (efi_enabled)
>>> 		efi_enter_virtual_mode();
>>> #endif
>>> Which pretty much guarantees efi won't be a distro supported feature
>>> any time soon because it breaks kexec the ability of a kexec'd kernel
>>> to boot and thus crash dump support. Or it does if you ever use efi
>>> callbacks, and if you don't use efi callbacks there is no point in
>>> calling that function.  Why are efi callbacks not always done in
>>> physical mode?
>>>
>> If nothing else, they should be isolated, and in the early kernel build a
>> datastructure like the e820 data structure, so the downstream kernel doesn't
>> deal with it.
>>
>> I have no idea what the above does; it sounds to me like something that should
>> be possible to do differently, though.
> 
> Quite.
> 
> The part that is an obvious hack is that it shows up in init/main.c
> for no apparent reason.  Instead of being in architecture specific code
> since it only applies to one architecture.  ia64 which also uses efi
> doesn't need to patch init/main.c
> 
> Basically this was just an example to add to the e820 map problem of what
> a problem this code really is.
> 
> Thinking about the e820 problem.  That is in the function:
> e820_all_mapped(unsigned long s, unsigned long e, unsigned type)
> 
> Which is a test.  I believe this is the sanity check to ensure the
> pci express memory mapped configuration area is accessible.
> 
> In which case disabling the test is totally wrong,
> and I agree with Linus that we need to convert the structure.
> 
> We need to know what the BIOS's idea of the memory map is and to be
> able to query it.
> 
> Although I am surprised we could not just make that query by looking
> at the resources.  Possibly we are too early in boot.
> 
> Eric
> 

