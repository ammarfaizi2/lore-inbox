Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161558AbWJaB0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161558AbWJaB0d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 20:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161567AbWJaB0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 20:26:32 -0500
Received: from nz-out-0102.google.com ([64.233.162.203]:12397 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1161558AbWJaB0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 20:26:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=bSC8iAJcAZQlkz0G0vdbhVn9fxQ/1kDAVwCVooT/8Q1dINVfQeSel1uY+esThGGCcVRC05x1PYu781ZOSra5zrx0gTGJHsUYUkWIeNlbh7/Q22HBoS8+yD17u//i+eO/j+Hl086gHWZT/69kIqcXN6BzbDNgkLZr+Qj8e94V4OE=
Reply-To: andrew.j.wade@gmail.com
To: Andrew Morton <akpm@osdl.org>
Subject: [2.6.19-rc3-mm1] BUG at arch/i386/mm/pageattr.c:165
Date: Mon, 30 Oct 2006 20:26:24 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20061029160002.29bb2ea1.akpm@osdl.org>
In-Reply-To: <20061029160002.29bb2ea1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610302026.24724.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got the BUG below while booting. -rc2-mm2 worked fine, but with a
different .config. I'm going to try and narrow this down further.

cheers,
Andrew Wade

agpgart: Detected VIA KT266/KY266x/KT333 chipset
agpgart: unable to get minor: 175
agpgart: agp_frontend_initialize() failed.
------------[ cut here ]------------
kernel BUG at arch/i386/mm/pageattr.c:165!
invalid opcode: 0000 [#1]
last sysfs file: 
CPU:    0
EIP:    0060:[<c010fdd7>]    Not tainted VLI
EFLAGS: 00010082   (2.6.19-rc3-mm1 #1)
EIP is at change_page_attr+0x167/0x234
eax: 1fc001e3   ebx: c1009c80   ecx: dfc20000   edx: c04e4dfc
esi: 1fc20000   edi: e0820000   ebp: 00000005   esp: dffc5e7c
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, ti=dffc4000 task=dffc3530 task.ti=dffc4000)
Stack: 00000011 c13f8400 00000010 00000292 c04e4dfc dfc20000 00000163 00000163 
       c13f8200 dfe66984 e0820000 00000005 c010fab8 c03ee740 c03ee740 dfe2334c 
       00000004 e080f000 c0289195 dfe2334c dfe2334c e080f000 c02881f6 fffffffb 
Call Trace:
 [<c010fab8>] iounmap+0xaa/0xdc
 [<00000004>] 0x4
 =======================
Code: 84 b7 00 00 00 eb d2 ff 43 0c eb 23 84 c0 78 1b 0b 74 24 1c 8b 54 24 10 89 32 8b 43 0c 85 c0 75 04 0f 0b eb fe 48 89 43 0c eb 04 <0f> 0b eb fe 8b 03 f6 c4 04 75 6c f6 05 0c 7c 45 c0 08 74 63 83 
EIP: [<c010fdd7>] change_page_attr+0x167/0x234 SS:ESP 0068:dffc5e7c
 <0>Kernel panic - not syncing: Attempted to kill init!
