Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWJDUtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWJDUtR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWJDUtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:49:17 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:44930 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751099AbWJDUtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:49:16 -0400
Date: Wed, 4 Oct 2006 16:48:29 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
Message-ID: <20061004204829.GB3629@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061003170032.GA30036@in.ibm.com> <20061003172511.GL3164@in.ibm.com> <20061003201340.afa7bfce.akpm@osdl.org> <20061004042850.GA27149@in.ibm.com> <45233B58.1050208@zytor.com> <20061004202244.GA3629@in.ibm.com> <45241945.2020105@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45241945.2020105@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 01:27:49PM -0700, H. Peter Anvin wrote:
> Vivek Goyal wrote:
> >
> >Eric/Peter,
> >
> >How about just extending bzImage format to include some info in real mode
> >kernel header. Say protocol version 2.05. I think if we just include two
> >more fields, is kernel relocatable and equivalent of ELF memsz, then 
> >probably
> >this information should be enough for kexec bzImage loader to load and run
> >a relocatable kernel from a different address.
> >
> 
> What would be the exact semantics of the "equivalent of ELF memsz"?  I 
> have balked on that one in the past, because the proposed semantics were 
> unsafe.
> 

memsz will contain the memory required to load the kernel image. And
probably should also include the memory used by kernel in initial boot
up code which is unaccounted and unbounded.

> I suspect we need at least one more piece of data, which is the required 
> alignment of a relocated kernel.

Now with the introduction of config option CONFIG_PHYSICAL_ALIGN, it
should be easy to get.

>  Either which way, it seems clear that 
> there is some re-engineering that needs to be done, and I think we need 
> to better understand *why* the proposed patch failed.
> 
> Can this failure be reproduced in a simulator?

I will try to reproduce in a simulator. May be qemu? Any suggestions?

Thanks
Vivek
