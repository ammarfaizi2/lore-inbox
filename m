Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWIUTZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWIUTZj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 15:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWIUTZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 15:25:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54411 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751481AbWIUTZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 15:25:38 -0400
Date: Thu, 21 Sep 2006 15:24:27 -0400
From: Dave Jones <davej@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Jonathan Woithe <jwoithe@physics.adelaide.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: 2.6.17 oops, possibly ntfs/mmap related
Message-ID: <20060921192427.GD17065@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Jonathan Woithe <jwoithe@physics.adelaide.edu.au>,
	linux-kernel@vger.kernel.org
References: <20060912205602.57568b2a.akpm@osdl.org> <1158832483.5958.7.camel@imp.csi.cam.ac.uk> <1158849696.5958.39.camel@imp.csi.cam.ac.uk> <20060921105236.76e344a2.akpm@osdl.org> <Pine.LNX.4.64.0609211944500.20970@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609211944500.20970@blonde.wat.veritas.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2006 at 08:04:49PM +0100, Hugh Dickins wrote:

 >   BUG: unable to handle kernel paging request at virtual address 0010c744
 >    printing eip:
 >   c013be50
 >   *pde = 00000000
 >   Oops: 0002 [#1]
 >   Modules linked in: ntfs 8139too via_agp agpgart usb_storage ehci_hcd uhci_hcd usbcore
 >   CPU:    0
 >   EIP:    0060:[<c013be50>]    Tainted: G   M  VLI
 >   EFLAGS: 00010282   (2.6.17 #2) 
 >   EIP is at anon_vma_unlink+0x16/0x3c
 >   eax: 0010c740   ebx: cf1070cc   ecx: cf107104   edx: cf8bc740
 >   esi: cf8bc740   edi: b7e82000   ebp: 00000000   esp: cdad7f58
 > 
 > I haven't worked out the disassembly in detail to support the idea
 > (though certainly anon_vma_unlink would be trying to list_del around
 > here), but that eax and esi do suggest a corrupted list: somehow the
 > top half of a pointer overwritten by the top half of LIST_POISON1.
 > 
 > And in Anton's case, the top half of a pointer overwritten by the
 > bottom half of LIST_POISON2.
 > 
 > Maybe just coincidence, and I've nothing more illuminating to add;
 > but just a hint of a list_del going very wrong somewhere?

Given a machine check happened, the state of the machine in general
is questionable.  I'd recommend a run of memtest86+ 

	Dave
