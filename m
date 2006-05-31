Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751715AbWEaRUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbWEaRUI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 13:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbWEaRUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 13:20:07 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:21478 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751715AbWEaRUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 13:20:06 -0400
Date: Wed, 31 May 2006 13:19:34 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Magnus Damm" <magnus.damm@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Magnus Damm" <magnus@valinux.co.jp>, "Andrew Morton" <akpm@osdl.org>,
       fastboot@lists.osdl.org
Subject: Re: [Fastboot] [PATCH 03/03] kexec: Avoid overwriting the current pgd (V2, x86_64)
Message-ID: <20060531171934.GB8475@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060524044232.14219.68240.sendpatchset@cherry.local> <20060524044247.14219.13579.sendpatchset@cherry.local> <m1slmystqa.fsf@ebiederm.dsl.xmission.com> <1148545616.5793.180.camel@localhost> <m11wuif5zy.fsf@ebiederm.dsl.xmission.com> <aec7e5c30605252017v1d8269a4jf75f055fe256f966@mail.gmail.com> <m1ejygbvcc.fsf@ebiederm.dsl.xmission.com> <aec7e5c30605290140s5163b8c6k9806f23e2a26bf35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7e5c30605290140s5163b8c6k9806f23e2a26bf35@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2006 at 05:40:32PM +0900, Magnus Damm wrote:
> 
> >However while I agree that you need to do this in assembly for
> >control I disagree that this code should be part of the
> >relocate_new_kernel function.
> >
> >Please move the code that uses page_table_a to a separate function,
> >that when it is done jumps to the control_code page.  Then you can
> >map this page both virtually and physically with a statically
> >allocated page table built a compile time.
> 
> This function, you write "uses page_table_a". Do you mean that the
> function allocates it? Or fills it in? Or maybe switches to it? Please
> clarify!
> 
> >This is a little simpler as you don't need to build this first
> >page table dynamically and a little clearer as you aren't trying to
> >get the control code page to serve two different functions.
> 
> But doesn't a static set of pages used for page_table_a just mean that
> you are wasting valuable unswappable kernel memory?

In your implementation, is control page swappable?

>Also, how can you
> be sure that the static pages are in a DMA-safe address range?
> 

Why would kernel setup DMA on statically allocated pages?    

Thanks
Vivek
