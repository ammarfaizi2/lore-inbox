Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbTI3X6K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 19:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTI3X6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 19:58:10 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:17030 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261821AbTI3Xzr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 19:55:47 -0400
Date: Wed, 1 Oct 2003 00:55:28 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Dave Jones <davej@redhat.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20030930235528.GA32209@mail.shareable.org>
References: <20030930073814.GA26649@mail.jlokier.co.uk> <20030930132211.GA23333@redhat.com> <20030930133936.GA28876@mail.shareable.org> <20030930135324.GC5507@redhat.com> <20030930144526.GC28876@mail.shareable.org> <20030930150825.GD5507@redhat.com> <20030930165450.GF28876@mail.shareable.org> <20030930172618.GE5507@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930172618.GE5507@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> Which gets us back to the question of why this is needed at all ?
> You said earlier "In case you hadn't fully grokked it, my code doesn't
> disable the workaround!"  So why do you need this ?

To change the prefetch workaround from a critical requirement to an
optimisation knob.

X86_USE_3DNOW is very similar: if it's enabled, the kernel has some
extra code to make certain CPUs run faster, but they also run fine
without it.  X86_OOSTORE is another.

What I'd really like your opinion on is the appropriate userspace
behaviour.  If we don't care about fixing up userspace, then
__ex_table is a much tidier workaround for the prefetch bug.  If we do
care about fixing up userspace, then do we need a policy decision that
says it's not acceptable to run on AMD without userspace fixups from
2.6.0 onwards - it must fixup userspace or refuse to run?

-- Jamie
