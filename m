Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161071AbWHDHFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbWHDHFH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 03:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbWHDHFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 03:05:07 -0400
Received: from ozlabs.org ([203.10.76.45]:34987 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161071AbWHDHFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 03:05:05 -0400
Subject: Re: A proposal - binary
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: jeremy@xensource.com, greg@kroah.com, zach@vmware.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       jlo@vmware.com, xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com, jeremy@goop.org
In-Reply-To: <20060803225357.e9ab5de1.akpm@osdl.org>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>
	 <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>
	 <44D2B678.6060400@xensource.com> <20060803211850.3a01d0cc.akpm@osdl.org>
	 <1154667875.11382.37.camel@localhost.localdomain>
	 <20060803225357.e9ab5de1.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 17:04:59 +1000
Message-Id: <1154675100.11382.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 22:53 -0700, Andrew Morton wrote:
> On Fri, 04 Aug 2006 15:04:35 +1000
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > On Thu, 2006-08-03 at 21:18 -0700, Andrew Morton wrote:
> > Everywhere in the kernel where we have multiple implementations we want
> > to select at runtime, we use an ops struct.  Why should the choice of
> > Xen/VMI/native/other be any different?
> 
> VMI is being proposed as an appropriate way to connect Linux to Xen.  If
> that is true then no other glue is needed.

Sorry, this is wrong.  VMI was proposed as the appropriate way to
connect Linux to Xen, *and* native, *and* VMWare's hypervisors (and
others).  This way one Linux binary can boot on all three, using
different VMI blobs.

> > Yes, we could force native and Xen to work via VMI, but the result would
> > be less clear, less maintainable, and gratuitously different from
> > elsewhere in the kernel.
> 
> I suspect others would disagree with that.  We're at the stage of needing
> to see code to settle this.

Wrong again.  We've *seen* the code for VMI, and fairly hairy.  Seeing
the native-implementation and Xen-implementation VMI blobs will not make
it less hairy!

> >  And, of course, unlike paravirt_ops where we
> > can change and add ops at any time, we can't similarly change the VMI
> > interface because it's an ABI (that's the point: the hypervisor can
> > provide the implementation).
> 
> hm.  Dunno.  ABIs can be uprevved.  Perhaps.

Certainly VMI can be.  But I'd prefer to leave the excellent hackers at
VMWare with the task of maintaining their ABI, and let Linux hackers
(most of whom will run native) manipulate paravirt_ops freely.

We're not good at maintaining ABIs.  We're going to be especially bad at
maintaining an ABI when the 99% of us running native will never notice
the breakage.

Hope that clarifies,
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

