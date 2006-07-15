Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945980AbWGOCfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945980AbWGOCfU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 22:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945966AbWGOCfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 22:35:20 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:33931 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1945959AbWGOCfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 22:35:19 -0400
Subject: Re: [PATCH 01/02] remove set_wmb - doc update
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       mingo@elte.hu, linux-arch@vger.kernel.org,
       David Howells <dhowells@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060715022233.GA1578@parisc-linux.org>
References: <1152882288.1883.30.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607140757080.5623@g5.osdl.org>
	 <Pine.LNX.4.64.0607141017520.5623@g5.osdl.org>
	 <1152898699.27135.20.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607141040550.5623@g5.osdl.org>
	 <20060714105841.4490c0e2.akpm@osdl.org>
	 <1152907501.27135.44.camel@localhost.localdomain>
	 <20060715022233.GA1578@parisc-linux.org>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 22:35:03 -0400
Message-Id: <1152930903.27135.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 20:22 -0600, Matthew Wilcox wrote:
> On Fri, Jul 14, 2006 at 04:05:01PM -0400, Steven Rostedt wrote:
> >  There are some more advanced barrier functions:
> >  
> >   (*) set_mb(var, value)
> > - (*) set_wmb(var, value)
> >  
> > -     These assign the value to the variable and then insert at least a write
> > -     barrier after it, depending on the function.  They aren't guaranteed to
> > +     This assigns the value to the variable and then inserts at least a write
> > +     barrier after it, depending on the function.  It isn't guaranteed to
> >       insert anything more than a compiler barrier in a UP compilation.
> 
> "There is one more advanced barrier function"?  ;-)  Or did you want to
> remove set_mb()?

Actually below the patch area we still have:

 (*) smp_mb__before_atomic_dec();
 (*) smp_mb__after_atomic_dec();
 (*) smp_mb__before_atomic_inc();
 (*) smp_mb__after_atomic_inc();

So that "There are" references them too :)

> 
> Plus, the "depending on the function" bit means "respectively".  So what
> you really want as help is something like:
> 
> 	This assigns the value to the variable and then inserts a
> 	barrier after the assignment.  It isn't guaranteed to insert
> 	anything more than a compiler barrier in a UP compilation.

OK, you're right here, that "depending on the function" needs to go.
Here's a better version:

Thanks,

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.18-rc1/Documentation/memory-barriers.txt
===================================================================
--- linux-2.6.18-rc1.orig/Documentation/memory-barriers.txt	2006-07-14 15:38:23.000000000 -0400
+++ linux-2.6.18-rc1/Documentation/memory-barriers.txt	2006-07-14 22:31:01.000000000 -0400
@@ -1015,11 +1015,10 @@ CPU from reordering them.
 There are some more advanced barrier functions:
 
  (*) set_mb(var, value)
- (*) set_wmb(var, value)
 
-     These assign the value to the variable and then insert at least a write
-     barrier after it, depending on the function.  They aren't guaranteed to
-     insert anything more than a compiler barrier in a UP compilation.
+     This assigns the value to the variable and then inserts a memory barrier
+     after it.  It isn't guaranteed to insert anything more than a compiler
+     barrier in a UP compilation.
 
 
  (*) smp_mb__before_atomic_dec();


