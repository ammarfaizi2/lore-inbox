Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbVITLSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbVITLSr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 07:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVITLSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 07:18:45 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:37477 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964970AbVITLSo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 07:18:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HTKHuNDh9i9PZosM834LZnODJSDrq/jXMt9YyVRhBmzRE/irOs7JkgZNijyamAnBat741GMd9wgJK5yuKz5nJuw1cLw+3AJwxxhEw6r0heZS5xl2qYp1f2WEXy6nzK+HwVtDQ6X5hEuSLuNVNF3jA5KS+PsFNmhG+EiCrVwTj0I=
Message-ID: <84144f0205092004187f86840c@mail.gmail.com>
Date: Tue, 20 Sep 2005 14:18:42 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
Reply-To: Pekka Enberg <penberg@cs.helsinki.fi>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: p = kmalloc(sizeof(*p), )
In-Reply-To: <20050918100627.GA16007@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/18/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 1. The above implies that the common case is that we are changing the
>    names of structures more frequently than we change the contents of
>    structures.  Reality is that we change the contents of structures
>    more often than the names of those structures.
> 
>    Why is this relevant?  If you change the contents of structures,
>    they need checking for initialisation.  How do you find all the
>    locations that need initialisation checked?  Via grep.  The problem
>    is that:
> 
>         p = kmalloc(sizeof(*p), ...)
> 
>    is not grep-friendly, and can not be used to identify potential
>    initialisation sites.  However:
> 
>         p = kmalloc(sizeof(struct foo), ...)
> 
>    is grep-friendly, and will lead you to inspect each place where
>    such a structure is allocated for correct initialisation.

I would disagree on this one. You can still grep all the places where
the local variable is declared in. Furthermore, structs are not always
initialized where they're kmalloc'd so you need to manually inspect
anyway.

On 9/18/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 2. in the rare case that you're changing the name of a structure, you're
>    grepping the source for all instances for struct old_name, or doing
>    a search and replace for struct old_name.  You will find all instances
>    of struct old_name by this method and the bug alluded to will not
>    happen.

Perhaps it has poor wording but I was more thinking about a case where
you shuffle code around and forget that you changed a struct to
something else (not necessarily removing the old one).

On 9/18/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> So the assertion above that kmalloc(sizeof(*p) is somehow superiour is
> rather flawed, and as such should not be in the Coding Style document.

I think it is better because:

  - It is easier to get right.
  - It is easier to audit with a script.
  - It is shorter.

I am not saying you can use sizeof(*p) everywhere but it is the common
case and as such the preferred form.

                            Pekka
