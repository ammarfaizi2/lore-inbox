Return-Path: <linux-kernel-owner+w=401wt.eu-S1755289AbXABUMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289AbXABUMe (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 15:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755281AbXABUMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 15:12:34 -0500
Received: from gate.crashing.org ([63.228.1.57]:39861 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755298AbXABUMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 15:12:33 -0500
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, devel@laptop.org,
       David Miller <davem@davemloft.net>, David Kahn <dmk@flex.com>,
       Mitch Bradley <wmb@firmworks.com>, jg@laptop.org
In-Reply-To: <24a109a8fa0f45011daf3e2b55172392@kernel.crashing.org>
References: <459714A6.4000406@firmworks.com>
	 <20061230.211941.74748799.davem@davemloft.net>
	 <459784AD.1010308@firmworks.com>
	 <1167709992.6165.18.camel@localhost.localdomain>
	 <24a109a8fa0f45011daf3e2b55172392@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 03 Jan 2007 07:12:15 +1100
Message-Id: <1167768735.6165.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-02 at 13:22 +0100, Segher Boessenkool wrote:
> > Except that none of the powerpc platforms can keep OF alive after the
> > kernel has booted, which is why we do an in-memory copy of the tree.
> 
> Adding that functionality hasn't gotten easier at all since
> we use the flattened tree for everything, heh.

Not for everything, only for the trampoline between the client interface
environment and the kernel. But yeah, we haven't tried hard to go in
that direction at all.

.../...

> Not single thread -- but a "global OF lock" yes.  Not that
> it matters too much, (almost) all property accesses are init
> time anyway (which is effectively single threaded).

Not that true anymore. A lot of driver probe is being threaded nowadays,
either bcs of the new multithread probing bits, or because they get
loaded by userland from some initramfs etc..

> > Finally, you can't have something as simple as powerpc's get_property()
> > (that just returns a pointer to the property content) with direct OF
> > access unless you use some magic static buffer or some crap around 
> > those
> > lines, or add passing of a buffer in, so from a driver pointer of view,
> > the interface provided by powerpc/sparc is nicer.
> 
> But since you have a _put() function anyway, for your reference
> counting, having magic (automatically allocated, not static of
> course) buffers works just fine.

You can maybe create an in-memory cache of all properties in a node from
whatever function that returns a node pointer and dispose of them on
_put(), that would allow to keep the get_property semantics as-is with a
"live" tree, but I still don't see the point

Ben.


