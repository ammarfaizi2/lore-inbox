Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWHCS3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWHCS3g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 14:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWHCS3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 14:29:36 -0400
Received: from wx-out-0102.google.com ([66.249.82.194]:12320 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964832AbWHCS3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 14:29:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qAx5RH6gfTPmlV7dsbdeezWi/KssL+tI32GCL/jLZp+Rb2bNL9LbJXpnKRRGJu6QUTnNlzTgBF6zLth3QNJs4D+3vDwpInxG2M1DG2edvDEFJlrvqU+QOB44WoD23REMh9tvLrYHk60aAxi+HB1D72hbgV/CCoOYm20917ttOBA=
Message-ID: <69304d110608031129t5b39e581x3862d8a3dad407f6@mail.gmail.com>
Date: Thu, 3 Aug 2006 20:29:33 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Zachary Amsden" <zach@vmware.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>, greg@kroah.com,
       "Andrew Morton" <akpm@osdl.org>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Rusty Russell" <rusty@rustcorp.com.au>, "Jack Lo" <jlo@vmware.com>
Subject: Re: A proposal - binary
In-Reply-To: <44D23924.9040704@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44D1CC7D.4010600@vmware.com>
	 <1154603822.2965.18.camel@laptopd505.fenrus.org>
	 <69304d110608030516y16f7d1fdiaccfbe4ecca3084a@mail.gmail.com>
	 <44D23924.9040704@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/06, Zachary Amsden <zach@vmware.com> wrote:
> Antonio Vargas wrote:
> > If the essence of using virtual machines is precisely that the machine
> > acts just as if it was a real hardware one, then we should not need
> > any modifications to the kernel. So, it would be much better if the
> > hypervirsor was completely transparent and just emulated a native cpu
> > and a common native set of hardware, which would then work 100% with
> > the native code in the kernel. This keeps the smarts of virtual
> > machine management on the hypervisor.
>
> You are basically arguing for full virtualization - which is fine.  But
> today as it stands it does not provide the highest level of performance
> that paravirtualization does, and in the future, it does little to
> provide more advanced virtualization features.

I realise now that I missed mentioning my point. What I envision as a
stable binary interface for comunication between the kernel and the
hypervisor is exactly the current situation that goes into the
hypervisor when the kernel does any priviledged instruction. I
understand that paravirtualization gives a very good speed boost
(within 5% of native speed IIRC?), but I was also wondering about the
relative speed of running unmodified kernels.

> >
> > For example, TBL and pagetable handling can be done with 2 interfaces,
> > one standard via intercepting normal cpu instructions, and a batched
> > one via a hardware driver with a FIFO on shared memory just like many
> > graphics card do to send commands and data to the GPU. I recall this
> > design was the one used in the mac-on-linux hypervisor for ppc
> > architecture. Why not for x86 with vt/pacifica extensions? What about
> > using the same design than on the Sparc T1 port?
>
> You can't use a driver to do this in Linux today, because there are no
> hooks you can use for pagetable handling.  And you will always achieve
> better performance and simplicity by changing the machine definition to
> avoid the really nasty cases.  Hardware virtualization is simply not

Yes, I agree that doing it at the subarch level is good, so that
native subarch gets the original code and the hypervisored subarch
gets the modified one without messing with core kernel code.

> fast enough today.  But it also doesn't leave room for the future -
> proposals such as the abstract MMU interfaces for Linux which have been
> floating around are extremely attractive from a hypervisor point of view

I've been fishing in my mail archive and was unable to get any
discussion about abstract mmu... do you know where I can get more info
on that?

> - but there can be no progress until there is some kind of consensus on
> what those are, and having an interface in the kernel is a requirement
> for any deeper level of paravirtualization.
>
> Zach

Here I'd like to say that I mentioned both mol and the sun T1 because
so far we haven't had any discussion on whether any of their
interfaces are worth copying for the x86 case. Also worth looking at
would be the work done by IBM for ppc64 and s390, especially the last
one is prone to be very optimised since their hypervisor work has been
proven to work for a very long time.

I sure don't mean to diss out both vmware and xen work on the field,
given the rocky nature of the x86 architecture, but maybe taking a
look at preexisting work can be a good idea if it hasn't been done
earlier.

-- 
Greetz, Antonio Vargas aka winden of network
