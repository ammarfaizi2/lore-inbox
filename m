Return-Path: <linux-kernel-owner+w=401wt.eu-S1752415AbXACFxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbXACFxR (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 00:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbXACFxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 00:53:17 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:56352 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbXACFxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 00:53:16 -0500
Date: Wed, 3 Jan 2007 11:23:12 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Thomas Meyer <thomas@m3y3r.de>
Cc: linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>
Subject: Re: WARNING: Absolute relocations present
Message-ID: <20070103055312.GA25433@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <458BECA8.2080807@m3y3r.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458BECA8.2080807@m3y3r.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2006 at 03:33:12PM +0100, Thomas Meyer wrote:
> More warnings on current git head:
> 
>  OBJCOPY arch/i386/boot/compressed/vmlinux.bin
>  RELOCS  arch/i386/boot/compressed/vmlinux.relocs
> WARNING: Absolute relocations present
> Offset     Info     Type     Sym.Value Sym.Name
> c0107bd7 00636601   R_386_32 c034f000  __smp_alt_instructions
> c0107bff 00622301   R_386_32 c034f000  __smp_alt_instructions_end
> c0107c68 00622301   R_386_32 c034f000  __smp_alt_instructions_end
> c0107c6d 00636601   R_386_32 c034f000  __smp_alt_instructions
> c01365aa 004aba01   R_386_32 c030ef3c  __stop___ksymtab_gpl_future
> c01365af 0053a101   R_386_32 c030ef3c  __start___ksymtab_gpl_future
> c01365e6 0053a101   R_386_32 c030ef3c  __start___ksymtab_gpl_future
> c01365ed 004aad01   R_386_32 c0311d38  __start___kcrctab_gpl_future
> c01365f4 00486d01   R_386_32 c030ef3c  __stop___ksymtab_unused
> c01365f9 004b6601   R_386_32 c030ef3c  __start___ksymtab_unused
> c0136614 004b6601   R_386_32 c030ef3c  __start___ksymtab_unused
> c013661b 004c4d01   R_386_32 c0311d38  __start___kcrctab_unused
> and so on...
> 
> Should i ignore these warnings, too?
> 

Hi Thomas,

What's your ld version. I don't remember but some particular versions
of ld will have this problem. These ld versions do some optimizations
and if a section size is zero then linker gets rid of that section and
any symbol defined w.r.t removed section, ld makes that symbol absolute
instead of section relative. That's why you see above warnings. 

I had raised this issue on binutils mailing list and they fixed it.

http://sourceware.org/ml/binutils/2006-09/msg00305.html

I am using following ld version and it works fine for me.

GNU ld version 2.17.50.0.6-2.el5 20061020
 
So you will have to move to the latest ld version and problem should be
resolved.

> I have to ignore a lot of warnings on the current linux tree...
> 

These warnings will not impact booting of your kernel as long as you
are running the kernel from its compiled address. It will run into
issues only if this kernel is loaded and run from an arbitrary address.

I think as of today, only kexec bootloader has been modified to load
the bzImage at some other arbitratary address. Grub and lilo will still
load it at 1MB so it should work fine.

Thanks
Vivek
