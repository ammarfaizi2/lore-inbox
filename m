Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317946AbSFSR1D>; Wed, 19 Jun 2002 13:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317947AbSFSR1C>; Wed, 19 Jun 2002 13:27:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24838 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317946AbSFSR1B>; Wed, 19 Jun 2002 13:27:01 -0400
Date: Wed, 19 Jun 2002 10:27:15 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Cort Dougan <cort@fsmlabs.com>, Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
In-Reply-To: <m1hejztprs.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.44.0206191018510.2053-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 19 Jun 2002, Eric W. Biederman wrote:
>
> 10-20 years or someone finds a good way to implement a single system
> image on linux clusters.  They are already into the 1000s of nodes,
> and dual processors per node category.  And as things continue they
> might even grow bigger.

Oh, clusters are a separate issue. I'm absolutely 100% conviced that you
don't want to have a "single kernel" for a cluster, you want to run
independent kernels with good communication infrastructure between them
(ie global filesystem, and try to make the networking look uniform).

Trying to have a single kernel for thousands of nodes is just crazy. Even
if the system were ccNuma and _could_ do it in theory.

The NuMA work can probably take single-kernel to maybe 64+ nodes, before
people just start turning stark raving mad. There's no way you'll have
single-kernel for thousands of CPU's, and still stay sane and claim any
reasonable performance under generic loads.

So don't confuse the issue with clusters like that. The "set_affinity()"
call simply doesn't have anything to do with them. If you want to move
processes between nodes on such a cluster, you'll probably need user-level
help, the kernel is unlikely to do it for you.

			Linus

