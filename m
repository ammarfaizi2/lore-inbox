Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWEITeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWEITeT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWEITeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:34:19 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:21228 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750972AbWEITeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:34:18 -0400
Subject: Re: [RFC PATCH 03/35] Add Xen interface header files
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>
In-Reply-To: <20060509151516.GA16332@infradead.org>
References: <20060509084945.373541000@sous-sol.org>
	 <20060509085147.903310000@sous-sol.org>
	 <20060509151516.GA16332@infradead.org>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Tue, 09 May 2006 14:35:09 -0500
Message-Id: <1147203309.19485.62.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-09 at 16:15 +0100, Christoph Hellwig wrote:
> 
> > +#ifdef __XEN__
> > +#define __DEFINE_GUEST_HANDLE(name, type) \
> > +    typedef struct { type *p; } __guest_handle_ ## name
> > +#else
> > +#define __DEFINE_GUEST_HANDLE(name, type) \
> > +    typedef type * __guest_handle_ ## name
> > +#endif
> 
> please get rid of all these stupid typedefs 

These typedefs are a new hack to work around a basic interface problem:
instead of explicitly-sized types, Xen uses longs and pointers in its
interface. On PowerPC in particular, where we need a 32-bit userland
communicating with a 64-bit hypervisor, those types don't work.

However, the maintainers are reluctant to switch the interface to use
explicitly-sized types because it would break binary compatibility.
These ugly "HANDLE" macros allow PowerPC to do what we need without
affecting binary compatibility on x86.

-- 
Hollis Blanchard
IBM Linux Technology Center

