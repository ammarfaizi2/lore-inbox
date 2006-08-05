Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422729AbWHEESr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422729AbWHEESr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 00:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422733AbWHEESr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 00:18:47 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:2739 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1422729AbWHEESr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 00:18:47 -0400
Subject: Re: A proposal - binary
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       pazke@donpac.ru, Andi Kleen <ak@suse.de>
In-Reply-To: <44D3B0F0.2010409@vmware.com>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>
	 <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>
	 <20060804183448.GE11244@sequoia.sous-sol.org> <44D3B0F0.2010409@vmware.com>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 21:30:08 -0400
Message-Id: <1154741408.3683.171.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 13:41 -0700, Zachary Amsden wrote:
> Instead, what paravirt-ops promises long 
> term is a way to get rid of the sub-architecture layer altogether.  
> Sub-arches like Voyager and Visual workstation have some strange 
> initialization requirements, interrupt controllers, and SMP handling.  
> Exactly the kind of thing which paravirt_ops is being designed to 
> indirect for hypervisors. 

Well ... I agree that in principle it's possible to have a kernel that
would run on both voyager and a generic x86 system and, I'll admit, I
tried to go that route before creating the subarchitectures.  However,
in practice, I think the cost really becomes too high ... for voyager,
it becomes necessary really to intercept almost the entirety of the the
SMP API.  The purpose of the subarchitecture interface wasn't to
eventually have some API description that would allow voyager to
co-exist with more normal x86 systems.  It was to allow voyager to make
use of generic x86 while being completely different at the x86 SMP
level.  I really don't think there'll ever be another x86 machine that's
as different from the APIC approach as the voyager VIC/QIC is.  thus, I
think the actual x86 interface is much better described by mach-generic,
which abstracts out the interfaces necessary to the more standard APIC
based SMP systems.

James


