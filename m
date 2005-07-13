Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262614AbVGMHRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbVGMHRa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 03:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbVGMHRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 03:17:30 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:59066 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262614AbVGMHR3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 03:17:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e2nJBphVeFH9+44zaPQ94Lm2BiYTqCsKkKpmjTRK7Pq9Xn+piuVTntE17RfMFdzwrzMfwXXz1oeldDLUKicMPbec14kARgajGckCOaIRf2L7G9vfqLW/RAdEHeKwE/p7m0cJKRDU5Krea61z6slrbadzrVDpCKy0bwxIT47JFTk=
Message-ID: <21d7e99705071300173ae0c39b@mail.gmail.com>
Date: Wed, 13 Jul 2005 17:17:28 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Miles Lane <miles.lane@gmail.com>
Subject: Re: OOPS in 2.6.13-rc1-mm1 -- EIP is at sysfs_release+0x49/0xb0
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1121055986.10029.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a44ae5cd05070301417531fac2@mail.gmail.com>
	 <21d7e9970507070331107831c6@mail.gmail.com>
	 <1121055986.10029.9.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks Dave,
> 
> I switched to the i915 kernel driver and still got the OOPS.
> I also continue to get the overlapping mtrr message.  I am currently
> testing 2.6.13-rc2-git3.  I have tried to run strace with hald, but
> cannot reproduce the problem this way.  I am not sure I am invoking the
> command corrently.  I have written to the hal developers, but have not
> received a response yet.  Here's the current output:
> 

Can you try and see if you apply the patch from

http://lkml.org/lkml/2005/7/8/257

It should apply to your kernel.. I cannot get this to happen on my
system... the mtrr overlaps are just vesafb setting up the mtrrs, you
might try without vesafb...

Dave.

> mtrr: base(0xe8020000) is not aligned on a size(0x3c0000) boundary
> mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x1000000
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
> apm: overridden by ACPI.
> Unable to handle kernel paging request at virtual address 5f78735f
>  printing eip:
> c01e491a
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT
> Modules linked in: pcmcia ipv6 af_packet ohci1394 yenta_socket
> rsrc_nonstatic pcmcia_core ipw2200 firmware_class ieee80211
> ieee80211_crypt 8139too mii snd_intel8x0 snd_ac97_codec snd_pcm_oss
> snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc i2c_i801
> uhci_hcd rtc nls_cp437 sbp2 ieee1394 psmouse ide_cd cdrom
> CPU:    0
> EIP:    0060:[<c01e491a>]    Not tainted VLI
> EFLAGS: 00010206   (2.6.13-rc2-git3)
> EIP is at sysfs_release+0x4e/0xa6
> eax: 5f78735f   ebx: c1b0e268   ecx: 00000001   edx: c9138000
> esi: 5f78725f   edi: c93dfde0   ebp: c9139f3c   esp: c9139f2c
> ds: 007b   es: 007b   ss: 0068
> Process hald (pid: 4615, threadinfo=c9138000 task=c9092a80)
> Stack: c1b0e268 c90c6658 00000000 c18a4a70 c9139f60 c018c8cd c8c0f3d0
> c90c6658
>        c93f87b0 c8c0f3d0 c90c6658 00000000 f731dab0 c9139f68 c018c86b
> c9139f84
>        c018aca9 c90c6658 f731dab0 c90c6658 f731dab0 00000010 c9139fb4
> c018addb
> Call Trace:
>  [<c0104bde>] show_stack+0x9c/0xd2
>  [<c0104dce>] show_registers+0x19a/0x234
>  [<c0105049>] die+0x152/0x2e2
>  [<c011d740>] do_page_fault+0x250/0x6fa
>  [<c01046b7>] error_code+0x4f/0x54
>  [<c018c8cd>] __fput+0x5c/0x174
>  [<c018c86b>] fput+0x18/0x1e
>  [<c018aca9>] filp_close+0x4a/0x70
>  [<c018addb>] sys_close+0x10c/0x266
>  [<c0103bb3>] sysenter_past_esp+0x54/0x75
> Code: 78 85 db 74 08 89 1c 24 e8 68 c8 08 00 85 f6 74 39 b8 01 00 00 00
> e8 c8 e5 f3 ff e8 51 1a 09 00 c1 e0 07 05 00 01 00 00 8d 04 06 <ff> 08
> 83 3e 02 74 3c b8 01 00 00 00 e8 d9 e5 f3 ff b8 00 e0 ff
>  <6>note: hald[4615] exited with preempt_count 1
> Debug: sleeping function called from invalid context at
> include/linux/rwsem.h:43in_atomic():1, irqs_disabled():0
>  [<c0104c32>] dump_stack+0x1e/0x20
>  [<c0124b69>] __might_sleep+0x9e/0xad
>  [<c012bf0f>] exit_mm+0x3a/0x2b0
>  [<c012cd0a>] do_exit+0xe0/0x83b
>  [<c01051cf>] die+0x2d8/0x2e2
>  [<c011d740>] do_page_fault+0x250/0x6fa
>  [<c01046b7>] error_code+0x4f/0x54
>  [<c018c8cd>] __fput+0x5c/0x174
>  [<c018c86b>] fput+0x18/0x1e
>  [<c018aca9>] filp_close+0x4a/0x70
>  [<c018addb>] sys_close+0x10c/0x266
>  [<c0103bb3>] sysenter_past_esp+0x54/0x75
> 
> 
>
