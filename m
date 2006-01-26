Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWAZBtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWAZBtg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 20:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWAZBte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 20:49:34 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:54226 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751288AbWAZBtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 20:49:31 -0500
Date: Thu, 26 Jan 2006 10:49:34 +0900
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>
Subject: Re: [PATCH 4/6] use include/asm-generic/bitops for each architecture
Message-ID: <20060126014934.GA6648@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com> <20060125113336.GE18584@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125113336.GE18584@miraclelinux.com>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2006 at 08:33:37PM +0900, mita wrote:
> compile test on i386, x86_64, ppc, sparc, sparc64, alpha
> boot test on i386, x86_64, ppc
> 

I have fogotten attaching the changes for each archtecture.

o alpha

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- define HAVE_ARCH_ATOMIC_BITOPS
- define HAVE_ARCH_FFZ_BITOPS
- define HAVE_ARCH___FFS_BITOPS
- define HAVE_ARCH_FFS_BITOPS

- if defined(__alpha_cix__) and defined(__alpha_fix__)
  - define HAVE_ARCH_FLS_BITOPS
  - define HAVE_ARCH_HWEIGHT_BITOPS
  - define HAVE_ARCH_HWEIGHT64_BITOPS
- else
  - remove fls()
  - remove hweight64()
  - remove hweight{32,16,8}()

- remove fls64()
- remove find_{next,first}{,_zero}_bit()
- define HAVE_ARCH_SCHED_BITOPS
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- define HAVE_ARCH_EXT2_ATOMIC_BITOPS
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

o arm

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- define HAVE_ARCH_ATOMIC_BITOPS
- define HAVE_ARCH_FIND_BITOPS

- if __LINUX_ARM_ARCH__ < 5
  - remove ffz()
  - remove __ffs()
  - remove fls()
  - remove ffs()
- else (__LINUX_ARM_ARCH__ >= 5)
  - define HAVE_ARCH_FLS_BITOPS
  - define HAVE_ARCH_FFS_BITOPS
  - define HAVE_ARCH___FFS_BITOPS
  - define HAVE_ARCH_FFZ_BITOPS

- remove fls64()
- remove hweight64()
- remove hweight{32,16,8}()
- remove sched_find_first_bit()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- define HAVE_ARCH_EXT2_ATOMIC_BITOPS
- remove HAVE_ARCH_MINIX_BITOPS

o arm26

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- define HAVE_ARCH_ATOMIC_BITOPS
- define HAVE_ARCH_FIND_BITOPS
- remove ffz()
- remove __ffs()
- remove fls()
- remove fls64()
- remove ffs()
- remove sched_find_first_bit()
- remove hweight{32,16,8}()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- define HAVE_ARCH_EXT2_ATOMIC_BITOPS
- define HAVE_MINIX_BITOPS

o cris

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- define HAVE_ARCH_ATOMIC_BITOPS
- remove fls()
- remove fls64()
- remove hweight{32,16,8}()
- remove find_{next,first}{,_zero}_bit()
- define HAVE_ARCH_FFS_BITOPS
- remove sched_find_first_bit()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- define HAVE_ARCH_EXT2_ATOMIC_BITOPS
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

o frv

- remove ffz()
- define HAVE_ARCH_ATOMIC_BITOPS
- define HAVE_ARCH_NON_ATOMIC_BITOPS
- remove find_{next,first}{,_zero}_bit()
- remove ffs()
- remove __ffs()
- remove fls64()
- remove sched_find_first_bit()
- remove hweight{32,16,8}()
- define HAVE_ARCH_FLS_BITOPS
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- define HAVE_ARCH_EXT2_ATOMIC_BITOPS
- define HAVE_ARCH_MINIX_BITOPS

o h8300

