Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422754AbWHEEdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422754AbWHEEdi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 00:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422755AbWHEEdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 00:33:38 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:19108 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1422754AbWHEEdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 00:33:37 -0400
Message-ID: <44D41F9D.8030409@vmware.com>
Date: Fri, 04 Aug 2006 21:33:33 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       pazke@donpac.ru, Andi Kleen <ak@suse.de>
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>	 <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>	 <20060804183448.GE11244@sequoia.sous-sol.org> <44D3B0F0.2010409@vmware.com> <1154741408.3683.171.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1154741408.3683.171.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> Well ... I agree that in principle it's possible to have a kernel that
> would run on both voyager and a generic x86 system and, I'll admit, I
> tried to go that route before creating the subarchitectures.  However,
> in practice, I think the cost really becomes too high ... for voyager,
> it becomes necessary really to intercept almost the entirety of the the
> SMP API.  The purpose of the subarchitecture interface wasn't to
> eventually have some API description that would allow voyager to
> co-exist with more normal x86 systems.  It was to allow voyager to make
> use of generic x86 while being completely different at the x86 SMP
> level.  I really don't think there'll ever be another x86 machine that's
> as different from the APIC approach as the voyager VIC/QIC is.  thus, I
> think the actual x86 interface is much better described by mach-generic,
> which abstracts out the interfaces necessary to the more standard APIC
> based SMP systems.
>   

This is quite true today.  But it is entirely possible that support in 
Linux for Xen may want to rip out the APIC / IO-APIC entirely, replace 
that with event channels, and use different SMP shootdown mechanisms, as 
well as having their own special NMI delivery hook.  We're also going to 
have to make certain parts of the interface extremely efficient, and 
we've already got several schemes to remove the penalty of indirection 
by being rid of indirect branches - which could be a more broadly used 
technique if it proves unintrusive and reliable enough.  In that case, 
you could basically support Voyager without a subarch, plus or minus one 
special hook or two ;)

Zach

