Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWDGEr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWDGEr2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 00:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWDGEr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 00:47:28 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:29899 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932256AbWDGEr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 00:47:27 -0400
Date: Fri, 7 Apr 2006 13:48:27 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, jbarnes@sgi.com, jes@trained-monkey.org,
       nickpiggin@yahoo.com.au, tony.luck@intel.com,
       mm-commits@vger.kernel.org
Subject: Re: + pg_uncached-is-ia64-only.patch added to -mm tree
Message-Id: <20060407134827.91a47e69.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <200604070421.k374LXFs011197@shell0.pdx.osdl.net>
References: <200604070421.k374LXFs011197@shell0.pdx.osdl.net>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew

On Thu, 06 Apr 2006 21:20:26 -0700
akpm@osdl.org wrote:

> 
> The patch titled
> 
>      PG_uncached is ia64 only
> 
> has been added to the -mm tree.  Its filename is
> 
>      pg_uncached-is-ia64-only.patch
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 

in include/linux/mmzone.h
==
#elif BITS_PER_LONG == 64
/*
 * with 64 bit flags field, there's plenty of room.
 */
#define FLAGS_RESERVED          32

#else
==

it looks this is used here.

#if SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > FLAGS_RESERVED
#error SECTIONS_WIDTH+NODES_WIDTH+ZONES_WIDTH > FLAGS_RESERVED
#endif

I'm not sure but please compile check FLAGS_RESRVED with SPARSEMEM or

just 

#if (BITS_PER_LONG > 32)               /* 64-bit only flags. we can use full 
                                          low 32bits */
#define PG_uncached	31
#endif

Hm..Is this  ugly ? :(

-Kame


> 
> From: Andrew Morton <akpm@osdl.org>
> 
> As Nick points out, only ia64 uses PG_uncached.  So we can push it up into the
> higher 32-bits of page->flgs and make room for another flag on 32-bit
> machines.
> 
> Cc: "Luck, Tony" <tony.luck@intel.com>
> Cc: Jesse Barnes <jbarnes@sgi.com>
> Cc: Jes Sorensen <jes@trained-monkey.org>
> Cc: Nick Piggin <nickpiggin@yahoo.com.au>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  include/linux/page-flags.h |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff -puN include/linux/page-flags.h~pg_uncached-is-ia64-only include/linux/page-flags.h
> --- devel/include/linux/page-flags.h~pg_uncached-is-ia64-only	2006-04-06 21:17:16.000000000 -0700
> +++ devel-akpm/include/linux/page-flags.h	2006-04-06 21:18:31.000000000 -0700
> @@ -7,6 +7,8 @@
>  
>  #include <linux/percpu.h>
>  #include <linux/cache.h>
> +
> +#include <asm/types.h>
>  #include <asm/pgtable.h>
>  
>  /*
> @@ -86,7 +88,10 @@
>  #define PG_mappedtodisk		16	/* Has blocks allocated on-disk */
>  #define PG_reclaim		17	/* To be reclaimed asap */
>  #define PG_nosave_free		18	/* Free, should not be written */
> -#define PG_uncached		19	/* Page has been mapped as uncached */
> +
> +#if (BITS_PER_LONG > 32)
> +#define PG_uncached		32	/* Page has been mapped as uncached */
> +#endif
>  
>  /*
>   * Global page accounting.  One instance per CPU.  Only unsigned longs are
> _
> 
> Patches currently in -mm which might be from akpm@osdl.org are
> 
> select-warning-fixes.patch
> config_net=n-build-fix.patch
> git-acpi.patch
> acpi-update-asus_acpi-driver-registration-fix.patch
> acpi-memory-hotplug-cannot-manage-_crs-with-plural-resoureces.patch
> catch-notification-of-memory-add-event-of-acpi-via-container-driver-register-start-func-for-memory-device.patch
> catch-notification-of-memory-add-event-of-acpi-via-container-driveravoid-redundant-call-add_memory.patch
> sony_apci-resume.patch
> powernow-k8-crash-workaround.patch
> git-drm.patch
> bt866-build-fix.patch
> connector-exports.patch
> git-ia64.patch
> git-libata-all.patch
> pci-error-recovery-e1000-network-device-driver.patch
> pcmcia-remove-unneeded-forward-declarations.patch
> git-scsi-misc.patch
> megaraid-unused-variable.patch
> git-sas-jg.patch
> git-sas-jg-build-hack.patch
> git-watchdog.patch
> arm-add_memory-build-fix.patch
> acx1xx-wireless-driver.patch
> ext3-ext3-in-kernel-block-number-type-fixes-fix.patch
> sync_file_range-use-unsigned-for-flags.patch
> timer-initialisation-fix.patch
> timer-initialisation-fix-tidy.patch
> s3c24xx-gpio-led-support-tidy.patch
> make-tty_insert_flip_string_flags-a-non-gpl-export.patch
> prune_one_dentry-tweaks.patch
> sys_kexec_load-naming-fixups.patch
> hangcheck-remove-monotomic_clock-on-x86.patch
> knfsd-nfsd4-limit-number-of-delegations-handed-out-fix.patch
> pi-futex-futex-code-cleanups-fix.patch
> reiser4.patch
> kgdb-core-lite-add-reboot-command.patch
> kgdb-8250-fix.patch
> nr_blockdev_pages-in_interrupt-warning.patch
> device-suspend-debug.patch
> revert-tty-buffering-comment-out-debug-code.patch
> slab-leaks3-default-y.patch
> x86-kmap_atomic-debugging.patch
> pg_uncached-is-ia64-only.patch
> 
> -
> To unsubscribe from this list: send the line "unsubscribe mm-commits" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
