Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVG1Xru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVG1Xru (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 19:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVG1Xru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 19:47:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49869 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262150AbVG1Xrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 19:47:42 -0400
Date: Thu, 28 Jul 2005 16:46:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Thonke <iogl64nx@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
Message-Id: <20050728164640.062286fe.akpm@osdl.org>
In-Reply-To: <42E96A42.7060405@gmail.com>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	<42E96A42.7060405@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Thonke <iogl64nx@gmail.com> wrote:
>
> here again I have two problems. With 2.6.13-rc3-mm3 I have problems 
>  using my SATA drives on Intel ICH6.
>  The kernel can't route there IRQs or can't discover them. the option 
>  irqpoll got them to work now.
>  The problem is new because 2.6.13-rc3[-mm1,mm2] work without any problems.

OK.  Please generate the full dmesg output for -mm2 and for -mm3 and run
`diff -u dmesg.mm2 dmesg.mm3' and send it?  And keep those files because we
may end up needing to add them to an acpi bugzilla entry ;)

>  The SATA drives are Samsung HD160JJ SATAII. The mainboard I use is a 
>  ASUS P4GPL-X.
> 
>  Second one is about Intel HD-Codec (snd-hda-intel) on modprobe when 
>  loading the module it gives me
> 
>  ---> snip
>  hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...

Does -mm2 print that `unknown model' message?

>  Unable to handle kernel NULL pointer dereference at virtual address 00000000
>   printing eip:
>  f88713f4
>  *pde = 00000000
>  Oops: 0002 [#1]
>  PREEMPT
>  last sysfs file:
>  Modules linked in: snd_hda_intel snd_hda_codec nvidia
>  CPU:    0
>  EIP:    0060:[<f88713f4>]    Tainted: P      VLI

Please verify that it happens without the nvidia module loaded.

>  EFLAGS: 00010293   (2.6.13-rc3-mm3pm)
>  eax: fffffffe   ebx: f3b33548   ecx: 00000000   edx: 00000000
>  esi: f3b33400   edi: 00000000   ebp: 00000006   esp: f0371ddc
>  ds: 007b   es: 007b   ss: 0068
>  Process modprobe (pid: 7398, threadinfo=f0370000 task=f4183560)
>  Stack: 00000000 00000000 00000000 00000000 f3b33400 f3b33548 f0f1d000 
>  f8871933
>         f3b33400 f0f1d000 f8871bbd f8875478 f88748f6 00000001 f886d77e 
>  00000f00
>         00000005 00000000 f0f1d000 f54d04c0 00000000 f886d984 00000f00 
>  00000002
>  Call Trace:
>   [<f8871933>]
>   [<f8871bbd>]

Odd trace.  Do you have CONFIG_KALLSYMS enabled?  If not, please turn it on.
