Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289030AbSAIVoT>; Wed, 9 Jan 2002 16:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289032AbSAIVoG>; Wed, 9 Jan 2002 16:44:06 -0500
Received: from cygnus.equallogic.com ([65.170.102.10]:8452 "HELO
	cygnus.equallogic.com") by vger.kernel.org with SMTP
	id <S289030AbSAIVnh>; Wed, 9 Jan 2002 16:43:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15420.47491.912922.569746@pkoning.dev.equallogic.com>
Date: Wed, 9 Jan 2002 16:43:31 -0500 (EST)
From: Paul Koning <pkoning@equallogic.com>
To: dewar@gnat.com
Cc: mrs@windriver.com, gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <20020109203213.56A64F2FEB@nile.gnat.com>
X-Mailer: VM 6.75 under 21.1 (patch 11) "Carlsbad Caverns" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "dewar" == dewar  <dewar@gnat.com> writes:

> <<Ah... so (paraphrasing) -- if you have two byte size
> volatile objects, and they happen to end up adjacent in
> memory, the compiler is explicitly forbidden from turning an
> access to one of them into a wider access -- because that
> would be an access to both of them, which is a *different*
> side effect.  (Certainly that exactly matches the
> hardware-centric view of why "volatile" exists.)  And the
> compiler isn't allowed to change side effects, including
> causing them when the source code didn't ask you to cause
> them.

 dewar> Right, and as you see that is covered by the language on
 dewar> external effects in the Ada standard (remember the intent in
 dewar> Ada was to exactly match the C rules :-)

 dewar> But one thing in the Ada world that we consider left open is
 dewar> whether a compiler is free to combine two volatile loads into
 dewar> a single load. Probably the answer should be no, but the
 dewar> language at least in the Ada standard does not seem strong
 dewar> enough to say this.

Would ordering rules help answer that?  If you write two separate
loads you have two separate side effects that are ordered in time,
while for a single big load they occur concurrently.  If the construct
where those two loads occur does not allow for side effects to be
interleaved, then the "as if" principle seems to say you cannot
legally merge the loads.

	paul


