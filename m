Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275317AbTHMSfE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275319AbTHMSfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:35:04 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:20217 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S275317AbTHMSe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 14:34:58 -0400
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030813163927.GE2184@redhat.com>
References: <20030813025542.32429718.akpm@osdl.org.suse.lists.linux.kernel>
	 <1060772769.8009.4.camel@localhost.localdomain.suse.lists.linux.kernel>
	 <20030813042544.5064b3f4.akpm@osdl.org.suse.lists.linux.kernel>
	 <1060774803.8008.24.camel@localhost.localdomain.suse.lists.linux.kernel>
	 <p7365l17o70.fsf@oldwotan.suse.de>
	 <1060778924.8008.39.camel@localhost.localdomain>
	 <20030813131457.GD32290@wotan.suse.de>
	 <1060783794.8008.62.camel@dhcp23.swansea.linux.org.uk>
	 <20030813142055.GC9179@wotan.suse.de>
	 <1060788009.8957.5.camel@dhcp23.swansea.linux.org.uk>
	 <20030813163927.GE2184@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060799674.9129.21.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 13 Aug 2003 19:34:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-13 at 17:39, Dave Jones wrote:
>  > several instructions later added (including prefetch). The later Cyrix
>  > also has a couple of the additional ones but not prefetch.

Ok I got this crossed - the Cyrix/AMD thing was the extended MMX stuff,
they both did 3Dnow! but the Jalapeno old style Cyrix CPU with 3dnow was
canned. Ok so there is a different reason why my Cyrix crashes on boot
with 2.6test. Andi is right that 3Dnow safely implies prefetch. My docs
list it as part of extended MMX not 3dnow although the Cyrix seems to
not posess the instruction anyway.

So 3dnow == prefetch/prefetchw is ok but not useful on K6.

> Which Cyrixen are you talking about ?
> C3's up to and including Ezra-T should DTRT when it comes to
> 3dnow prefetch instruction, and pre-VIA Cyrixen didn't have 3dnow
> at all iirc.

pre VIA Cyrixen have MMX and CXMMX. The CPU also set bit 31 but doesn't
have 3dnow (which fooled me but the kernel does know about). C3's seem
to have prefetch/prefetchw (but not prefetchnta). I don't have a nemeiah
but I assume Nemeiah has prefetchnta too ?


I've tried building a summary list. Additional contributions welcomed

MMX:  Pentium (later only), Cyrix MediaGX (later only), Cyrix 6x86/MII
      Intel PII/PIII/PIV, AMD K6/Athlon/Opteron, VIA Cyrix III, VIA C3
CXMMX: Extended MMX - Cyrix MII/AMD K6(II+ ?)/K7/Opteron
3DNOW: AMD K6-II/III(not original K6),K7/,Opteron, VIA Cyrix III, 
VIA C3 (pre Nemiah only ??)
"Enhanced" 3DNow: Athlon Tbird
SSE: Intel PII, PIII, Athlon (XP, Duron >=1Gz only)
SSE2: Pentium IV
 
So the prefetch fallback is needed for pre Nemiah C3, Duron < 1Ghz and
pre T-Bird Athlon if my table is right.


