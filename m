Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVFMA36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVFMA36 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 20:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVFMA36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 20:29:58 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:63026 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261295AbVFMA3l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 20:29:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dPLFD7g8/g2hWL996TX9JY4gOe5dG6uA0i9nnx8BblxIHwxnIauuA25NLB+7M9DzGD1FD54hH6l2+eG/amV/+XgkUElrgnyXaASlpuXurujNQ+N+KMeS8H3PrydLmbLUUsLShMZdRlPMqHW3zJ6bWlrnHoN30lzv4VGFmU704Hg=
Message-ID: <e27e3474050612172973387597@mail.gmail.com>
Date: Mon, 13 Jun 2005 03:29:39 +0300
From: Kemal Hadimli <disqkk@gmail.com>
Reply-To: Kemal Hadimli <disqkk@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: poor performance with HIGHMEM?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Recently i'm having performance problems with my P4-HT highmem system.
Tried two motherboards, different RAM chips (4x1gig and 4x512mb), but
the problem remains unchanged. In my case i found that the 2.4 (2.4.26
and 2.4.30) series are faster than the 2.6 (tried with 2.6.0, 2.6.6,
2.6.7, 2.6.7-bk4, 2.6.10, and the recent 2.6.11.12) series. But the
performance is still very poor compared to what i get with lowmem.

The performance gets much better if I force 768megs of ram (passing
the "mem=768" parameter) so it looks like the problem is highmem. The
box normally has 4 gigabytes of ram (4 sticks of 1 Gig, PC3200) and
handles mostly mySQL+Apache2+PHP4.

Kernel parameters:
CONFIG_HIGHMEM64G=y (I am told that CONFIG_HIGHMEM4G would lead to bad
performance. there's no other reason i'm using 64G and not 4G)

whole configs are accessible at:
http://www.ehore.com/kernel/config-2.4.30
http://www.ehore.com/kernel/config-2.6.11.12


The motherboards I tried and the /proc/mtrr and E820 output:

ASUS P4P800-SE
reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1
reg02: base=0xc0000000 (3072MB), size= 512MB: write-back, count=1
reg03: base=0xe0000000 (3584MB), size= 256MB: write-back, count=1
reg04: base=0xf0000000 (3840MB), size= 128MB: write-back, count=1
reg05: base=0xf8000000 (3968MB), size=  64MB: write-back, count=1

 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000fd430000 (usable)
 BIOS-e820: 00000000fd430000 - 00000000fd440000 (ACPI data)
 BIOS-e820: 00000000fd440000 - 00000000fd4f0000 (ACPI NVS)
 BIOS-e820: 00000000fd4f0000 - 00000000fd500000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)


Gigabyte GA-8IG1000-G (onboard vga, configured as 1mb)
reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1
reg02: base=0xc0000000 (3072MB), size= 512MB: write-back, count=1
reg03: base=0xe0000000 (3584MB), size= 128MB: write-back, count=1
reg04: base=0xe7f00000 (3711MB), size=   1MB: uncachable, count=1

 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000e7ef0000 (usable)
 BIOS-e820: 00000000e7ef0000 - 00000000e7ef3000 (ACPI NVS)
 BIOS-e820: 00000000e7ef3000 - 00000000e7f00000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)



So, what are your .config/patch/version recommendations for a highmem
system like this one?


Hoping to get some replies, and thanks for your time :)

--
Kemal