- define HAVE_ARCH_FFZ_BITOPS
- define HAVE_ARCH_ATOMIC_BITOPS
- define HAVE_ARCH_NON_ATOMIC_BITOPS
- remove ffs()
- remove find_{next,first}{,_zero}_bit()
- remove sched_find_first_bit()
- remove hweight{32,16,8}()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove ext2_{set,clear}_bit_atomic()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()
- define HAVE_ARCH___FFS_BITOPS
- remove fls()
- remove fls64()

o i386

- define HAVE_ARCH_ATOMIC_BITOPS
- define HAVE_ARCH_NON_ATOMIC_BITOPS
- define HAVE_ARCH_FIND_BITOPS
- define HAVE_ARCH___FFS_BITOPS
- define HAVE_ARCH_FFZ_BITOPS
- remove fls64()
- remove sched_find_first_bit()
- define HAVE_ARCH_FFS_BITOPS
- remove hweight{32,16,8}()
- define HAVE_ARCH_FLS_BITOPS
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- define HAVE_ARCH_EXT2_ATOMIC_BITOPS
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

o ia64

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- define HAVE_ARCH_ATOMIC_BITOPS
- define HAVE_ARCH_FFZ_BITOPS
- define HAVE_ARCH___FFS_BITOPS
- remove fls64()
- define HAVE_ARCH_FLS_BITOPS
- define HAVE_ARCH_FFS_BITOPS
- define HAVE_ARCH_HWEIGHT_BITOPS
- define HAVE_ARCH_HWEIGHT64_BITOPS
- define HAVE_ARCH_FIND_BITOPS
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- define HAVE_ARCH_EXT2_ATOMIC_BITOPS
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()
- remove sched_find_first_bit()

o m32r

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- remove ffz()
- remove find_{next,first}{,_zero}_bit()
- remove __ffs()
- remove fls()
- remove fls64()
- remove sched_find_first_bit()
- remove ffs()
- remove hweight()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove ext2_{set,clear}_bit_atomic()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()
- define HAVE_ARCH_ATOMIC_BITOPS

o m68k

- define HAVE_ARCH_ATOMIC_BITOPS
- define HAVE_ARCH_NON_ATOMIC_BITOPS
- define HAVE_ARCH_FIND_BITOPS
- define HAVE_ARCH_FFZ_BITOPS
- define HAVE_ARCH_FFS_BITOPS
- define HAVE_ARCH___FFS_BITOPS
- remove fls64()
- remove sched_find_first_bit()
- remove ffs()
- remove hweight()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- define HAVE_ARCH_MINIX_BITOPS
- define HAVE_ARCH_EXT2_ATOMIC_BITOPS

o m68knommu

- remove ffs()
- remove __ffs()
- remove sched_find_first_bit()
- remove ffz()
- remove find_{next,first}{,_zero}_bit()
- remove hweight()
- define HAVE_ARCH_ATOMIC_BITOPS
- define HAVE_ARCH_NON_ATOMIC_BITOPS
- define HAVE_ARCH_EXT2_NON_ATOMIC_BITOPS
- define HAVE_ARCH_EXT2_ATOMIC_BITOPS
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()
- remove fls()
- remove fls64()

o mips

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- define HAVE_ARCH_ATOMIC_BITOPS

- if defined(CONFIG_CPU_MIPS32) or defined(CONFIG_CPU_MIPS64)
  - define HAVE_ARCH___FFS_BITOPS
  - define HAVE_ARCH_FFS_BITOPS
  - define HAVE_ARCH_FFZ_BITOPS
  - define HAVE_ARCH_FLS_BITOPS
- else
  - remove __ffs()
  - remove ffs()
  - remove ffz()
  - remove fls()

- remove fls64()
- remove find_{next,first}{,_zero}_bit()
- remove sched_find_first_bit()
- remove hweight()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove ext2_{set,clear}_bit_atomic()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

o s390

