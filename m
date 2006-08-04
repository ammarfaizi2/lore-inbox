Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWHDFEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWHDFEl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWHDFEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:04:41 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:16551 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751425AbWHDFEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:04:39 -0400
Subject: Re: A proposal - binary
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>, greg@kroah.com,
       zach@vmware.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       hch@infradead.org, jlo@vmware.com, xen-devel@lists.xensource.com,
       simon@xensource.com, ian.pratt@xensource.com, jeremy@goop.org
In-Reply-To: <20060803211850.3a01d0cc.akpm@osdl.org>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>
	 <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>
	 <44D2B678.6060400@xensource.com>  <20060803211850.3a01d0cc.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 15:04:35 +1000
Message-Id: <1154667875.11382.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 21:18 -0700, Andrew Morton wrote:
> > As far as LKML is concerned, the only interface which matters is the 
> > Linux -> <something> interface, which is defined within the scope of the 
> > Linux development process.  That's what paravirt_ops is intended to be.
> 
> I must confess that I still don't "get" paravirtops.  AFACIT the VMI
> proposal, if it works, will make that whole layer simply go away.  Which
> is attractive.  If it works.

Everywhere in the kernel where we have multiple implementations we want
to select at runtime, we use an ops struct.  Why should the choice of
Xen/VMI/native/other be any different?

Yes, we could force native and Xen to work via VMI, but the result would
be less clear, less maintainable, and gratuitously different from
elsewhere in the kernel.  And, of course, unlike paravirt_ops where we
can change and add ops at any time, we can't similarly change the VMI
interface because it's an ABI (that's the point: the hypervisor can
provide the implementation).

I hope that clarifies,
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

