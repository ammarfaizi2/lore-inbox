Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbUB1Oza (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 09:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbUB1Oza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 09:55:30 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:13968 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261860AbUB1OzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 09:55:23 -0500
Date: Sat, 28 Feb 2004 09:55:14 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
In-Reply-To: <20040228072926.GR8834@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Feb 2004, Andrea Arcangeli wrote:

> I agree, I thought about it too, but I didn't mention that since
> theoretically 4:4 has a chance to start with a stack at 3G and to depend
> on the userspace startup to relocate it at 4G ;). x86-64 does something
> like that to guarantee 100% compatibility.

Personalities work fine for that kind of thing.  The few buggy
apps that can't deal with addresses >3GB (IIRC the JVM in the
Oracle installer) get their stack at 3GB, the others get their
stack at 4GB.

> I think it's very fair to benchmark vsyscalls with 2.5:1.5 vs vsyscalls
> with 4:4.

The different setups should definately be benchmarked.  I know
we expected the 4:4 kernel to be slower at everything, but the
folks at Oracle actually ran into a few situations where the 4:4
kernel was _faster_ than a 3:1 kernel.

Definately not what we expected, but a nice surprise nontheless.

> Now that x86 is dying it probably don't worth to mark the binaries,

All you need to do for that is to copy some code from RHEL3 ;)

> I agree having the stack growsdown at 128 is the best for the db setup,

Alternatively, you start the mmap at "stack start - stack ulimit" and
grow it down from there. That still gives you 3.8GB of usable address
space on x86, with the 4:4 split. ;)

cheers,

Rik
-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

