Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751836AbWHAT1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbWHAT1L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbWHAT1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:27:11 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:38785 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751836AbWHAT1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:27:09 -0400
Date: Tue, 1 Aug 2006 15:26:28 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Linda Wang <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060801192628.GE7054@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 04:58:49AM -0600, Eric W. Biederman wrote:
> 
> The problem:
> 
> We can't always run the kernel at 1MB or 2MB, and so people who need
> different addresses must build multiple kernels.  The bzImage format
> can't even represent loading a kernel at other than it's default address.
> With kexec on panic now starting to be used by distros having a kernel
> not running at the default load address is starting to become common.
> 
> The goal of this patch series is to build kernels that are relocatable
> at run time, and to extend the bzImage format to make it capable of
> expressing a relocatable kernel.
> 
> In extending the bzImage format I am replacing the existing unused bootsector
> with an ELF header.  To express what is going on the ELF header will
> have type ET_DYN.  Just like the kernel loading an ET_DYN executable
> bootloaders are not expected to process relocations.  But the executable
> may be shifted in the address space so long as it's alignment requirements
> are met.
> 
> The x86_64 kernel is simply built to live at a fixed virtual address
> and the boot page tables are relocated.  The i386 kernel is built
> to process relocations generated with --embedded-relocs (after vmlinux.lds.S)
> has been fixed up to sort out static and dynamic relocations.

Hi Eric,

Can't we use the x86_64 relocation approach for i386 as well? I mean keep
the virtual address space fixed and updating the page tables. This would
help in the sense that you don't have to change gdb if somebody decides to
debug the relocated kernel.

Any such tool that retrieves the symbol virtual address from vmlinux will
be confused.

Thanks
Vivek 
