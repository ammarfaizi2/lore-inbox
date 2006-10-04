Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161538AbWJDQK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161538AbWJDQK1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161539AbWJDQK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:10:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64907 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161538AbWJDQK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:10:26 -0400
Date: Wed, 4 Oct 2006 09:09:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com, "H. J. Lu" <hjl@lucon.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       ak@suse.de, horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 3/12] i386: Force section size to be non-zero to prevent
 a symbol becoming absolute
Message-Id: <20061004090946.5ab000e5.akpm@osdl.org>
In-Reply-To: <20061003170908.GC3164@in.ibm.com>
References: <20061003170032.GA30036@in.ibm.com>
	<20061003170908.GC3164@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2006 13:09:08 -0400
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> o Relocation patches for i386, moved the symbols in vmlinux.lds.S inside
>   sections so that these symbols become section relative and are no more
>   absolute. If these symbols become absolute, its bad as they are not
>   relocated if kernel is not loaded at the address it has been compiled
>   for.
> 
> o Ironically, just moving the symbols inside the section does not 
>   gurantee that symbols inside will not become absolute. Recent 
>   versions of linkers, do some optimization, and if section size is
>   zero, it gets rid of the section and makes any defined symbol as absolute.
> 
> o This leads to a failure while second kernel is booting.
>   arch/i386/alternative.c frees any pages present between __smp_alt_begin
>   and __smp_alt_end. In my case size of section .smp_altinstructions is 
>   zero and symbol __smpt_alt_begin becomes absolute and is not relocated
>   and system crashes while it is trying to free the memory starting
>   from __smp_alt_begin.
> 
> o This issue is being fixed by the linker guys and they are making sure
>   that linker does not get rid of an empty section if there is any
>   section relative symbol defined in it. But we need to fix it at
>   kernel level too so that people using the linker version without fix,
>   are not affected.
> 
> o One of the possible solutions is that force the section size to be
>   non zero to make sure these symbols don't become absolute. This 
>   patch implements that.

Would it be reasonable to omit this patch and require that the small number
of people who want to build relocatable kernels install binutils
2.17.50.0.5 or later?
