Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbUCBFiW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 00:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUCBFiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 00:38:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19091 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261566AbUCBFiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 00:38:05 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] 2.6.4-rc1 remove x86 boot page tables
References: <m1vflp81kq.fsf@ebiederm.dsl.xmission.com>
	<1078167938.27444.43.camel@nighthawk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Mar 2004 22:29:44 -0700
In-Reply-To: <1078167938.27444.43.camel@nighthawk>
Message-ID: <m14qt77r5j.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Sun, 2004-02-29 at 23:32, Eric W. Biederman wrote:
> > I have rewritten and compiled tested the boot_ioremap code but I don't
> > have a configuration to test it. This effects the EFI code and the
> > numa srat code.   It might be worth replacing boot_ioremap with __va()
> > to reduce the amount of error checking necessary.
> 
> I can probably have someone test it, but you're right, we don't really
> need boot_ioremap() if we're going to map in all 4G at boot time.  I'd
> just prefer that you remove it completely in your patch.  
> 
> I can test it on some SRAT hardware if you'd like.  

I'd like.  

What I worry about with transforming boot_ioremap to __va are two things.
1) It is clear I haven't broken code that uses boot_ioremap if I don't
   touch them.  At least not that way.
2) There is a weird case at 4G where an exception is generated if
   you cross that boundary.  I forget if it is logical or physical
   address.  Keeping the boot_ioremap interface I can at least try and
   avoid that.

   If I can get a clear picture of what I am avoiding and be certain
   that it won't happen I will remove all objections.  But better safe
   than sorry at least for a start.

Eric
