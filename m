Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTICLy1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 07:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTICLy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 07:54:27 -0400
Received: from chello080109223066.lancity.graz.surfer.at ([80.109.223.66]:62083
	"EHLO lexx.delysid.org") by vger.kernel.org with ESMTP
	id S261957AbTICLyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 07:54:25 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: JVC MP-XP7210 hangs on boot with 2.6.0-test4
From: Mario Lang <mlang@delysid.org>
In-Reply-To: <20030829094851.066ce7c2.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 29 Aug 2003 09:48:51 -0700")
References: <87k78wsip0.fsf@lexx.delysid.org>
	<20030829094851.066ce7c2.akpm@osdl.org>
Date: Wed, 03 Sep 2003 13:54:27 +0200
Message-ID: <87u17ugk98.fsf@lexx.delysid.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Mario Lang <mlang@delysid.org> wrote:
>>
>> I just tried 2.6.0-test4 on my Laptop (JVC MP-XP7210, 256MB RAM, IDE).
>> However, it hangs on boot.  I tried booting with acpi=off and also
>> with "acpi=off noapic".  Both options seem to help nothing,
>> and the same output appears on all attempts to boot.
>> 
>> I compiled the kernel with gcc 3.3.2.
>> 
>> Here is the output I get:
>> 
>> [<c0 10 92 69>] Kernel_thread_helper+0x5/0xc
>> Code: 0f ba 6e 24 00 c7 44 24 04 00 00 00 00 89 34 24 e8 25 fa ff
>> <0> Kernel Panic: Fatal Exception in Interrupt
>> in interrupt handler - not syncing
>
> There must have been more output than that?  Please transcribe some more of
> the backtrace and send it.  Don't worry about all the hex numbers: the
> important parts are these:
>
>  EIP is at i810fb_cursor+0x1da/0x240 [i810fb]
>
>  Call Trace:
>  [<...>] apic_timer_interrupt+0x1a/0x20
>  [<...>] bh_lru_install+0xb5/0x100
>  [<...>] __find_get_block+0x73/0xf0
>  [<...>] __getblk+0x2b/0x60
>  [<...>] is_tree_node+0x6b/0x70
>  [<...>] search_by_key+0x6f9/0xf30
>  [<...>] search_for_position_by_key+0x1be/0x3d0
>  [<...>] apic_timer_interrupt+0x1a/0x20

Sorry, I did ask a college to type this info for me since I am
blind and can't read screen output at that early stage in the
boot process.  It seems he was very lazy.

> Also, try stripping your kernel down by unconfiguring drivers and features
> which are not needed for a successful boot.

Thanks you for reminding me!  I should have found this myself.
The problem was that I accidentally enabled ACPI CPU enumeration support
for HT.  Well, this is a pIII Mobile, and surely has
no Hyperthreading.

Now the machine boots fine.  Only "error" I saw in
dmesg is that my chipset is not yet supported for SpeedStep.

-- 
CYa,
  Mario | Debian Developer <URL:http://debian.org/>
        | Get my public key via finger mlang@db.debian.org
        | 1024D/7FC1A0854909BCCDBE6C102DDFFC022A6B113E44
