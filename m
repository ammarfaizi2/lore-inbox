Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272132AbTHNCUk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 22:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272136AbTHNCUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 22:20:40 -0400
Received: from adsl-66-141-253-47.dsl.kscymo.swbell.net ([66.141.253.47]:51841
	"EHLO hofmann1.gchofmann.org") by vger.kernel.org with ESMTP
	id S272132AbTHNCUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 22:20:37 -0400
Subject: Re: 2.6.0-test3-mm2
From: "G. Chris Hofmann" <hofmanng@swbell.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20030813154548.74a82cb7.andreas.mikkelborg@hjemme.no>
References: <20030813154548.74a82cb7.andreas.mikkelborg@hjemme.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060827802.2344.23.camel@hofmann1.gchofmann.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 13 Aug 2003 21:23:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a similar oops (it could be the same) on boot in mm1 with the
nforce2-i2c stuff compiled in, but have not tried mm2 yet.  I do not get
the oops with test1-ac3, however.  I have not had any time to narrow it
down to any particular patch, however, but wanted to add a me too and,
possibly a little bit of information, since somebody else mentioned it.

Chris

On Wed, 2003-08-13 at 08:45, Andreas Mikkelborg wrote:
> modprobe i2c-nforce2 segfaults and produces :
> 
> Unable to handle kernel NULL pointer dereference at virtual address 000001c4
>  printing eip:
> f899a068
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT 
> CPU:    0
> EIP:    0060:[<f899a068>]    Tainted: P   VLI
> EFLAGS: 00210246
> EIP is at nforce2_access+0x68/0x3d0 [i2c_nforce2]
> eax: 00000000   ebx: 00000000   ecx: 00000020   edx: 00000000
> esi: 00000000   edi: 00000002   ebp: 00000000   esp: f6a01d84
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 8213, threadinfo=f6a00000 task=f6b5c040)
> Stack: f6a14c40 00000024 c0172179 00000000 f6c92464 fffdb000 00000024 c0163113 
>        f6a14c40 00000007 00000000 00200024 f6dc4420 00000000 00000000 f6dc4404 
>        f882f190 f6dc4404 00000020 00000000 00000000 00000000 00000000 00000000 
> Call Trace:
>  [<c0172179>] simple_commit_write+0x89/0xa0
>  [<c0163113>] page_symlink+0x163/0x1f6
>  [<f882f190>] i2c_smbus_xfer+0xa0/0x230 [i2c_core]
>  [<f8838330>] i2c_detect+0x330/0x4b0 [i2c_sensor]
>  [<f887467b>] w83781d_attach_adapter+0x2b/0x30 [w83781d]
>  [<f88749c0>] w83781d_detect+0x0/0x9d0 [w83781d]
>  [<f882d1cd>] i2c_add_adapter+0x17d/0x190 [i2c_core]
>  [<c0208787>] snprintf+0x27/0x30
>  [<f899d13c>] nforce2_probe_smb+0x13c/0x1c0 [i2c_nforce2]
>  [<f899d226>] nforce2_probe+0x66/0x130 [i2c_nforce2]
>  [<c020bdc2>] pci_device_probe_static+0x52/0x70
>  [<c020bf2c>] __pci_device_probe+0x3c/0x50
>  [<c020bf6f>] pci_device_probe+0x2f/0x50
>  [<c0227e85>] bus_match+0x45/0x80
>  [<c0227fac>] driver_attach+0x5c/0x60
>  [<c0228243>] bus_add_driver+0x93/0xb0
>  [<c02286af>] driver_register+0x2f/0x40
>  [<c020c260>] pci_register_driver+0x70/0xa0
>  [<f899d303>] nforce2_init+0x13/0x3d [i2c_nforce2]
>  [<c013285c>] sys_init_module+0x12c/0x250
>  [<c02a7b6b>] syscall_call+0x7/0xb
> 
> Code: e0 04 66 85 c0 75 05 c6 44 24 27 00 83 7c 24 58 0b 0f 87 4c 03 00 00 8b 44
>  24 58 ff 24 85 94 a4 99 f8 8b 54 24 28 83 cf 02 31 ed <8b> b2 c4 01 00 00 0f b6 44 24 2e 8d 56 02 00 c0 ee e6 80 89 f8 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
