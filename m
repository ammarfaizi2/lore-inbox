Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbTKKScI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 13:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263693AbTKKScI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 13:32:08 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:39601 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263692AbTKKScE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 13:32:04 -0500
Date: Tue, 11 Nov 2003 10:57:14 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: Erik Jacobson <erikj@subway.americas.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6 /proc/interrupts fails on systems with many CPUs
Message-ID: <12800000.1068577034@flay>
In-Reply-To: <Pine.LNX.4.44.0311111019210.30657-100000@home.osdl.org>
References: <Pine.LNX.4.44.0311111019210.30657-100000@home.osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I think it'd make more sense to only use vmalloc when it's explicitly 
>> too big for kmalloc - or simply switch on num_online_cpus > 100 or 
>> whatever a sensible cutoff is (ie nobody but you would ever see this ;-))
> 
> No, please please please don't do these things.
> 
> vmalloc() is NOT SOMETHING YOU SHOULD EVER USE! It's only valid for when
> you _need_ a big array, and you don't have any choice. It's slow, and it's
> a very restricted resource: it's a global resource that is literally
> restricted to a few tens of megabytes. It should be _very_ carefully used.
> 
> There are basically no valid new uses of it. There's a few valid legacy
> users (I think the file descriptor array), and there are some drivers that
> use it (which is crap, but drivers are drivers), and it's _really_ valid
> only for modules. Nothing else.
> 
> Basically: if you think you need more memory than a kmalloc() can give,
> you need to re-organize your data structures. To either not need a big 
> area, or to be able to allocate it in chunks.

OK, I was actually trying to avoid the use of vmalloc, instead of the 
unconditional conversion to vmalloc, which is what the original patch did ;-)

But you are, of course, correct - in this case, it should be easy to use 
the seq_file stuff to do it in smaller chunks, and use a smaller buffer.

M.

