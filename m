Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWJDQOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWJDQOu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWJDQOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:14:50 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:16101 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964789AbWJDQOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:14:49 -0400
Date: Wed, 4 Oct 2006 12:14:17 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "H. J. Lu" <hjl@lucon.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       ak@suse.de, horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 3/12] i386: Force section size to be non-zero to prevent a symbol becoming absolute
Message-ID: <20061004161417.GD16218@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com> <20061003170908.GC3164@in.ibm.com> <20061004090946.5ab000e5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004090946.5ab000e5.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 09:09:46AM -0700, Andrew Morton wrote:
> On Tue, 3 Oct 2006 13:09:08 -0400
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> 
> > o Relocation patches for i386, moved the symbols in vmlinux.lds.S inside
> >   sections so that these symbols become section relative and are no more
> >   absolute. If these symbols become absolute, its bad as they are not
> >   relocated if kernel is not loaded at the address it has been compiled
> >   for.
> > 
> > o Ironically, just moving the symbols inside the section does not 
> >   gurantee that symbols inside will not become absolute. Recent 
> >   versions of linkers, do some optimization, and if section size is
> >   zero, it gets rid of the section and makes any defined symbol as absolute.
> > 
> > o This leads to a failure while second kernel is booting.
> >   arch/i386/alternative.c frees any pages present between __smp_alt_begin
> >   and __smp_alt_end. In my case size of section .smp_altinstructions is 
> >   zero and symbol __smpt_alt_begin becomes absolute and is not relocated
> >   and system crashes while it is trying to free the memory starting
> >   from __smp_alt_begin.
> > 
> > o This issue is being fixed by the linker guys and they are making sure
> >   that linker does not get rid of an empty section if there is any
> >   section relative symbol defined in it. But we need to fix it at
> >   kernel level too so that people using the linker version without fix,
> >   are not affected.
> > 
> > o One of the possible solutions is that force the section size to be
> >   non zero to make sure these symbols don't become absolute. This 
> >   patch implements that.
> 
> Would it be reasonable to omit this patch and require that the small number
> of people who want to build relocatable kernels install binutils
> 2.17.50.0.5 or later?

I think that's a reasonable thing to do for now.

Thanks
Vivek
