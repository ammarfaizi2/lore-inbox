Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751648AbWHUN3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbWHUN3j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 09:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWHUN3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 09:29:39 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:6776 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751875AbWHUN3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 09:29:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JIj6yfrVskdw73n0St1WYR/R0Fv9EGIEqhuf3g9rK6Pbyv8tN/BGb1IZQJnTSqIsOQza2DXShZsbRtP+Zu/pmeIp/ksklMNPQWjPFuph3FTaE3XK58NAowkf3rEFXJjEjyBGupRzmR0aCwLj74DYWDdtQFCJO4Bokbx6mZp3ZKk=
Message-ID: <aec7e5c30608210629r4f2cf5dlfb1ad7d6cc95745d@mail.gmail.com>
Date: Mon, 21 Aug 2006 22:29:36 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [Fastboot] [PATCH][RFC] x86_64: Reload CS when startup_64 is used.
Cc: "Magnus Damm" <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, ebiederm@xmission.com
In-Reply-To: <200608211219.09042.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060821095328.3132.40575.sendpatchset@cherry.local>
	 <200608211219.09042.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/06, Andi Kleen <ak@suse.de> wrote:
>
> >
> > +     /* Reload CS with a value that is within our GDT. We need to do this
> > +      * if we were loaded by a 64 bit bootloader that happened to use a
> > +      * CS that is larger than the GDT limit. This is true if we came here
> > +      * from kexec running under Xen.
> > +      */
> > +     movq    %rsp, %rdx
> > +     movq    $__KERNEL_DS, %rax
> > +     pushq   %rax /* SS */
> > +     pushq   %rdx /* RSP */
> > +     movq    $__KERNEL_CS, %rax
> > +     movq    $cs_reloaded, %rdx
> > +     pushq   %rax /* CS */
> > +     pushq   %rdx /* RIP */
> > +     lretq
>
> Can't you just use a normal far jump? That might be simpler.

I couldn't find a far jump that took a 64-bit address to jump to. But
I guess that the kernel will be loaded in the lowest 4G regardless so
I guess 32-bit pointers are ok, right? That will make it simpler for
sure.

What do you think about reloading CS? Is it the right thing to do, or
is it correct as it is today where we depend on that CS == _KERNEL_CS?
I need to fix kexec-tools regardless, but maybe it is a good idea to
make the 64-bit kernel boot a bit robust too.

Thanks,

/ magnus
