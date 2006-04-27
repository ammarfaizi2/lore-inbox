Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751673AbWD0VIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbWD0VIq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 17:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbWD0VIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 17:08:46 -0400
Received: from xproxy.gmail.com ([66.249.82.197]:31909 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751672AbWD0VIp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 17:08:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r7bomWND2/LPsmOHDPw+37yd4WnZCN7yoUIYN4+KBERkIsG5HWipU8ZGGs6oUU4/VCbIgzYwBa1XqM2dDAJN0h5/KbSbB5xJ27ObnvyXA/io1nRjYZU8e/7172IxbQ/9aAwFNZNNhQ/83gaygoRHoFABizIvqPU4TrpIbUt/NVU=
Message-ID: <750c918d0604271408y2afef6fflf380e4d0a6c1cec6@mail.gmail.com>
Date: Thu, 27 Apr 2006 18:08:44 -0300
From: "Davi Arnaut" <davi.lkml@gmail.com>
To: "Willy Tarreau" <willy@w.ods.org>
Subject: Re: Compiling C++ modules
Cc: "Denis Vlasenko" <vda@ilport.com.ua>, "Avi Kivity" <avi@argo.co.il>,
       dtor_core@ameritech.net, "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20060427201531.GH13027@w.ods.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
	 <d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com>
	 <444E61FD.7070408@argo.co.il> <200604271810.07575.vda@ilport.com.ua>
	 <20060427201531.GH13027@w.ods.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/06, Willy Tarreau <willy@w.ods.org> wrote:
> On Thu, Apr 27, 2006 at 06:10:07PM +0300, Denis Vlasenko wrote:
> > On Tuesday 25 April 2006 20:53, Avi Kivity wrote:
> > > Very often one needs to acquire a resource, do something with it, and
> > > then free the resource. Here, "resource" can mean a file descriptor, a
> > > reference into a reference counted object, or, in our case, a spinlock.
> > > And we want "free" to mean "free no matter what", e.g. on a normal path
> > > or an exception path.
> >
> > ...
> >
> > > Additionally, C++ guarantees that if an exception is thrown after
> > > spin_lock() is called, then the spin_unlock() will also be called.
> > > That's an interesting mechanism by itself.
> >
> > Life gets even more interesting when you hit another exception
> > inside destructor(s) being executed due to first one.
> > Say, spin_unlock() discovers that lock is already unlocked
> > and does "throw BUG_double_unlock".
> >
> > Even if you
> > (a) remember what standard says about it
> > (b) implemented nested exception handling correctly,
> >       then you are still left with
> > (c) let's pray gcc has no bugs in stack unwinding
> >     and nested exceptions and nested destructor calls.
> >
> > Mozilla crashes over such things. For Mozilla, crash is not
> > *that* catastrophic. For OS kernel, it is.
>
> Mozilla is written in C++ ? I start to better understand where the
> 160 MB bloat comes from...

Evolution is written in C.
