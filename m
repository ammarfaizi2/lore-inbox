Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266769AbUHQXj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266769AbUHQXj6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 19:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268523AbUHQXj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 19:39:58 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:392 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266769AbUHQXj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 19:39:56 -0400
Date: Wed, 18 Aug 2004 00:37:32 +0100
From: Dave Jones <davej@redhat.com>
To: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Oops modprobing i830 with 2.6.8.1
Message-ID: <20040817233732.GA8264@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>,
	linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
References: <20040817220816.GA14343@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040817220816.GA14343@hardeman.nu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 12:08:18AM +0200, David Härdeman wrote:
 > [drm:i830_probe] *ERROR* Cannot initialize the agpgart module.

You don't have agpgart (and an agp chipset subdriver) loaded, yet
drm 'needs' it.
 
 > inter_module_unregister: no entry for 'drm'------------[ cut here 
 > kernel BUG at kernel/intermodule.c:104!

The inter_module_* stuff has been totally broken for some time.
At one point Rusty proposed killing it off completely.
Too bad it didn't happen.

 > invalid operand: 0000 [#1]
 > PREEMPT 
 > Modules linked in: i830 snd_pcm_oss snd_mixer_oss snd_intel8x0 
 > snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart 
 > snd_rawmidi snd rtc hw_random thermal processor fan button battery ac 
 > uhci_hcd ehci_hcd usbcore nvram
 > CPU:    0
 > EIP:    0060:[<c01277e6>]    Not tainted
 > EFLAGS: 00010282   (2.6.8.1) 
 > EIP is at inter_module_unregister+0x9b/0xe4
 > eax: 0000002e   ebx: d07bb7ef   ecx: c02cea90   edx: 00000282 
 > esi: 00000000   edi: 00000000   ebp: c02d00a0   esp: ce08bf14
 > ds: 007b   es: 007b   ss: 0068
 > Process modprobe (pid: 1362, threadinfo=ce08a000 task=cec44840)
 > Stack: c029e5a0 d07bb7ef ffffffff 00000000 00000000 00000000 d07b5ed1 
 > d07bb7ef d07bb7ef d07bf020 d07bf020 cf60c800 d07bf69c d07b238a 
 >       d07bb5e1 d07be720 d07bf020 00000000 00000000 00000010 cf60cc00 
 >       ce08a000 d07bee00 c02d0260 Call Trace:
 > [<d07b5ed1>] i830_stub_register+0xb9/0x1c8 [i830]
 > [<d07b238a>] i830_probe+0xe0/0x27f [i830]
 > [<c01b949a>] pci_find_device+0x2f/0x33
 > [<d0709047>] drm_init+0x47/0x66 [i830]
 > [<c012dbd1>] sys_init_module+0x117/0x22f 
 > [<c0105f47>] syscall_call+0x7/0xb

Though the DRM stuff really should handle failure a little
more gracefully.

		Dave

