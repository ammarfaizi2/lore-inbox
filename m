Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030542AbWAGTFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030542AbWAGTFn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030544AbWAGTFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:05:43 -0500
Received: from spooner.celestial.com ([192.136.111.35]:28304 "EHLO
	spooner.celestial.com") by vger.kernel.org with ESMTP
	id S1030542AbWAGTFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:05:42 -0500
Date: Sat, 7 Jan 2006 14:05:31 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: [patch 7/7] Make "inline" no longer mandatory for gcc 4.x
Message-ID: <20060107190531.GB8990@kurtwerks.com>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <1136543825.2940.8.camel@laptopd505.fenrus.org> <1136544309.2940.25.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136544309.2940.25.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.15krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 11:45:09AM +0100, Arjan van de Ven took 0 lines to write:
> Subject: when CONFIG_CC_OPTIMIZE_FOR_SIZE, allow gcc4 to control inlining
> From: Ingo Molnar <mingo@elte.hu>
> 
> if optimizing for size (CONFIG_CC_OPTIMIZE_FOR_SIZE), allow gcc4 compilers
> to decide what to inline and what not - instead of the kernel forcing gcc
> to inline all the time. This requires several places that require to be 
> inlined to be marked as such, previous patches in this series do that.
> This is probably the most flame-worthy patch of the series.

Hmm. This failed when using -Os while linking vmlinux (gcc 4.0.2):

  AS      arch/x86_64/lib/putuser.o
  CC      arch/x86_64/lib/usercopy.o
  AR      arch/x86_64/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/x86_64/kernel/built-in.o(.text+0x506a): In function `fix_to_virt':
: undefined reference to `__this_fixmap_does_not_exist'
arch/x86_64/kernel/built-in.o(.text+0xbffd): In function `fix_to_virt':
: undefined reference to `__this_fixmap_does_not_exist'
arch/x86_64/kernel/built-in.o(.text+0xdba0): In function `fix_to_virt':
: undefined reference to `__this_fixmap_does_not_exist'
arch/x86_64/kernel/built-in.o(.text+0xdc1c): In function `fix_to_virt':
: undefined reference to `__this_fixmap_does_not_exist'
arch/x86_64/kernel/built-in.o(.text+0xdde8): In function `fix_to_virt':
: undefined reference to `__this_fixmap_does_not_exist'
make: *** [.tmp_vmlinux1] Error 1

This patch was applied on top of the previous 6 in the series from
Arjan. NB that it _did_ build with 3.4.4 and -Os enabled. I'm
rechecking, but this is the second time I've encountered this failure.

Kurt
-- 
Sauron is alive in Argentina!
