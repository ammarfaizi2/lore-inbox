Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261299AbTCGAFo>; Thu, 6 Mar 2003 19:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261303AbTCGAFo>; Thu, 6 Mar 2003 19:05:44 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:50436 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S261299AbTCGAFm>; Thu, 6 Mar 2003 19:05:42 -0500
Date: Fri, 7 Mar 2003 00:12:37 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: E: Loading and executing kernel from a non-standard address usin g SY SLINUX
Message-ID: <20030307001237.A2112@pierrot.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Mar 2003 ravikumar.chakaravarthy@amd.com wrote:
> Yup,
>   Thanks I got that. The physical address is computed using (virtual address) -
> PAGE_OFFSET. So if my decompressed kernel is loaded at the physical address
> 0x200000 (I defined this address), I would need the linker to know it. Actually
> I went past that stage and now I got into start_kernel.. however it seems to be
> hanging somewhere after that.  Is there any other kernel changes I need to make
> to avoid this hanging for a normal boot.
> 

You cannot get the kernel to run from a different physical address by changing
PAGE_OFFSET.  This is not what PAGE_OFFSET is for.  PAGE_OFFSET specifies the
offset of virtual memory from the start of physical memory, which is assumed to
be 0x0.

You should never want to change PAGE_OFFSET.

> Thats why I tried to change
> the PAGE_OFFSET value to 0xc0100000, which should be the right value
> corresponding to (0x200000).

Wrong.

If you really do want the kernel to run at 0x200000 physical, you should
try changing the link address to 0xc0200000.  I'm no expert on the
i386 kernel (I know the PPC kernel), but there's no guarantee that this
will work, if there's any code which assumes the kernel is at 0x100000
physical.

Phillip

> -Ravi