- define HAVE_ARCH_ATOMIC_BITOPS
- define HAVE_ARCH_NON_ATOMIC_BITOPS
- define HAVE_ARCH_FFZ_BITOPS
- define HAVE_ARCH___FFS_BITOPS
- define HAVE_ARCH_FIND_BITOPS
- remove ffs()
- remove fls()
- remove fls64()
- remove hweight()
- remove hweight64()
- define HAVE_ARCH_SCHED_BITOPS
- define HAVE_ARCH_EXT2_NON_ATOMIC_BITOPS
- define HAVE_ARCH_EXT2_ATOMIC_BITOPS
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

o sh

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- define HAVE_ARCH_ATOMIC_BITOPS
- define HAVE_ARCH_FFZ_BITOPS
- define HAVE_ARCH___FFS_BITOPS
- remove find_{next,first}{,_zero}_bit()
- remove ffs()
- remove hweight()
- remove sched_find_first_bit()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove ext2_{set,clear}_bit_atomic()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()
- remove fls()
- remove fls64()

o sh64

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- define HAVE_ARCH_ATOMIC_BITOPS
- define HAVE_ARCH_FFZ_BITOPS
- remove __ffs()
- remove find_{next,first}{,_zero}_bit()
- remove hweight()
- remove sched_find_first_bit()
- remove ffs()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove ext2_{set,clear}_bit_atomic()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()
- remove fls()
- remove fls64()

o sparc

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- define HAVE_ARCH_ATOMIC_BITOPS
- remove ffz()
- remove __ffs()
- remove sched_find_first_bit()
- remove ffs()
- remove fls()
- remove fls64()
- remove hweight{32,16,8}()
- remove find_{next,first}{,_zero}_bit()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- remove ext2_{set,clear}_bit_atomic()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

o sparc64

- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- define HAVE_ARCH_ATOMIC_BITOPS
- remove ffz()
- remove __ffs()
- remove fls()
- remove fls64()
- remove sched_find_first_bit()
- remove ffs()

- if defined(ULTRA_HAS_POPULATION_COUNT)
  - define HAVE_ARCH_HWEIGHT64_BITOPS
  - define HAVE_ARCH_HWEIGHT_BITOPS
- else
  - remove hweight64()
  - remove hweight{32,16,8}()

- define HAVE_ARCH_FIND_BITOPS
- define HAVE_ARCH_EXT2_ATOMIC_BITOPS
- define HAVE_ARCH_EXT2_NON_ATOMIC_BITOPS
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

o v850

- remove ffz()
- define HAVE_ARCH_ATOMIC_BITOPS
- define HAVE_ARCH_NON_ATOMIC_BITOPS
- remove find_{next,first}{,_zero}_bit()
- remove ffs()
- remove fls()
- remove fls64()
- remove __ffs()
- remove sched_find_first_bit()
- remove hweight{32,16,8}()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- define HAVE_ARCH_EXT2_ATOMIC_BITOPS
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

o x86_64

- define HAVE_ARCH_ATOMIC_BITOPS
- define HAVE_ARCH_NON_ATOMIC_BITOPS
- define HAVE_ARCH_FIND_BITOPS
- define HAVE_ARCH_FFZ_BITOPS
- define HAVE_ARCH___FFS_BITOPS
- define HAVE_ARCH_FLS_BITOPS
- remove sched_find_first_bit()
- define HAVE_ARCH_FFS_BITOPS
- define HAVE_ARCH_FLS64_BITOPS
- remove hweight{32,16,8}()
- define HAVE_ARCH_FLS_BITOPS
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- define HAVE_ARCH_EXT2_ATOMIC_BITOPS
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

o xtensa

- remove {,test_and_}{set,clear,change}_bit()
- remove __{,test_and_}{set,clear,change}_bit() and test_bit()
- define HAVE_ARCH_FFZ_BITOPS
- define HAVE_ARCH___FFS_BITOPS
- define HAVE_ARCH_FFS_BITOPS
- define HAVE_ARCH_FLS_BITOPS
- remove fls64()
- remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
- define HAVE_ARCH_EXT2_ATOMIC_BITOPS
- remove hweight{32,16,8}()
- remove sched_find_first_bit()
- remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()

o remove unused generic bitops

