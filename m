Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbUKPRL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUKPRL1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 12:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbUKPRL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 12:11:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:1929 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262045AbUKPRLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 12:11:17 -0500
Date: Tue, 16 Nov 2004 09:11:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: fork pagesize patch
In-Reply-To: <26707.1100624330@redhat.com>
Message-ID: <Pine.LNX.4.58.0411160909370.2222@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411160834220.2222@ppc970.osdl.org> 
 <Pine.LNX.4.58.0411160800060.2222@ppc970.osdl.org> <20968.1100619491@redhat.com>
 <23880.1100621506@redhat.com> <26707.1100624330@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Nov 2004, David Howells wrote:
> >
> > I think it _is_ unreasonable. It's like doing
> >
> > 	if (a)
> > 		x /= a;
> 
> Doing it with variables is not exactly the same. The compiler has been told to
> optimise arithmetic on constants, and as such it has to represent a div-by-0
> result, which obviously it can't.

But you snipped the part where the above source code _does_ end up being 
done on constants - in macro expansion and in inline functions. So the 
compiler really _can_ have a constant zero in the divide, and it really 
_can_ come from perfectly normal code. 

In fact, maybe code like the kernel had.

> > Anyway, to make it not warn, why not change it to
> >
> > 	max_threads = mempages / (8*THREAD_SIZE/PAGE_SIZE);
> >
> > instead, and be done with it?
> 
> And drop the conditional entirely? I can go along with that.

Right. It looks like the obvious thing to do, and is really what the code 
_tried_ to do in the first place.

		Linus
