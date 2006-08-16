Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWHPPPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWHPPPP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 11:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWHPPPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 11:15:15 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:44205 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751204AbWHPPPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 11:15:13 -0400
Date: Wed, 16 Aug 2006 11:14:23 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] x86_64: Re-positioning the bss segment
Message-ID: <20060816151423.GA10874@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060815214952.GB11719@in.ibm.com> <20060816170314.f16f8afa.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816170314.f16f8afa.ak@muc.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 05:03:14PM +0200, Andi Kleen wrote:
> On Tue, 15 Aug 2006 17:49:52 -0400
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> 
> > 
> > o Currently bss segment is being placed somewhere in the middle (after .data)
> >   section and after bss lots of init section and data sections are coming.
> >   Is it intentional?
> 
> Not that I know of.
> 
> > 
> > o One side affect of placing bss in the middle is that objcopy keeps the
> >   bss in raw binary image (vmlinux.bin) hence unnecessarily increasing
> >   the size of raw binary image. (In my case ~600K). It also increases
> >   the size of generated bzImage, though the increase is very small
> >   (896 bytes), probably a very high compression ratio for stream
> >   of zeros.
> > 
> > o This patch moves the bss at the end hence reducing the size of
> >   bzImage by 896 bytes and size of vmlinux.bin by 600K.
> > 
> > o This change benefits in the context of relocatable kernel patches. If
> >   kernel bss is not part of compressed data (vmlinux.bin) then it does
> >   not have to be decompressed and this area can be used by the decompressor
> >   for its execution hence keeping the memory requirements bounded and 
> >   decompressor code does not stomp over any other data loaded beyond
> >   kernel image (As might be the case with bootloaders like kexec).
> 
> Merged thanks. 
> 
> Does i386 need a similar change?

Nope. i386 already has bss at the end.

Thanks
Vivek
