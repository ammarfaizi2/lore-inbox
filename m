Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264929AbSJVWO5>; Tue, 22 Oct 2002 18:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264935AbSJVWO5>; Tue, 22 Oct 2002 18:14:57 -0400
Received: from adsl-216-103-111-100.dsl.snfc21.pacbell.net ([216.103.111.100]:32132
	"EHLO www.piet.net") by vger.kernel.org with ESMTP
	id <S264929AbSJVWO4> convert rfc822-to-8bit; Tue, 22 Oct 2002 18:14:56 -0400
Subject: Re: [PATCH] 2.5.44: lkcd (9/9): dump driver and build files
From: Piet Delaney <piet@www.piet.net>
To: Keith Owens <kaos@sgi.com>
Cc: Christoph Hellwig <hch@sgi.com>, "Matt D. Robinson" <yakker@aparity.com>,
       linux-kernel@vger.kernel.org, steiner@sgi.com,
       jeremy@classic.engr.sgi.com
In-Reply-To: <8948.1035287855@ocs3.intra.ocs.com.au>
References: <8948.1035287855@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 15:21:02 -0700
Message-Id: <1035325262.6847.23.camel@www.piet.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 04:57, Keith Owens wrote:
> On Tue, 22 Oct 2002 14:47:45 -0400, 
> Christoph Hellwig <hch@sgi.com> wrote:
> >On Mon, Oct 21, 2002 at 03:06:59PM -0700, Piet Delaney wrote:
> >> > Using volatile is almost always a bug.  USe atomic variables
> >> > or bitops instead.
> >> 
> >> Yea, volatile is just being used to implement a simple atomic variable. 
> >
> >It just isn't guaranteed to be atomic.. Use atomic_t (for actual
> >values) or unsigned long + set_bit/test_bit/ænd friends for bitmasks.
> 
> atomic_t is problematic for debugging code which can be invoked by an
> error from any state.  On parisc, atomic_add is implemented using load
> and clear on a hash of the lock address, so it is possible to get
> collisions on locks when doing atomic ops from debugging code.
> Especially when the parisc code in 2.5.44 has exactly one hash table
> entry.  kdb has the same problem and tries to avoid atomic_t for the
> same reason, the current state is unreliable.
> 
> The dump_in_progress flag is set in one place and cleared in another.
> All the other uses of dump_in_progress are testing its state.  If
> atomic_t cannot be used safely, then it must be defined as volatile.

atomic_read(v) and atomic_set(v,i) seem to be safe for most platforms.

Looks like your right, for parisc even these functions are using a
spinlock. Is it really necessary for parisc to use spinlocks? Even
Solaris doesn't use spinlocks for atomic set and reads of atomic
variables.

-piet

-- 
piet@www.piet.net

