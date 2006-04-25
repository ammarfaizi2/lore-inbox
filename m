Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWDYU3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWDYU3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWDYU3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:29:36 -0400
Received: from mail-03.jhb.wbs.co.za ([196.2.97.2]:45865 "EHLO
	mail-03.jhb.wbs.co.za") by vger.kernel.org with ESMTP
	id S932293AbWDYU3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:29:36 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AQAAAOEfTkSIbgEKDio
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Matt Keenan <matt.keenan@btinternet.com>
Subject: Re: Compiling C++ modules
Date: Tue, 25 Apr 2006 22:29:36 +0200
User-Agent: KMail/1.9.1
Cc: Avi Kivity <avi@argo.co.il>, LKML <linux-kernel@vger.kernel.org>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <444DCDB8.4070807@argo.co.il> <444DE678.4040805@btinternet.com>
In-Reply-To: <444DE678.4040805@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604252229.36533.bonganilinux@mweb.co.za>
X-Original-Subject: Re: Compiling C++ modules
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 April 2006 11:06, Matt Keenan wrote:
> Avi Kivity wrote:
> >
> > Maybe not mathematically, but I can try to hand-wave my way through.
> >
> > By using exceptions, you free the normal return paths from having to
> > check for errors. The exception paths can be kept in a dedicated
> > section, avoiding cache pollution. The total code (and data) size
> > increases, but the non-exception paths size decreases significantly
> > and becomes faster.
> >
> > Using C++ objects instead of C objects allows you to avoid void
> > pointers, which are difficult for the compiler to optimize due to
> > aliasing.
>
> Exception handling on a kernel with a 4K stack would be very
> interesting, now imagine what would happen if one exception triggered
> another? and possibly another?? And even giving up on the stack issues,
> what about cacheline / performance issues? Moving error handling even
> further from the fast path isn't going to help performance much.. How
> about an exception for every ENOENT? Have you seen how many ENOENT's
> /lib/ld-linux.so.2 generates when a large app starts? Take firefox, load
> it, let it open five tabs, then shut it down. On my system, 1377
> open()'s, 527 of which are ENOENT, 135 of those before the program has
> finished linking. Not exactly the best way to speed the system up. And
> don't say you can use the dentry cache to return an object or NULL, as
> this is just replication of what C does, but with even more syntatic
> goop. C++ is a good tool, for the right job. The kernel is not one of them.
>

To enable stack unwinding for exception handling, extra exception-related 
information about each function needs to be available for each stack frame. 
This information describes which destructors need to be called (so that local 
objects can be cleaned up), indicates whether the current function has a try 
block, and lists which exceptions the associated catch clauses can handle.

Take a look at a typical OOPS trace and tell me if that will fit in a 4k stack 
with C++ and stack unwinding.

---
    Choose the right tools, use them the right way. 
     Refuse to compromise, expect  to succeed, 
                      Then start again.
