Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbTCGPfy>; Fri, 7 Mar 2003 10:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261647AbTCGPfy>; Fri, 7 Mar 2003 10:35:54 -0500
Received: from amdext2.amd.com ([163.181.251.1]:15014 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id <S261644AbTCGPfw>;
	Fri, 7 Mar 2003 10:35:52 -0500
From: ravikumar.chakaravarthy@amd.com
X-Server-Uuid: BB5E7757-34FD-4146-B9CC-0950D472AE87
Message-ID: <99F2150714F93F448942F9A9F112634CA54B11@txexmtae.amd.com>
To: phillip@lougher.demon.co.uk, linux-kernel@vger.kernel.org
Subject: RE: Loading and executing kernel from a non-standard address
 usin g SY SLINUX
Date: Fri, 7 Mar 2003 09:46:11 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 1276614F2466009-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes,
  You are right. I had to change the linker file vmlinux.lds, to change the link address to 0xc0200000 and not change PAGE_OFFSET. However as you said there seems to be other problems. My virtual to physical map seems to work fine. However when the kernel is executed, in the start_kernel in init/main.c, the prink statement doesn't seem to print the characters on the screen. Is there any reason why it should not print characters, due to the fact that I loaded the kernel at 0x200000?? Will there be any other changes to the kernel source I have to make to avoid further problems??

  -Ravi

-----Original Message-----
From: Phillip Lougher [mailto:phillip@lougher.demon.co.uk] 
Sent: Thursday, March 06, 2003 6:13 PM
To: linux-kernel@vger.kernel.org
Subject: E: Loading and executing kernel from a non-standard address usin g SY SLINUX

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

