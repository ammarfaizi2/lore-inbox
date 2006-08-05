Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422668AbWHEEQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422668AbWHEEQJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 00:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422729AbWHEEQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 00:16:09 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:64946 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1422668AbWHEEQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 00:16:08 -0400
Subject: Re: A proposal - binary
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       pazke@donpac.ru, Andi Kleen <ak@suse.de>
In-Reply-To: <1154726800.23655.273.camel@localhost.localdomain>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>
	 <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>
	 <20060804183448.GE11244@sequoia.sous-sol.org> <44D3B0F0.2010409@vmware.com>
	 <1154726800.23655.273.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 21:14:45 -0400
Message-Id: <1154740485.3683.161.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 22:26 +0100, Alan Cox wrote:
> In part thats a legal question so only a lawyer can really tell you
> what
> is and isn't the line for derivative works. 

Actually, this isn't quite true.  In any licensing agreement between two
parties, what each thinks is an important consideration in the
enforcement of the agreement.  This is how we got binary modules in the
first place, and so it also follows that what kernel developers think
about this proposal is an important influence on the eventual legal
opinon.

My take is that the VMI proposal breaks down into two pieces:

1) A hypervisor ABI.  This is easy: we maintain ABIs today between libc
and the kernel, so nothing about an ABI is inherantly GPL violating.

2) A gateway page or vDSO provided by the hypervisor to the kernel.
This is the problematic piece, because the vDSO is de-facto linked into
the kernel and as such becomes subject to the prevailing developer
interpretation as being a derivative work by being linked in.  As Arjan
pointed out, this can be avoided as long as the gateway page itself is
GPL ... we could even create mechanisms like we use today for module
licensing by having a tag in the VMI describing the licensing of the
gateway page, so the kernel could be made only to load gateway pages
that promise they're available under the GPL.

I think that if we do this tagging to load the VMI vDSO interface, then
I'm happy that all of the legal niceties are safely taken care of.
(Although the onus is now back on VMware to establish if they can GPL
their VMI blob).

James


