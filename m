Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423715AbWKFKDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423715AbWKFKDs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 05:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423734AbWKFKDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 05:03:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34000 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423715AbWKFKDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 05:03:47 -0500
Subject: Re: [PATCH 1/14] KVM: userspace interface
From: Arjan van de Ven <arjan@infradead.org>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <20061105202934.B5F842500A7@cleopatra.q>
References: <454E4941.7000108@qumranet.com>
	 <20061105202934.B5F842500A7@cleopatra.q>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 06 Nov 2006 11:03:40 +0100
Message-Id: <1162807420.3160.186.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

some nitpicks about the ioctl interfaces while it still can be done ;)


> Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
> Signed-off-by: Avi Kivity <avi@qumranet.com>
> 
> --- /dev/null	2006-10-25 17:42:42.376631750 +0200
> +++ linux-2.6/include/linux/kvm.h	2006-10-26 15:22:01.000000000 +0200
> @@ -0,0 +1,198 @@
> +#ifndef __LINUX_KVM_H
> +#define __LINUX_KVM_H
> +
> +/*
> + * Userspace interface for /dev/kvm - kernel based virtual machine
> + *
> + * Note: this interface is considered experimental and may change without
> + *       notice.
> + */
> +
> +#include <asm/types.h>
> +#include <linux/ioctl.h>
> +
> +/* for KVM_CREATE_MEMORY_REGION */
> +struct kvm_memory_region {
> +	__u32 slot;
> +	__u32 flags;
> +	__u64 guest_phys_addr;
> +	__u64 memory_size; /* bytes */
> +};

as a general rule, it's a lot better to sort structures big-to-small, to
make sure alignments inside the struct are minimized and don't suck too
much. This is especially important to get right for 32/64 bit
compatibility. This comment is true for most structures in this header
file; please consider this at least

> +
> +enum kvm_exit_reason {
> +	KVM_EXIT_UNKNOWN,
> +	KVM_EXIT_EXCEPTION,
> +	KVM_EXIT_IO,
> +	KVM_EXIT_CPUID,
> +	KVM_EXIT_DEBUG,
> +	KVM_EXIT_HLT,
> +	KVM_EXIT_MMIO,
> +};

it's probably nicer to use explicit enum values for the interface, just
as documentation if nothing else

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

