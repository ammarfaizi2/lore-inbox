Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263105AbVEGNVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263105AbVEGNVf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 09:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbVEGNVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 09:21:34 -0400
Received: from mail.portrix.net ([212.202.157.208]:43238 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S263105AbVEGNUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 09:20:55 -0400
Message-ID: <427CC082.4000603@ppp0.net>
Date: Sat, 07 May 2005 15:20:02 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050331 Thunderbird/1.0.2 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: vince@kyllikki.org, Andrew Morton <akpm@osdl.org>, davej@redhat.com,
       torvalds@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <20050506235842.A23651@flint.arm.linux.org.uk> <427C9DBD.1030905@ppp0.net> <20050507122622.C11839@flint.arm.linux.org.uk>
In-Reply-To: <20050507122622.C11839@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Sat, May 07, 2005 at 12:51:41PM +0200, Jan Dittmer wrote:
> 
>>Sorry for tapping in so late. I don't follow lkml that close. For some time
>>I thought about providing semi-automatic mails of what architectures broke/
>>got fixed from one version to another, tracking mm/rc/git(?). Would that
>>be useful?
> 
> 
> We have http://armlinux.simtec.co.uk/kautobuild/ setup for ARM -
> it would be nice if it could generate mail reports and send them
> out, especially when failures occur.
> 
> I think it would need some post-processing and rate limiting to
> determine if there is a common problem across multiple platforms
> (eg, 40 builds failing due to rd_size), or just one platform (some
> local breakage).

Well I built something like this now which I mail to myself,
overlook and then going sent to lkml:

Comparing 2.6.12-rc3-mm2 to 2.6.12-rc3-mm3 (defconfig)

- arm: broke
    AR      arch/arm/lib/lib.a
    GEN     .version
    CHK     include/linux/compile.h
    UPD     include/linux/compile.h
    CC      init/version.o
    LD      init/built-in.o
    LD      .tmp_vmlinux1
  arch/arm/kernel/built-in.o(.init.text+0xb64): In function `$a':
  : undefined reference to `rd_size'
  make[1]: *** [.tmp_vmlinux1] Error 1
  make: *** [_all] Error 2
  Details: http://l4x.org/k/?d=3476

- m32r: broke
  : relocation truncated to fit: R_M32R_26_PCREL_RELA pcibus_to_node
  drivers/built-in.o(.text+0x46258): In function `init_irq':
  : undefined reference to `pcibus_to_node'
  drivers/built-in.o(.text+0x46258): In function `init_irq':
  : relocation truncated to fit: R_M32R_26_PCREL_RELA pcibus_to_node
  drivers/built-in.o(.text+0x4a15c): In function `idedisk_attach':
  : undefined reference to `pcibus_to_node'
  drivers/built-in.o(.text+0x4a15c): In function `idedisk_attach':
  : relocation truncated to fit: R_M32R_26_PCREL_RELA pcibus_to_node
  make[1]: *** [vmlinux] Error 1
  make: *** [_all] Error 2
  Details: http://l4x.org/k/?d=3483

- ppc: fixed

- um: fixed

- arm26: still broken
  Details: http://l4x.org/k/?d=3477

- cris: still broken
  Details: http://l4x.org/k/?d=3478

- frv: still broken
  Details: http://l4x.org/k/?d=3479

- h8300: still broken
  Details: http://l4x.org/k/?d=3480

- ia64: still broken
  Details: http://l4x.org/k/?d=3482

- m68k: still broken
  Details: http://l4x.org/k/?d=3484

- m68knommu: still broken
  Details: http://l4x.org/k/?d=3486

- parisc: still broken
  Details: http://l4x.org/k/?d=3488

- s390: still broken
  Details: http://l4x.org/k/?d=3491

- sh: still broken
  Details: http://l4x.org/k/?d=3492

- sh64: still broken
  Details: http://l4x.org/k/?d=3493

- v850: still broken
  Details: http://l4x.org/k/?d=3497

Summary: 8 ok, 14 failed
Link to this page: http://l4x.org/k/?diff[v1]=mm

-- 
Jan
