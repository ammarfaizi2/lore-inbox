Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWC2Rym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWC2Rym (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 12:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWC2Rym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 12:54:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4537 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750917AbWC2Ryl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 12:54:41 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200603282225.k2SMP6kb023905@baham.cs.pdx.edu> 
References: <200603282225.k2SMP6kb023905@baham.cs.pdx.edu> 
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: [PATCH] Document Linux's memory barriers [try #5] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 29 Mar 2006 18:54:05 +0100
Message-ID: <21401.1143654845@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suzanne Wood <suzannew@cs.pdx.edu> wrote:

> Seems like the subject of "will never happen" is the read from memory for the 
> asmt to X, but does that sentence say that?  

"asmt"?

I agree that it doesn't make much sense, so how's this instead?

+ However, it is guaranteed that a CPU will be self-consistent: it will see its
+ _own_ accesses appear to be correctly ordered, without the need for a memory
+ barrier.  For instance with the following code:
+ 
+ 	X = *A;
+ 	*A = Y;
+ 	Z = *A;
+ 
+ and assuming no intervention by an external influence, it can be taken that:
+ 
+  (*) X will end up holding the original value of *A, as
+ 
+  (*) the load of X from *A will never happen after the store of Y into *A, and
+      thus
+ 
+  (*) X will never be given instead the value that was assigned from Y to *A;
+      and
+ 
+  (*) Z will always be given the value in *A that was assigned there from Y, as
+ 
+  (*) the load of Z from *A will never happen before the store, and thus
+ 
+  (*) Z will never be given instead the value that was in *A initially.
+ 
+ (This ignores the fact that the value initially in *A may appear to be the same
+ as the value assigned to *A from Y).

I'm not sure I want to split the points up that way, but it does make them
clearer.  I'm not sure that method of linking them works, since it looks like
a bunch of incomplete statements.

Really, this should be described mathematically, if at all.

> It seems to require more effort than necessary to understand in regard to
> all that is presented in this document.

Are you referring to my attempt to define a self-consistent CPU?  Or to the
subject in general?

If the former, you may be right.  I'll look at compressing the whole thing
down to a single paragraph.

David
