Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUHYJbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUHYJbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 05:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUHYJ3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 05:29:30 -0400
Received: from aun.it.uu.se ([130.238.12.36]:56449 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266114AbUHYJ0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 05:26:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16684.23372.311191.218551@alkaid.it.uu.se>
Date: Wed, 25 Aug 2004 11:26:36 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: Zarakin <zarakin@hotpop.com>, linux-kernel@vger.kernel.org
Subject: Re: nmi_watchdog=2 - Oops with 2.6.8
In-Reply-To: <20040825061248.GB556@zaniah>
References: <021101c48a44$c8f846e0$6401a8c0@novustelecom.net>
	<20040825061248.GB556@zaniah>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Elie writes:
 > > EIP:  0060: [<0xc0110d4b>] Not tainted
 > > EIP is at clear_msr_range+0x18/0x25
 > > eax: 0  ebx:1f  ecx: 3ba  edx: 0
 > > esi: 3a0  edi: 1a  ebp:0 esp: d7d83f74
 > > ds: 7b es: 7b ss: 68
 > > 
 > > Dump of assembler code for function clear_msr_range:
 > > 0xc0110d33 <clear_msr_range+0>: push   %edi
 > > 0xc0110d34 <clear_msr_range+1>: xor    %edi,%edi
 > > 0xc0110d36 <clear_msr_range+3>: push   %esi
 > > 0xc0110d37 <clear_msr_range+4>: push   %ebx
 > > 0xc0110d38 <clear_msr_range+5>: mov    0x14(%esp,1),%ebx
 > > 0xc0110d3c <clear_msr_range+9>: mov    0x10(%esp,1),%esi
 > > 0xc0110d40 <clear_msr_range+13>:        cmp    %ebx,%edi
 > > 0xc0110d42 <clear_msr_range+15>:        jae    0xc0110d54
 > > 0xc0110d44 <clear_msr_range+17>:        xor    %eax,%eax
 > > 0xc0110d46 <clear_msr_range+19>:        lea    (%edi,%esi,1),%ecx
 > > 0xc0110d49 <clear_msr_range+22>:        mov    %eax,%edx
 > > 0xc0110d4b <clear_msr_range+24>:        wrmsr
 > 
 > Intel removed MSR 0x3ba/0x3bb (MSR_IQ_ESCR0 and 1) in prescott processor
 > (family 15 model 3). I'm going to sleep, if nobody beat me I'll try to
 > provide a patch, see nmi.c:setup_p4_watchdog() --> clear_msr_range(0x3A0, 31);

I figured that too. Strangely enough, perfctr has been run
successfully on two CPUID 0xF3x machines, and it didn't hit
this problem. I have no idea why, yet. Maybe they haven't
removed IQ_ESCR{0,1} from the Nocona?

I don't have physical access to either a Prescott or a Nocona,
but it it shouldn't be difficult to test. Just set up IQ_ESCR{0,1}
with a clock-like event and see what happens.

/Mikael
