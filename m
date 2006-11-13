Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755227AbWKMRXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227AbWKMRXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755226AbWKMRXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:23:00 -0500
Received: from cantor2.suse.de ([195.135.220.15]:43486 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1755227AbWKMRW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:22:59 -0500
From: Andi Kleen <ak@suse.de>
To: vgoyal@in.ibm.com
Subject: Re: [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
Date: Mon, 13 Nov 2006 18:22:43 +0100
User-Agent: KMail/1.9.5
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, "Rafael J. Wysocki" <rjw@sisk.pl>
References: <20061113162135.GA17429@in.ibm.com> <20061113164314.GK17429@in.ibm.com>
In-Reply-To: <20061113164314.GK17429@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611131822.44034.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 November 2006 17:43, Vivek Goyal wrote:
> 
> - Killed lots of dead code
> - Improve the cpu sanity checks to verify long mode
>   is enabled when we wake up.
> - Removed the need for modifying any existing kernel page table.
> - Moved wakeup_level4_pgt into the wakeup routine so we can
>   run the kernel above 4G.
> - Increased the size of the wakeup routine to 8K.
> - Renamed the variables to use the 64bit register names.
> - Lots of misc cleanups to match trampoline.S
> 
> I don't have a configuration I can test this but it compiles cleanly
> and it should work, the code is very similar to the SMP trampoline,
> which I have tested.  At least now the comments about still running in
> low memory are actually correct.
> 
> Vivek has tested this patch for suspend to memory and it works fine.

Suspend is unfortunately quite fragile.

pavel, rafael can you please test and review this patch? 

(full patch is on l-k)

> +verify_cpu:
> +	pushl	$0			# Kill any dangerous flags
> +	popfl
> +
> +	/* minimum CPUID flags for x86-64 */
> +	/* see http://www.x86-64.org/lists/discuss/msg02971.html */
> +#define REQUIRED_MASK1 ((1<<0)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<8)|\
> +			   (1<<13)|(1<<15)|(1<<24)|(1<<25)|(1<<26))
> +#define REQUIRED_MASK2 (1<<29)

It would be much better if this least this CPUID code was in a common shared 
file with head.S

-Andi

