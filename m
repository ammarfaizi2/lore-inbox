Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276800AbRJPWia>; Tue, 16 Oct 2001 18:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276813AbRJPWiX>; Tue, 16 Oct 2001 18:38:23 -0400
Received: from mail.cs.umn.edu ([128.101.33.100]:41179 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id <S276800AbRJPWiO>;
	Tue, 16 Oct 2001 18:38:14 -0400
To: "Michael F. Robbins" <mike@gamerack.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS 2.4.12 on AC97 Trident ALi 5451
In-Reply-To: <1003059594.959.13.camel@tbird.robbins>
From: Raja R Harinath <harinath@cs.umn.edu>
Date: Tue, 16 Oct 2001 17:38:44 -0500
In-Reply-To: <1003059594.959.13.camel@tbird.robbins> ("Michael F. Robbins"'s
 message of "14 Oct 2001 07:39:54 -0400")
Message-ID: <d93d4j1a8b.fsf@han.cs.umn.edu>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.0.106
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Michael F. Robbins" <mike@gamerack.com> writes:
> I'm trying to use the ECS K7AMA motherboard with onboard sound.  I'm
> using 2.4.7 with the sound working fine right now (with the trident
> driver).  I haven't tried 2.4.8, but 2.4.9 through 2.4.12 have given me
> trouble with the sound drivers.

I can replicate the same oops w/ 2.4.13-pre2.
 
> The system is an Athlon 1200, ECS K7AMA with ALi 1645 northbridge and
> Magic 1535D+ southbridge, Inno3D GeForce 2 GTS 32MB, onboard RTL8139
> network, 512MB PC133, and 2 harddrives in a software RAID-1
> configuration.  Also running a Promise Ultra 66 controller.  The ECS
> website says "AC97 Audio Codec compliant with AC97 2.1 specification".

I have a PCChips M817LMR (ALi 1647 northbridge + 1535D+ south), V770
Riva TNT 2, onboard RTL 8139c, 512MB DDR.

[snip]
> System log from immediately after issuing "modprobe trident":
> ------------------
> Oct 11 21:36:00 tbird kernel: Trident 4DWave/SiS 7018/ALi 5451,Tvia
> CyberPro 5050 PCI Audio, version 0.14.9c, 21:28:32 Oct 11 2001
> Oct 11 21:36:00 tbird kernel: PCI: Assigned IRQ 10 for device 00:03.0
> Oct 11 21:36:00 tbird kernel: trident: ALi Audio Accelerator found at IO
> 0xc400, IRQ 10
> Oct 11 21:36:00 tbird kernel: ac97_codec: AC97 Audio codec, id:
> 0x414c:0x4326 (Unknown)
> Oct 11 21:36:00 tbird kernel: ali: AC97 CODEC read timed out.
> Oct 11 21:36:00 tbird kernel: ali: AC97 CODEC write timed out.
> Oct 11 21:36:00 tbird kernel: ali: AC97 CODEC read timed out.
> Oct 11 21:36:00 tbird last message repeated 2 times
> Oct 11 21:36:00 tbird kernel: ac97_codec: AC97  codec, id: 0x0000:0x0000
> (Unknown)
> Oct 11 21:36:00 tbird kernel: ali: AC97 CODEC read timed out.
> Oct 11 21:36:00 tbird kernel: ali: AC97 CODEC write timed out.
> Oct 11 21:36:00 tbird kernel: ali: AC97 CODEC read timed out.
> ------------------
> and immediately after this the oops begins.  I'm just guessing, but the
> "Unknown" readings for the AC97 codec type seem strange, however

Likewise.

[snip]
>>>EIP; e5991d7e <[ac97_codec]ac97_init_mixer+7e/e0>   <=====
> Trace; e5999f9b <[trident]trident_ac97_init+22b/2f0>
> Trace; e599b100 <[trident]trident_audio_fops+0/48>
> Trace; e599a431 <[trident]trident_probe+3d1/4b0>
> Trace; e599b048 <[trident]trident_pci_tbl+54/a8>
> Trace; e599b1c0 <[trident]trident_pci_driver+0/3f>
> Trace; c01af934 <pci_announce_device+34/50>
> Trace; e599b048 <[trident]trident_pci_tbl+54/a8>
> Trace; e599b1c0 <[trident]trident_pci_driver+0/3f>
> Trace; c01af992 <pci_register_driver+42/60>
> Trace; e599b1c0 <[trident]trident_pci_driver+0/3f>
> Trace; e599a614 <[trident]trident_init_module+24/50>
> Trace; e599b1c0 <[trident]trident_pci_driver+0/3f>
> Trace; e599aec0 <[trident]__module_pci_device_size+614/693>
> Trace; e599b1c0 <[trident]trident_pci_driver+0/3f>
> Trace; e599aec0 <[trident]__module_pci_device_size+614/693>
> Trace; c01142c5 <sys_init_module+525/5e0>
> Trace; e599b840 <.bss.end+1/????>
> Trace; e5995060 <[trident]trident_enable_loop_interrupts+0/80>
> Trace; c0106edb <system_call+33/38>
> Code;  e5991d7e <[ac97_codec]ac97_init_mixer+7e/e0>
> 00000000 <_EIP>:
> Code;  e5991d7e <[ac97_codec]ac97_init_mixer+7e/e0>   <=====
>    0:   8b 00                     mov    (%eax),%eax   <=====
> Code;  e5991d80 <[ac97_codec]ac97_init_mixer+80/e0>
>    2:   85 c0                     test   %eax,%eax
> Code;  e5991d82 <[ac97_codec]ac97_init_mixer+82/e0>
>    4:   74 04                     je     a <_EIP+0xa> e5991d88
> <[ac97_codec]ac97_init_mixer+88/e0>
> Code;  e5991d84 <[ac97_codec]ac97_init_mixer+84/e0>
>    6:   53                        push   %ebx
> Code;  e5991d85 <[ac97_codec]ac97_init_mixer+85/e0>
>    7:   ff d0                     call   *%eax
> Code;  e5991d87 <[ac97_codec]ac97_init_mixer+87/e0>
>    9:   5a                        pop    %edx
> Code;  e5991d88 <[ac97_codec]ac97_init_mixer+88/e0>
>    a:   31 ed                     xor    %ebp,%ebp
> Code;  e5991d8a <[ac97_codec]ac97_init_mixer+8a/e0>
>    c:   83 3d e0 31 99 e5 ff      cmpl   $0xffffffff,0xe59931e0
> Code;  e5991d91 <[ac97_codec]ac97_init_mixer+91/e0>
>   13:   ba 00 00 00 00            mov    $0x0,%edx
> 
> 2 warnings issued.  Results may not be reliable.
> ----------------

Likewise.

- Hari
-- 
Raja R Harinath ------------------------------ harinath@cs.umn.edu
"When all else fails, read the instructions."      -- Cahn's Axiom
"Our policy is, when in doubt, do the right thing."   -- Roy L Ash
