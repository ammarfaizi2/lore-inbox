Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317432AbSGIV50>; Tue, 9 Jul 2002 17:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317433AbSGIV5Z>; Tue, 9 Jul 2002 17:57:25 -0400
Received: from holomorphy.com ([66.224.33.161]:63628 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317432AbSGIV5Y>;
	Tue, 9 Jul 2002 17:57:24 -0400
Date: Tue, 9 Jul 2002 14:59:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@mvista.com>
Cc: Rick Lindsley <ricklind@us.ibm.com>, Greg KH <greg@kroah.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Message-ID: <20020709215905.GH25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@mvista.com>, Rick Lindsley <ricklind@us.ibm.com>,
	Greg KH <greg@kroah.com>, Dave Hansen <haveblue@us.ibm.com>,
	kernel-janitor-discuss <kernel-janitor-discuss@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20020709201703.GC27999@kroah.com> <200207092055.g69Ktt418608@eng4.beaverton.ibm.com> <20020709210053.GF25360@holomorphy.com> <1026249175.1033.1178.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <1026249175.1033.1178.camel@sinai>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 02:12:55PM -0700, Robert Love wrote:
> Summary is, I would love to do things like dismantle the BKLs odd-ball
> features... cleanly and safely.  Good luck ;)

This is even automatable. "Can doing this schedule me away?" and "Is
the BKL held here?" can be handled by machines just fine so long as the
answer to the latter is not "sometimes", and when it is, it can be auto-
identified and fixed up by hand. Given something that can parse a cscope
database and maybe do some transitive closure operations on subgraphs of
the call graph this should be doable in a few days on decent hardware.
There's also a nice advantage in it being harder to screw up than removal.

Callbacks can of course be handled by relaxing the condition to "may call"
and propagating values around, though that might be done better by
stealing a lint front end as opposed to a cscope database, especially for
taking advantage of type information. For instance, the callbacks will be
a component with a given name in a struct of a given type. So finding the
set of all functions assigned to that component of a variable having that
struct as its type should suffice to bang out the "may call" relation then.

All of the above actually applies to "call function F under lock L", so
the effort could be reused to, for instance, find sleep under spinlock
scenarios, or failures to hold L while calling F. Last, but not least,
it may well be the case that all the code has already been written, and
is waiting for someone to use it. There are some open-source static
checkers coming out it seems.

... if only it weren't such a PITA to write...

Cheers,
Bill
