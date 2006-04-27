Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWD0URa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWD0URa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWD0URa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:17:30 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:24582 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1030219AbWD0UR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:17:29 -0400
Date: Thu, 27 Apr 2006 22:15:31 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Avi Kivity <avi@argo.co.il>, dtor_core@ameritech.net,
       Kyle Moffett <mrmacman_g4@mac.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
Message-ID: <20060427201531.GH13027@w.ods.org>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com> <444E61FD.7070408@argo.co.il> <200604271810.07575.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604271810.07575.vda@ilport.com.ua>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2006 at 06:10:07PM +0300, Denis Vlasenko wrote:
> On Tuesday 25 April 2006 20:53, Avi Kivity wrote:
> > Very often one needs to acquire a resource, do something with it, and 
> > then free the resource. Here, "resource" can mean a file descriptor, a 
> > reference into a reference counted object, or, in our case, a spinlock. 
> > And we want "free" to mean "free no matter what", e.g. on a normal path 
> > or an exception path.
> 
> ...
> 
> > Additionally, C++ guarantees that if an exception is thrown after 
> > spin_lock() is called, then the spin_unlock() will also be called. 
> > That's an interesting mechanism by itself.
> 
> Life gets even more interesting when you hit another exception
> inside destructor(s) being executed due to first one.
> Say, spin_unlock() discovers that lock is already unlocked
> and does "throw BUG_double_unlock".
> 
> Even if you
> (a) remember what standard says about it
> (b) implemented nested exception handling correctly,
> 	then you are still left with
> (c) let's pray gcc has no bugs in stack unwinding
>     and nested exceptions and nested destructor calls.
> 
> Mozilla crashes over such things. For Mozilla, crash is not
> *that* catastrophic. For OS kernel, it is.

Mozilla is written in C++ ? I start to better understand where the
160 MB bloat comes from...

> vda

Cheers,
Willy

