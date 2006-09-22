Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWIVHAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWIVHAA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 03:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWIVHAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 03:00:00 -0400
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:8667 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id S1750804AbWIVG77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 02:59:59 -0400
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200609220717.k8M7H0Ir021258@auster.physics.adelaide.edu.au>
Subject: Re: Fw: 2.6.17 oops, possibly ntfs/mmap related
To: davej@redhat.com (Dave Jones)
Date: Fri, 22 Sep 2006 16:47:00 +0930 (CST)
Cc: hugh@veritas.com (Hugh Dickins), akpm@osdl.org (Andrew Morton),
       aia21@cam.ac.uk (Anton Altaparmakov),
       jwoithe@physics.adelaide.edu.au (Jonathan Woithe),
       linux-kernel@vger.kernel.org
In-Reply-To: <20060921192427.GD17065@redhat.com> from "Dave Jones" at Sep 21, 2006 03:24:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Sep 21, 2006 at 08:04:49PM +0100, Hugh Dickins wrote:
> 
>  >   BUG: unable to handle kernel paging request at virtual address 0010c744
>  >    printing eip:
>  >   c013be50
>  >   *pde = 00000000
>  >   Oops: 0002 [#1]
>  >   Modules linked in: ntfs 8139too via_agp agpgart usb_storage ehci_hcd uhci_hcd usbcore
>  >   CPU:    0
>  >   EIP:    0060:[<c013be50>]    Tainted: G   M  VLI
>  >   EFLAGS: 00010282   (2.6.17 #2) 
>  >   EIP is at anon_vma_unlink+0x16/0x3c
>  >   eax: 0010c740   ebx: cf1070cc   ecx: cf107104   edx: cf8bc740
>  >   esi: cf8bc740   edi: b7e82000   ebp: 00000000   esp: cdad7f58
>  > 
>  > I haven't worked out the disassembly in detail to support the idea
>  > (though certainly anon_vma_unlink would be trying to list_del around
>  > here), but that eax and esi do suggest a corrupted list: somehow the
>  > top half of a pointer overwritten by the top half of LIST_POISON1.
>  > 
>  > And in Anton's case, the top half of a pointer overwritten by the
>  > bottom half of LIST_POISON2.
>  > 
>  > Maybe just coincidence, and I've nothing more illuminating to add;
>  > but just a hint of a list_del going very wrong somewhere?
> 
> Given a machine check happened, the state of the machine in general
> is questionable.  I'd recommend a run of memtest86+ 

That was already done.  No memory errors were reported over 10 passes.

Secondly, the machine check indication was only present on one of the two
oopses we saw.  Furthermore, there was no indication in any log files
that a machine check had occurred in the case of the second oops.
Then again, perhaps machine checks don't get logged which would make this
observation irrelevant.

Could we be looking at a dying CPU?

Regards
  jonathan
