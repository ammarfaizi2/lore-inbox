Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVGZFhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVGZFhj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 01:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVGZFhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 01:37:39 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:40050 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261685AbVGZFhh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 01:37:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GhPYQxaQgic57EHECCMlwDYXwPhUIFzBIPrkSIQ6d/V+e+yx0Epc6XbUgPXTt9tSLelj9nTLSMFp5NH8XehDup5TcdetXqwen0+TVT+Kat+p4MDuX9Pr89en6VWjKiXaZJVCwlWna/RceFHxXjmovlsvc1qJpX8kw1Gx1rWrHnM=
Message-ID: <105c793f050725223733964f55@mail.gmail.com>
Date: Tue, 26 Jul 2005 01:37:37 -0400
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: BUG: Yamaha OPL3SA2 does not work with ALSA on 2.6 kernels.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org
In-Reply-To: <20050725232604.GH3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <105c793f05072507315cfd1878@mail.gmail.com>
	 <20050725232604.GH3160@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/05, Adrian Bunk <bunk@stusta.de> wrote:
> Does the OSS driver work in 2.6?
I was able to get the OSS module (opl3sa2) installed in 2.6 and I was
able to get some nice hiss when doing 'cat /dev/urandom > /dev/dsp'. I
used the following modprobe line:

modprobe opl3sa2 io=0x370 irq=11 dma=0 dma2=1 mss_io=0x530 isapnp=0

the isapnp=0 part appeared to be required. The following showed up in
dmesg upon inserting the OSS module:

opl3sa2: Chipset version = 0x7
opl3sa2: Found OPL3-SA3 (YMF715E or YMF719E)

However, when I try to rmmod the opl3sa2 module, I get an Oops:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c037ae01
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: opl3sa2 ad1848 mpu401 sound soundcore vfat fat
sd_mod usb_storage lp parport ide_scsi rtc
CPU:    0
EIP:    0060:[<c037ae01>]    Not tainted VLI
EFLAGS: 00010046   (2.6.12.2)
EIP is at wait_for_completion+0x71/0xf0
eax: cca91180   ebx: c52ea000   ecx: c52ebf20   edx: 00000000
esi: c52ea000   edi: cca9117c   ebp: c52ebf40   esp: c52ebef4
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 11277, threadinfo=c52ea000 task=c79ce550)
Stack: 00000000 c79ce550 c0113cf0 00000000 00000000 c52ea000 c0e899e0 c0209ffe
       00000001 c79ce550 c0113cf0 cca91180 00000114 00000001 00000000 cca91174
       00000114 00000001 00000000 c52ea000 cca8f964 cca91174 00000000 cca91200
Call Trace:
 [<c0113cf0>] default_wake_function+0x0/0x20
 [<c0209ffe>] kobject_put+0x1e/0x30
 [<c0113cf0>] default_wake_function+0x0/0x20
 [<cca8f964>] cleanup_opl3sa2+0x74/0x8c [opl3sa2]
 [<c0131bc8>] sys_delete_module+0x178/0x1b0
 [<c015b2c0>] sys_munmap+0x50/0x80
 [<c0103205>] syscall_call+0x7/0xb
Code: 00 00 8b 03 c7 45 d4 01 00 00 00 c7 45 bc f0 3c 11 c0 c7 45 dc
f0 3c 11 c0 89 45 b8 89 45 d8 8d 47 04 8b 50 04 89 45 e0 89 48 04 <89>
0a 89 55 e4 8d 76 00 8d bc 27 00 00 00 00 8b 03 c7 00 02 00
 <6>note: rmmod[11277] exited with preempt_count 1

and now when I try to rmmod the module again, I get:

ERROR: Removing 'opl3sa2': Device or resource busy

So, yes, given the correct parameters, the OSS module (just like the
ALSA module) works with the occasional Oops. I guess the Oopses are
acceptable for now; it's the ALSA detection routines that are broken
themselves or that are broken by something in the 2.6 kernel (remember
that they work fine in 2.4).

Thanks.

-Andy
