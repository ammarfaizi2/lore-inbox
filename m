Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263666AbTCURHa>; Fri, 21 Mar 2003 12:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263668AbTCURHa>; Fri, 21 Mar 2003 12:07:30 -0500
Received: from franka.aracnet.com ([216.99.193.44]:33942 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263666AbTCURHZ>; Fri, 21 Mar 2003 12:07:25 -0500
Date: Fri, 21 Mar 2003 09:18:24 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 483] New: Debug: sleeping function called from illegal context at include/linux/rwsem.h:43
Message-ID: <336020000.1048267104@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=483

           Summary: Debug: sleeping function called from illegal context at
                    include/linux/rwsem.h:43
    Kernel Version: 2.5.65
            Status: NEW
          Severity: normal
             Owner: davem@vger.kernel.org
         Submitter: jochen@jochen.org


Distribution: Debian Sarge
Hardware Environment: IBM Thinkpad 600

Problem Description:

When booting I get:

Debug: sleeping function called from illegal context at include/linux/rwsem.h:43
Call Trace:
 [<c0116628>] __might_sleep+0x54/0x5c
 [<c01cac71>] crypto_alg_lookup+0x21/0xc8
 [<c01cbb3d>] crypto_alg_mod_lookup+0xd/0x30
 [<c01cae2d>] crypto_alloc_tfm+0x11/0xc0
 [<c02c40d0>] __ipv6_regen_rndid+0xa0/0x1f4
 [<c0114ca1>] wake_up_process+0xd/0x14
 [<c02c4252>] ipv6_regen_rndid+0x2e/0xc4
 [<c011f099>] run_timer_softirq+0xf1/0x144
 [<c02c4224>] ipv6_regen_rndid+0x0/0xc4
 [<c011b8f1>] do_softirq+0x51/0xb0
 [<c010a300>] do_IRQ+0x114/0x130
 [<c0106f54>] default_idle+0x0/0x34
 [<c0106f54>] default_idle+0x0/0x34
 [<c0108ea8>] common_interrupt+0x18/0x20
 [<c0106f54>] default_idle+0x0/0x34
 [<c0106f54>] default_idle+0x0/0x34
 [<c0106f7a>] default_idle+0x26/0x34
 [<c0107009>] cpu_idle+0x35/0x44
 [<c0105000>] rest_init+0x0/0x5c
 [<c0105055>] rest_init+0x55/0x5c

__ipv6_regen_rndid(): too short regeneration interval; timer diabled for eth0.

Steps to reproduce:

The kernel is compiled with
root@gswi1164:/usr/src/linux-2.5.65# grep CRYPT .config
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_TEST=m
root@gswi1164:/usr/src/linux-2.5.65# grep IPV6 .config
CONFIG_IPV6=y
CONFIG_IPV6_PRIVACY=y


