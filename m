Return-Path: <linux-kernel-owner+w=401wt.eu-S932095AbXAQI7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbXAQI7G (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 03:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbXAQI7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 03:59:06 -0500
Received: from smtp3.netcabo.pt ([212.113.174.30]:26047 "EHLO
	exch01smtp12.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932080AbXAQI7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 03:59:04 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAHVzrUVZmGJA/2dsb2JhbAA
Message-ID: <3521.194.65.103.1.1169024309.squirrel@www.rncbc.org>
In-Reply-To: <20070117063144.GB14027@elte.hu>
References: <5114.194.65.103.1.1168943363.squirrel@www.rncbc.org>
    <20070116115638.GA6809@elte.hu>
    <47345.192.168.1.8.1168994713.squirrel@www.rncbc.org>
    <20070117063144.GB14027@elte.hu>
Date: Wed, 17 Jan 2007 08:58:29 -0000 (WET)
Subject: Re: Two 2.6.20-rc5-rt2 issues
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 17 Jan 2007 08:58:59.0646 (UTC) FILETIME=[BA3A5DE0:01C73A15]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, January 17, 2007 06:31, Ingo Molnar wrote:
>
> * Rui Nuno Capela <rncbc@rncbc.org> wrote:
>
>> Building this already with -rt5, still gives:
>> ...
>> LD      arch/i386/boot/compressed/vmlinux
>> OBJCOPY arch/i386/boot/vmlinux.bin
>> BUILD   arch/i386/boot/bzImage
>> Root device is (3, 2)
>> Boot sector 512 bytes.
>> Setup is 7407 bytes.
>> System is 1427 kB
>> Kernel: arch/i386/boot/bzImage is ready  (#1)
>> WARNING: "profile_hits" [drivers/kvm/kvm-intel.ko] undefined!
>> WARNING: "profile_hits" [drivers/kvm/kvm-amd.ko] undefined!
>>
>
> ok - in my test-config i didnt have KVM modular - the patch below should
> fix this problem.
>
> Ingo
>
>
> Index: linux/kernel/profile.c
> ===================================================================
> --- linux.orig/kernel/profile.c
> +++ linux/kernel/profile.c
> @@ -332,7 +332,6 @@ out:
> local_irq_restore(flags); put_cpu(); }
> -EXPORT_SYMBOL_GPL(profile_hits);
>
>
> static int __devinit profile_cpu_callback(struct notifier_block *info,
> unsigned long action, void *__cpu) @@ -402,6 +401,8 @@ void
> profile_hits(int type, void *__pc, }
> #endif /* !CONFIG_SMP */
>
>
> +EXPORT_SYMBOL_GPL(profile_hits);
> +
> void __profile_tick(int type, struct pt_regs *regs) {
> if (type == CPU_PROFILING && timer_hook)
>

OK, now it builds alright.

Both issues seem to be fixed now, thanks.

Bye.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
