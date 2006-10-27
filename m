Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWJ0Mmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWJ0Mmm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 08:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbWJ0Mmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 08:42:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:51985 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750863AbWJ0Mmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 08:42:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LOtIQXjbmtz0Lms56Z/5Eq00GnM6j6mEjzyzNWKVYSlM7p9Co0f18QaEpwzAZGLpYLltNEMZ7jZLCGwYQaew89sQInKLs7QZZvvC8kuiaqcgD0UfJmmJ/d2NGueGRmjIlCGI7HsZHrnaj6gNbHLP+ym8cn9QK8bVhXcX+TW6Vm0=
Message-ID: <653402b90610270542i6d07885ct4beae131b3d09809@mail.gmail.com>
Date: Fri, 27 Oct 2006 14:42:39 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 2.6.19-rc1 update4] drivers: add LCD support
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061026220703.37182521.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061026174858.b7c5eab1.maxextreme@gmail.com>
	 <20061026220703.37182521.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/06, Andrew Morton <akpm@osdl.org> wrote:
> On Thu, 26 Oct 2006 17:48:58 +0000
> Miguel Ojeda Sandonis <maxextreme@gmail.com> wrote:
>
> >
> > +DECLARE_MUTEX(cfag12864bfb_sem);
>
> Mutexes are preferred - please only use semaphores if their counting
> feature is required.
>
> This lock can have static scope.
>
> > +struct page *cfag12864bfb_vma_nopage(struct vm_area_struct *vma,
> > +     unsigned long address, int *type)
>
> This function can have static scope.
>
> > +{
> > +     struct page *page;
> > +     down(&cfag12864bfb_sem);
> > +
> > +     page = virt_to_page(cfag12864b_buffer);
> > +     get_page(page);
> > +
> > +     if(type)
> > +             *type = VM_FAULT_MINOR;
> > +
> > +     up(&cfag12864bfb_sem);
> > +     return page;
> > +}
>
> What's the semaphore actually needed for?
>

Hum, the code is based on LDD3, I just adapted it removing a few
lines. I thought this code also needed lock protection as the LDD3
example. I'm sending a new patch in a few moments with this 3 things
fixed.

Thanks you,
     Miguel Ojeda
