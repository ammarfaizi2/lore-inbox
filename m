Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWHIOpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWHIOpD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 10:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWHIOpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 10:45:03 -0400
Received: from web25222.mail.ukl.yahoo.com ([217.146.176.208]:52075 "HELO
	web25222.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750863AbWHIOpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 10:45:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=ECQbmRq09X1oflQOenIWWRskno8OKif8EEpLKnDqm5QZR5NsYtY+FB+kgS4shjejfeYfFXMN0u8JZo/gWIl4wG2AFP3bfnMADCP6qDmbjuMdjs6UOqkAYgYuZOMI6ZimwNRP9J5Omu7dOCtCsNwoO5F/ZYlo4gKCP3t2Tn51a44=  ;
Message-ID: <20060809144459.58896.qmail@web25222.mail.ukl.yahoo.com>
Date: Wed, 9 Aug 2006 16:44:59 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
Subject: Re: [PATCH 2/3] uml: fix proc-vs-interrupt context spinlock deadlock
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060808200231.GA6463@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> ha scritto: 

> On Tue, Aug 08, 2006 at 12:59:05PM +0200, Paolo Giarrusso wrote:
> > I could be wrong, but I trust that thanks to deep and good work
> by
> > who designed locking in the network layer, this patch is correct.
> And
> > indeed I addressed your issues below.
> 
> OK, but there will need to be comments explaining why it is OK that
> this data only looks half-locked.

Guess I'll put it in Documentation and reference it.

> The locking, as it stands, looks consistent and conservative.
Yes, it is.
> However, there are some places where critical sections are too big
> and
> the locking should be narrowed.

Yes, in particular we cannot hold a spinlock for the whole _open
since it must call sleeping functions. 

> > This is also true of char/block devices (you don't need to lock
> > against write/read in open/close; UBD doesn't know that but I
> have
> > unfinished patches for it), but there it's simpler: if userspace
> you
> > call close while a read is executing, thanks to refcounting
> (sys_read
> > does fget) the ->close (or ->release) is only called after the
> end of
> > ->read.
> 
> In my current patchset, there is a per-queue lock which is mostly
> managed by the block layer.

I'll try then to finish the patches soon and merge them; the main
problem is splitting (including the use of different locks) normal
locking from our peculiar locking of _open/_close against mconsole
changes.


Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
