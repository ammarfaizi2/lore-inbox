Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965909AbWKHPIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965909AbWKHPIt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 10:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965912AbWKHPIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 10:08:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:34759 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965909AbWKHPIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 10:08:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d+pT3240PQ3z885fPFHv1IEhGKmViQiqhASKsg+qF48uzunOGpqEt9xfGch0LaFFHhL0qUo4HyDJ6JpNAVjFYAM5ho7S6oYcUZp84M8r7C9VdP9KNbOPz4qO7GBKy/42ArH2KoS6SxsiY044BKT/U2womO+PM0l4HHNAOHKvzZ0=
Message-ID: <40f323d00611080708j2eeaefc1kee4f22211d3f276d@mail.gmail.com>
Date: Wed, 8 Nov 2006 16:08:45 +0100
From: "Benoit Boissinot" <bboissin@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.19-rc5-mm1
Cc: linux-kernel@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>
In-Reply-To: <20061108015452.a2bb40d2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061108015452.a2bb40d2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/06, Andrew Morton <akpm@osdl.org> wrote:
>
> Temporarily at
>
> http://userweb.kernel.org/~akpm/2.6.19-rc5-mm1/
>
> will turn up at
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm1/
>
> when kernel.org mirroring catches up.
>
I have the following traceback during boot:
[   20.359613] BUG: unable to handle kernel NULL pointer dereference
at virtual address 00000000
[   20.359618]  printing eip:
[   20.359620] 00000000
[   20.359621] *pde = 00000000
[   20.359625] Oops: 0000 [#1]
[   20.359627] last sysfs file:
[   20.359630] Modules linked in: processor fan
[   20.359635] CPU:    0
[   20.359636] EIP:    0060:[<00000000>]    Not tainted VLI
[   20.359638] EFLAGS: 00010006   (2.6.19-rc5-mm1 #15)
[   20.359642] EIP is at 0x0
[   20.359644] eax: 00000002   ebx: 00000002   ecx: c04332c0   edx: c04332c0
[   20.359648] esi: e6b71ee0   edi: 00000008   ebp: e6b71e94   esp: dfc27dac
[   20.359651] ds: 007b   es: 007b   ss: 0068
[   20.359654] Process modprobe (pid: 939, ti=dfc26000 task=e6429030
task.ti=dfc26000)
[   20.359656] Stack: c012fae0 e6b71c00 e80307bd 00000001 e8030b76
dfc27e40 00000000 e6b71d28
[   20.359663]        00000003 00000003 00000000 00000003 00000004
00000000 e6f8fa00 00000300
[   20.359669]        00001015 00000300 00000055 00000000 000000fa
00000000 00000000 00000000
[   20.359675] Call Trace:
[   20.359677]  [<c012fae0>] clockevents_set_global_broadcast+0x60/0x70
[   20.359686]  [<e80307bd>] acpi_propagate_timer_broadcast+0x24/0x31
[processor]
[   20.359695]  [<e8030b76>] acpi_processor_get_power_info+0x3ac/0x4e7
[processor]
[   20.359704]  [<e80204fa>] acpi_processor_power_init+0x9b/0x15e [processor]
[   20.359712]  [<e8020386>] acpi_processor_start+0x386/0x3f8 [processor]
[   20.359719]  [<c020e4cf>] acpi_start_single_object+0x1b/0x3b
[   20.359727]  [<c020ead3>] acpi_bus_register_driver+0x65/0x7c
[   20.359732]  [<e802043b>] acpi_processor_init+0x43/0x67 [processor]
[   20.359739]  [<c0134137>] sys_init_module+0x157/0x1820
[   20.359746]  [<c0102f90>] syscall_call+0x7/0xb
[   20.359751]  =======================
[   20.359753] Code:  Bad EIP value.
[   20.359756] EIP: [<00000000>] 0x0 SS:ESP 0068:dfc27dac

reverting:
i386-apic-timer-use-clockevents-broadcast.patch
acpi-verify-lapic-timer.patch
acpi-verify-lapic-timer-exports.patch
acpi-verify-lapic-timer-fix.patch

fixes it.

regards,

Benoit

dmesg and kernel config at: http://perso.ens-lyon.fr/benoit.boissinot/kernel/
