Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270882AbUJVOhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270882AbUJVOhf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270097AbUJVOhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:37:35 -0400
Received: from holomorphy.com ([207.189.100.168]:27331 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S270882AbUJVOhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:37:18 -0400
Date: Fri, 22 Oct 2004 07:37:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make drivers/char/mem.c use remap_pfn_range()
Message-ID: <20041022143714.GT17038@holomorphy.com>
References: <200410220206.i9M26gUi016689@hera.kernel.org> <20041022021908.GI17038@holomorphy.com> <Pine.LNX.4.58.0410220720220.2101@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410220720220.2101@ppc970.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004, William Lee Irwin III wrote:
>> Odd. I doublechecked the patches I submitted and they actually
>> covered this.

On Fri, Oct 22, 2004 at 07:24:34AM -0700, Linus Torvalds wrote:
> Andrew had a broken patch that shifted the wrong argument by PAGE_SHIFT,
> do you want to take the blame for that one (it shifted the size, not the
> pfn)?


What I posted shifted the correct argument, though vma->vm_pgoff would
have been been better, as it shifted offset right by PAGE_SHIFT, where
offset could have overflowed. I have no idea what you're referring to
about shifting the wrong argument.

This hunk appeared verbatim in my posted patch,
	Message-ID: <20040925075102.GG9106@holomorphy.com>:


Index: mm3-2.6.9-rc2/drivers/char/mem.c
===================================================================
--- mm3-2.6.9-rc2.orig/drivers/char/mem.c	2004-09-25 00:21:50.622348424 -0700
+++ mm3-2.6.9-rc2/drivers/char/mem.c	2004-09-25 00:21:57.538297040 -0700
@@ -227,7 +227,7 @@
 	 */
 	vma->vm_flags |= VM_RESERVED|VM_IO;
 
-	if (remap_page_range(vma, vma->vm_start, offset,
+	if (remap_pfn_range(vma, vma->vm_start, offset >> PAGE_SHIFT,
 			vma->vm_end-vma->vm_start, vma->vm_page_prot))
 		return -EAGAIN;
 	return 0;
