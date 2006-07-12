Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWGLK4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWGLK4x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 06:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWGLK4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 06:56:53 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:38646 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750902AbWGLK4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 06:56:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nCAmxVWAUTVGIr3D9g/JTHcT53hjOeCF9wHtUsIvlm3ruBUhwGiglnVKOAvs0/DNCeDZT14OPL7hNO2Th3h8B/6kcjwWZ0UBc8aqJiZaBkV4F6Reh7UzaDJRjhUavLRy9pnMwHwCkzccNHrN4mMDr0+6IJxL75EUM4bqpcImIn4=
Message-ID: <d9def9db0607120356s2ab659dfq65841869ae86821b@mail.gmail.com>
Date: Wed, 12 Jul 2006 12:56:52 +0200
From: "Markus Rechberger" <mrechberger@gmail.com>
To: "Antonio Mignolli" <antoniomignolli@gmail.com>
Subject: Re: BUG report
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a790ea7a0607081904o61ac9158k74d476503ab26367@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a790ea7a0607081904o61ac9158k74d476503ab26367@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this very likely has nothing to do with the TV tuner.
There's an issue if you access an usbaudio device and unplug it the
system might lock up the keyboard.
Also mozilla caused that issue on your side, so I only know that dumb
written mozilla plugins directly access /dev/dsp* /dev/mixer* devices
and don't release them (especially the mixer one)
This causes problems in the alsa framework...
I think the pinnacle 50e supports digital audio -> a part of that
device acts as a usb audio device.
You could also blame the firefox guys to document their plugin
interface once in this century rather than adding more new bugged
code... (I made some experience with that part a while ago)

Markus

