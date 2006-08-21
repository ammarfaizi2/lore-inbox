Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030503AbWHUORv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbWHUORv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 10:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbWHUORv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 10:17:51 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:30659 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030503AbWHUORu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 10:17:50 -0400
Date: Mon, 21 Aug 2006 10:17:21 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Andi Kleen <ak@suse.de>, Magnus Damm <magnus@valinux.co.jp>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com
Subject: Re: [Fastboot] [PATCH][RFC] x86_64: Reload CS when startup_64 is used.
Message-ID: <20060821141721.GA29498@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060821095328.3132.40575.sendpatchset@cherry.local> <200608211219.09042.ak@suse.de> <aec7e5c30608210629r4f2cf5dlfb1ad7d6cc95745d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7e5c30608210629r4f2cf5dlfb1ad7d6cc95745d@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 10:29:36PM +0900, Magnus Damm wrote:
> On 8/21/06, Andi Kleen <ak@suse.de> wrote:
> >
> >>
> >> +     /* Reload CS with a value that is within our GDT. We need to do 
> >this
> >> +      * if we were loaded by a 64 bit bootloader that happened to use a
> >> +      * CS that is larger than the GDT limit. This is true if we came 
> >here
> >> +      * from kexec running under Xen.
> >> +      */
> >> +     movq    %rsp, %rdx
> >> +     movq    $__KERNEL_DS, %rax
> >> +     pushq   %rax /* SS */
> >> +     pushq   %rdx /* RSP */
> >> +     movq    $__KERNEL_CS, %rax
> >> +     movq    $cs_reloaded, %rdx
> >> +     pushq   %rax /* CS */
> >> +     pushq   %rdx /* RIP */
> >> +     lretq
> >
> >Can't you just use a normal far jump? That might be simpler.
> 
> I couldn't find a far jump that took a 64-bit address to jump to. But
> I guess that the kernel will be loaded in the lowest 4G regardless so
> I guess 32-bit pointers are ok, right? That will make it simpler for
> sure.
> 

Given the idea of relocatable kernel is floating around I would prefer if
we are not bounded by the restriction of loading a kernel in lowest 4G.

Thanks
Vivek
