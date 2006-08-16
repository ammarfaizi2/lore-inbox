Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWHPPDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWHPPDT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 11:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWHPPDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 11:03:18 -0400
Received: from one.firstfloor.org ([213.235.205.2]:19397 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S1751202AbWHPPDS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 11:03:18 -0400
Date: Wed, 16 Aug 2006 17:03:14 +0200
From: Andi Kleen <ak@muc.de>
To: vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] x86_64: Re-positioning the bss segment
Message-Id: <20060816170314.f16f8afa.ak@muc.de>
In-Reply-To: <20060815214952.GB11719@in.ibm.com>
References: <20060815214952.GB11719@in.ibm.com>
Organization: unorganized
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 17:49:52 -0400
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> 
> o Currently bss segment is being placed somewhere in the middle (after .data)
>   section and after bss lots of init section and data sections are coming.
>   Is it intentional?

Not that I know of.

> 
> o One side affect of placing bss in the middle is that objcopy keeps the
>   bss in raw binary image (vmlinux.bin) hence unnecessarily increasing
>   the size of raw binary image. (In my case ~600K). It also increases
>   the size of generated bzImage, though the increase is very small
>   (896 bytes), probably a very high compression ratio for stream
>   of zeros.
> 
> o This patch moves the bss at the end hence reducing the size of
>   bzImage by 896 bytes and size of vmlinux.bin by 600K.
> 
> o This change benefits in the context of relocatable kernel patches. If
>   kernel bss is not part of compressed data (vmlinux.bin) then it does
>   not have to be decompressed and this area can be used by the decompressor
>   for its execution hence keeping the memory requirements bounded and 
>   decompressor code does not stomp over any other data loaded beyond
>   kernel image (As might be the case with bootloaders like kexec).

Merged thanks. 

Does i386 need a similar change?

-Andi

 
