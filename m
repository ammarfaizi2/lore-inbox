Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030259AbWHDFio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbWHDFio (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWHDFio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:38:44 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:43392 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1030259AbWHDFin
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:38:43 -0400
Date: Thu, 3 Aug 2006 22:40:02 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>, greg@kroah.com,
       zach@vmware.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       hch@infradead.org, rusty@rustcorp.com.au, jlo@vmware.com,
       xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com, jeremy@goop.org
Subject: Re: A proposal - binary
Message-ID: <20060804054002.GC11244@sequoia.sous-sol.org>
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com> <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com> <44D2B678.6060400@xensource.com> <20060803211850.3a01d0cc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803211850.3a01d0cc.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> I must confess that I still don't "get" paravirtops.  AFACIT the VMI
> proposal, if it works, will make that whole layer simply go away.  Which
> is attractive.  If it works.

Paravirtops is simply a table of function which are populated by the
hypervisor specific code at start-of-day.  Some care is taken to patch
up callsites which are performance sensitive.  The main difference is
the API vs. ABI distinction.  In paravirt ops case, the ABI is defined at
compile time from source.  The VMI takes it one step further and fixes
the ABI.  That last step is a big one.

There are two basic issues. 1) what is the interface between the kernel
and the glue to a hypervisor. 2) how does one call from the kernel into
the glue layer.

Getting bogged down in #2, the details of the calling convention, is a
distraction from the real issue, #1.  We are trying to actually find an
API that is useful for multiple projects.  Paravirt_ops gives the
flexibility to evolve the interface.
