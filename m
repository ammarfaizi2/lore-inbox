Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289002AbSAIUPH>; Wed, 9 Jan 2002 15:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289020AbSAIUOs>; Wed, 9 Jan 2002 15:14:48 -0500
Received: from cygnus.equallogic.com ([65.170.102.10]:5394 "HELO
	cygnus.equallogic.com") by vger.kernel.org with SMTP
	id <S289002AbSAIUMY>; Wed, 9 Jan 2002 15:12:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15420.42020.88898.576943@pkoning.dev.equallogic.com>
Date: Wed, 9 Jan 2002 15:12:20 -0500 (EST)
From: Paul Koning <pkoning@equallogic.com>
To: mrs@windriver.com
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <200201091953.LAA27042@kankakee.wrs.com>
X-Mailer: VM 6.75 under 21.1 (patch 11) "Carlsbad Caverns" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "mike" == mike stump <mrs@windriver.com> writes:

 >> From: dewar@gnat.com To: dewar@gnat.com, mrs@windriver.com,
 >> paulus@samba.org Cc: gcc@gcc.gnu.org,
 >> linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
 >> velco@fadata.bg Date: Tue, 8 Jan 2002 21:13:43 -0500 (EST)

 >> Yes, of course! No one disagrees. I am talking about *LOADS* not
 >> stores, your example is 100% irrelevant to my point, since it does
 >> stores.

 mike> Ok, in the bodies of those, put in

 mike> j1=c1;

 mike> j2=c2;

 mike> j3=c3;

 mike> With new definitions for j1, j2 and k3 as being volatile.
 mike> Accesses are volatile:

 mike> [#2] Accessing a volatile object, modifying an object,
 mike> modifying a file, or calling a function that does any of those
 mike> operations are all side effects

 mike> So, I would claim that the case is symetric with writing
 mike> volatiles.  If the standard doesn't make a distinction for
 mike> write v read, then you can't and claim that distinction is
 mike> based in the standard.  If you claim the standard does make a
 mike> distinction, please point it out, I am unaware of it.

Ah... so (paraphrasing) -- if you have two byte size volatile objects,
and they happen to end up adjacent in memory, the compiler is
explicitly forbidden from turning an access to one of them into a
wider access -- because that would be an access to both of them, which
is a *different* side effect.  (Certainly that exactly matches the
hardware-centric view of why "volatile" exists.)  And the compiler
isn't allowed to change side effects, including causing them when the
source code didn't ask you to cause them.

So that says that you are indeed entitled to expect the compiler not
to enlarge volatile accesses, neither loads nor stores.  Or, if you
want to be *really* paranoid, you can at least enforce that by
"wrapping" the volatile object, if necessary, with two more volatile
objects that are +1 and -1 address unit away from the one you care
about.  And if the compiler then generates a larger reference, that's
a compiler bug.

Nice.

	paul

