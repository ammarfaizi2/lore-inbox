Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWCPLum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWCPLum (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 06:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbWCPLum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 06:50:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6859 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750917AbWCPLul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 06:50:41 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060315200956.4a9e2cb3.akpm@osdl.org> 
References: <20060315200956.4a9e2cb3.akpm@osdl.org>  <16835.1141936162@warthog.cambridge.redhat.com> <18351.1142432599@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, nickpiggin@yahoo.com.au
Cc: dhowells@redhat.com, inux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #5] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Thu, 16 Mar 2006 11:50:12 +0000
Message-ID: <21253.1142509812@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> >  The attached patch documents the Linux kernel's memory barriers.
> 
> Thanks for doing this.  Is it all settled now?

More or less, I think; but Nick has raised a good point about whether I should
be mentioning the existence of things like caching at all in the document,
except to say that memory barriers can't be assumed to have any effect on them.

The problem is that if I don't mention caches, I get lots of arguments about
the effects locking primitives have (since in modern CPUs these happen within
the caches and not much within memory). I can't just say these things affect
memory because it's just not necessarily true:-/

Basically, there's two levels on which someone could be attempting to use this
document: either they could have no interest in the way things work, and just
want a list of guarantees and may-not-assumes; or they may be interested in
*why* the things in this list are in this list - this is fairly important for
arch developers and maintainers, I think.

Maybe I should split the document into two or three:

 (1) A basic list of guarantees and may-not-assumes when using memory barriers,
     and why memory barriers are required.

 (2) Maybe a separate document on I/O barriers.

 (3) A specification of an abstract/base/whatever CPU model that people must
     assume the CPU they're using works like. In practice, any particular real
     CPU will probably be more restrictive than that, but generally that's not
     a problem. The problems come when CPUs are _less_ restrictive than the
     model.

     Such a document could be extended to cover more than just memory barriers.

David
