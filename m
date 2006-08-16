Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWHPGuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWHPGuE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 02:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWHPGuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 02:50:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51335 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750860AbWHPGuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 02:50:02 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>, Fastboot mailing list <fastboot@lists.osdl.org>,
       Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] x86_64: Re-positioning the bss segment
References: <20060815214952.GB11719@in.ibm.com>
Date: Wed, 16 Aug 2006 00:48:56 -0600
In-Reply-To: <20060815214952.GB11719@in.ibm.com> (Vivek Goyal's message of
	"Tue, 15 Aug 2006 17:49:52 -0400")
Message-ID: <m1r6zh5g6f.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> o Currently bss segment is being placed somewhere in the middle (after .data)
>   section and after bss lots of init section and data sections are coming.
>   Is it intentional?
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

Looks sane here.  I don't know if there are any side effects from placing
the .bss after the .init sections that we discard at after boot.

Unless this has undesirable side effects this should have us doing the
expected thing, with the .bss section which is less likely to confuse people
in general.

> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
Acked-by: Eric Biederman <ebiederm@xmission.com>

Eric
