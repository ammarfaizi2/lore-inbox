Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261669AbSKIEcg>; Fri, 8 Nov 2002 23:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbSKIEcg>; Fri, 8 Nov 2002 23:32:36 -0500
Received: from holomorphy.com ([66.224.33.161]:31916 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261669AbSKIEcd>;
	Fri, 8 Nov 2002 23:32:33 -0500
Date: Fri, 8 Nov 2002 20:36:08 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       linux-ia64@linuxia64.org,
       Linux Kernel List <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
       mingo@elte.hu, torvalds@transmeta.com
Subject: Re: [Linux-ia64] reader-writer livelock problem
Message-ID: <20021109043608.GF23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	"Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
	linux-ia64@linuxia64.org,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	dhowells@redhat.com, mingo@elte.hu, torvalds@transmeta.com
References: <1036777105.13021.13.camel@ixodes.goop.org> <20021109041543.EBE8A2C29F@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021109041543.EBE8A2C29F@lists.samba.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1036777105.13021.13.camel@ixodes.goop.org> you write:
>> Even without interrupts that would be a bug.  It isn't ever safe to
>> attempt to retake a read lock if you already hold it, because you may
>> deadlock with a pending writer.  Fair multi-reader locks aren't
>> recursive locks.

On Sat, Nov 09, 2002 at 01:48:17PM +1100, Rusty Russell wrote:
> That's the point.  This is explicitly guaranteed with the current
> locks, and you are allowed to recurse on them.  The netfilter code
> explicitly uses this to retake the net brlock, since it gets called
> from different paths.
> Implement "read_lock_yield" or "wrlock_t" but don't break existing
> semantics until 2.7 *please*!

My only interest is doing this specifically for problematic cases,
e.g. the tasklist_lock. Other usages probably shouldn't be altered
during this release cycle unless they too prove problematic, in which
case their usages should be fixed by their maintainers as bugfixes.

Of course, I'm not happy to hear about this explicit recursion.


Bill