On 7/9/06, Antonio Mignolli <antoniomignolli@gmail.com> wrote:
> I'm on a Slackware with kernel 2.6.17.3 obtained by applying patch-2.6.17.3
> to kernel 2.6.17.
> I plugged a Pinnacle pctv 50e USB tv card.
> It works correctly, I was trying it.
> After a while, I disconnected it and after very few seconds
> I plugged an external USB hard drive.
> For a couple of minutes, USB hub seemed to be not working.
> No messages on dmesg indicating a new device (usually /dev/sda,
> I have all the modules for that.)
> After about two minutes, the USB hub woke up (/dev/sda created, USB
> mouse working)
> and on syslog and on every terminal on my
> desktop appeared some messages.
>
> TERMINAL MESSAGES:
>
> Message from syslogd@slacky at Wed Jul  5 23:38:39 2006 ...
> slacky kernel: Oops: 0002 [#1]
>
> Message from syslogd@slacky at Wed Jul  5 23:38:39 2006 ...
> slacky kernel: PREEMPT
>
> Message from syslogd@slacky at Wed Jul  5 23:38:39 2006 ...
> slacky kernel: CPU:    0
>
> Message from syslogd@slacky at Wed Jul  5 23:38:39 2006 ...
> slacky kernel: EIP is at __fput+0xab/0x140
>
> Message from syslogd@slacky at Wed Jul  5 23:38:39 2006 ...
> slacky kernel: eax: 00000007   ebx: d613c000   ecx: d61cc030   edx: c01ebbf7
>
> Message from syslogd@slacky at Wed Jul  5 23:38:39 2006 ...
> slacky kernel: esi: d3ba2780   edi: d9548184   ebp: d94ede14   esp: d613df6c
>
> Message from syslogd@slacky at Wed Jul  5 23:38:39 2006 ...
> slacky kernel: ds: 007b   es: 007b   ss: 0068
>
> Message from syslogd@slacky at Wed Jul  5 23:38:39 2006 ...
> slacky kernel: Process firefox-bin (pid: 5500, threadinfo=d613c000
> task=d61cc030)
>
> Message from syslogd@slacky at Wed Jul  5 23:38:39 2006 ...
> slacky kernel: Stack: df7c4f40 d3ba2780 df68c5c0 00000000 d613c000
> c0147fda d3ba2780 df68c5c0
>
> Message from syslogd@slacky at Wed Jul  5 23:38:39 2006 ...
> slacky kernel:        d3ba2780 df68c5c0 d613c000 df68c5c0 d3ba2780
> c014803c d3ba2780 df68c5c0
>
> Message from syslogd@slacky at Wed Jul  5 23:38:39 2006 ...
> slacky kernel:        00000030 00000002 09557fb0 c01025d7 00000030
> 00000000 b68c7600 00000002
>
> Message from syslogd@slacky at Wed Jul  5 23:38:39 2006 ...
> slacky kernel: Call Trace:
>
> Message from syslogd@slacky at Wed Jul  5 23:38:39 2006 ...
> slacky kernel:  <c0147fda> filp_close+0x4c/0x55  <c014803c> sys_close+0x59/0x7c
>
> Message from syslogd@slacky at Wed Jul  5 23:38:39 2006 ...
> slacky kernel:  <c01025d7> syscall_call+0x7/0xb
>
> Message from syslogd@slacky at Wed Jul  5 23:38:39 2006 ...
> slacky kernel: Code: 38 58 5a 8b 87 f4 00 00 00 85 c0 74 07 50 e8 6a
> 6e 00 00 58 8b 46 10 85 c0
>  74 35 8b 00 85 c0 74 2f bb 00 e0 ff ff 21 e3 ff 43 14 <ff> 88 00 01
> 00 00 83 38 02 75 0b 8b 80
>  88 01 00 00 e8 08 67 fc
>
> Message from syslogd@slacky at Wed Jul  5 23:38:39 2006 ...
> slacky kernel: EIP: [<c01493c9>] __fput+0xab/0x140 SS:ESP 0068:d613df6c
>
>
> SYSLOG MESSAGES:
>
> Jul  5 23:38:39 slacky kernel: BUG: unable to handle kernel NULL
> pointer dereference at virtual
>  address 00000107
> Jul  5 23:38:39 slacky kernel:  printing eip:
> Jul  5 23:38:39 slacky kernel: c01493c9
> Jul  5 23:38:39 slacky kernel: *pde = 00000000
> Jul  5 23:38:39 slacky kernel: Oops: 0002 [#1]
> Jul  5 23:38:39 slacky kernel: PREEMPT
> Jul  5 23:38:39 slacky kernel: Modules linked in: vfat fat snd_pcm_oss
> snd_mixer_oss snd_usb_au
> dio snd_usb_lib snd_rawmidi snd_seq_device snd_hwdep tda9887 tuner
> saa7115 em28xx compat_ioctl3
> 2 v4l1_compat v4l2_common ir_common videodev tveeprom i2c_core eth1394
> snd_intel8x0 snd_intel8x
> 0m snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd snd_page_alloc
> yenta_socket rsrc_nonstatic
>  pcmcia_core ohci1394 b44 joydev fuse evdev
> Jul  5 23:38:39 slacky kernel: CPU:    0
> Jul  5 23:38:39 slacky kernel: EIP:    0060:[<c01493c9>]    Not tainted VLI
> Jul  5 23:38:39 slacky kernel: EFLAGS: 00010202   (2.6.17.3 #7)
> Jul  5 23:38:39 slacky kernel: EIP is at __fput+0xab/0x140
> Jul  5 23:38:39 slacky kernel: eax: 00000007   ebx: d613c000   ecx:
> d61cc030   edx: c01ebbf7
> Jul  5 23:38:39 slacky kernel: esi: d3ba2780   edi: d9548184   ebp:
> d94ede14   esp: d613df6c
> Jul  5 23:38:39 slacky kernel: ds: 007b   es: 007b   ss: 0068
> Jul  5 23:38:39 slacky kernel: Process firefox-bin (pid: 5500,
> threadinfo=d613c000 task=d61cc03
> 0)
> Jul  5 23:38:39 slacky kernel: Stack: df7c4f40 d3ba2780 df68c5c0
> 00000000 d613c000 c0147fda d3b
> a2780 df68c5c0
> Jul  5 23:38:39 slacky kernel:        d3ba2780 df68c5c0 d613c000
> df68c5c0 d3ba2780 c014803c d3b
> a2780 df68c5c0
> Jul  5 23:38:39 slacky kernel:        00000030 00000002 09557fb0
> c01025d7 00000030 00000000 b68
> c7600 00000002
> Jul  5 23:38:39 slacky kernel: Call Trace:
> Jul  5 23:38:39 slacky kernel:  <c0147fda> filp_close+0x4c/0x55
> <c014803c> sys_close+0x59/0x7c
> Jul  5 23:38:39 slacky kernel:  <c01025d7> syscall_call+0x7/0xb
> Jul  5 23:38:39 slacky kernel: Code: 38 58 5a 8b 87 f4 00 00 00 85 c0
> 74 07 50 e8 6a 6e 00 00 5
> 8 8b 46 10 85 c0 74 35 8b 00 85 c0 74 2f bb 00 e0 ff ff 21 e3 ff 43 14
> <ff> 88 00 01 00 00 83 3
> 8 02 75 0b 8b 80 88 01 00 00 e8 08 67 fc
> Jul  5 23:38:39 slacky kernel: EIP: [<c01493c9>] __fput+0xab/0x140
> SS:ESP 0068:d613df6c
> Jul  5 23:38:39 slacky kernel:  <6>note: firefox-bin[5500] exited with
> preempt_count 1
> Jul  5 23:38:39 slacky kernel: hub 1-0:1.0: over-current change on port 2
> Jul  5 23:38:39 slacky kernel: hub 2-0:1.0: over-current change on port 1
> Jul  5 23:38:39 slacky kernel: hub 2-0:1.0: over-current change on port 2
> Jul  5 23:38:40 slacky kernel: hub 1-0:1.0: over-current change on port 1
> Jul  5 23:40:37 slacky kernel: hub 1-0:1.0: over-current change on port 1
> Jul  5 23:40:37 slacky kernel: hub 2-0:1.0: over-current change on port 1
> Jul  5 23:40:44 slacky kernel: sda: assuming drive cache: write through
> Jul  5 23:40:44 slacky kernel: sda: assuming drive cache: write through
>
>
>
> Hope it helps.
> Bye.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


-- 
Markus Rechberger
