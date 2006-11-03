Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753163AbWKCGpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbWKCGpo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 01:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753164AbWKCGpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 01:45:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:37712 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1753163AbWKCGpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 01:45:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=muI5KgNv0rPOesw4gpyaQA+zmdOJJeKDpTOS/L+1m2tIKhEws1tbZgYX99gFSxCg+wR9MEA55ZSJiymKkgUUc42Zyip722WyuAUPU3z9yRSGm/HtSIEVNBvQ81jToq/rKTedQHhVZwbEKzpT1G5CfUT5IOVnt7iD1zHmeXaTvBc=
Message-ID: <653402b90611022245s3115efbev3c003302aa4f2433@mail.gmail.com>
Date: Fri, 3 Nov 2006 07:45:41 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH update6] drivers: add LCD support
Cc: akpm@osdl.org, vagabon.xyz@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20061102.160035.85409500.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061102111311.1b2648c3.akpm@osdl.org>
	 <653402b90611021133i35683ac4i5f4da4098373603c@mail.gmail.com>
	 <20061102120412.bc25e2d0.akpm@osdl.org>
	 <20061102.160035.85409500.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/06, David Miller <davem@davemloft.net> wrote:
> From: Andrew Morton <akpm@osdl.org>
> Date: Thu, 2 Nov 2006 12:04:12 -0800
>
> > On Thu, 2 Nov 2006 19:33:48 +0000
> > "Miguel Ojeda" <maxextreme@gmail.com> wrote:
> >
> > > May 2.6.18-new vmalloc
> > > related functions help correlating userspace & kernel addresses? I
> > > will try them and come with an answer tomorrow.
> > >
> > > Quoting http://lwn.net/Articles/2.6-kernel-api/
> > >
> > > "Some functions have been added to make it easy for kernel code to
> > > allocate a buffer with vmalloc() and map it into user space. They are:
> > >
> > >      void *vmalloc_user(unsigned long size);
> > >      void *vmalloc_32_user(unsigned long size);
> > >      int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
> > >                              unsigned long pgoff);
> > >
> > > The first two functions are a form of vmalloc() which obtain memory
> > > intended to be mapped into user space; among other things, they zero
> > > the entire range to avoid leaking data. vmalloc_32_user() allocates
> > > low memory only. A call to remap_vmalloc_range() will complete the
> > > job; it will refuse, however, to remap memory which has not been
> > > allocated with one of the two functions above."
> >
> > No, it doesn't look like those helper functions are designed to handle this.
> >
> > I'm really not the person to be asking about this.  I can poke around in
> > arch/sparc64/kernel/sys_sparc.c:arch_get_unmapped_area() as well as the
> > next guy, and it seems to be doing the right thing for MAP_FIXED, but
> > how/whether it handles !MAP_FIXED I do not know.  Ask davem ;)
>
> Unfortunately that code never gets called for MAP_FIXED :-)
>
> I'll comment on these issues and explain what needs to occur,
> we have several things that want to do this kind of user/kernel
> sharing of ring buffers and similar, so best to get the
> infrastructure going to get it right.
>
> As a first approximation, getting remap_vmalloc_range() to do the
> right thing is the best way to start this stuff off.
>

Ok, thanks you! If I can help with anything, please tell me.

In the meantime I will play with vmalloc_user() and friends.
