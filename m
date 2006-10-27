Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752513AbWJ0VmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbWJ0VmL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 17:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbWJ0VmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 17:42:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752513AbWJ0VmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 17:42:08 -0400
Date: Fri, 27 Oct 2006 14:41:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Pavel Machek <pavel@ucw.cz>, Rusty Russell <rusty@rustcorp.com.au>,
       virtualization <virtualization@lists.osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] Prep for paravirt: Be careful about touching BIOS
 address space
Message-Id: <20061027144157.f23fcf89.akpm@osdl.org>
In-Reply-To: <45427ABD.6070407@goop.org>
References: <1161920325.17807.29.camel@localhost.localdomain>
	<1161920535.17807.33.camel@localhost.localdomain>
	<20061027113001.GB8095@elf.ucw.cz>
	<45427ABD.6070407@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006 14:31:41 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Pavel Machek wrote:
> > Indentation is b0rken here.
> >   
> 
> Oops.  How strange.
> 
> > And... is get_user right primitive for accessing area that may not be
> > there?
> 
> I'm pretty sure there's precedent for using __get_user in this way 
> (get_user is a different matter, since it cares about whether the 
> address is within the user part of the address space).  Certainly in 
> arch/i386 code there shouldn't be a problem.  Is there some other way to 
> achieve the same effect (without manually setting up an exception/fixup 
> block)?

It'd be better to use include/linux/uaccess.h:probe_kernel_address() for
this operation.

