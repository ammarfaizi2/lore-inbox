Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288697AbSAIBwh>; Tue, 8 Jan 2002 20:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288698AbSAIBw2>; Tue, 8 Jan 2002 20:52:28 -0500
Received: from unknown-1-11.wrs.com ([147.11.1.11]:22710 "EHLO mail.wrs.com")
	by vger.kernel.org with ESMTP id <S288697AbSAIBwI>;
	Tue, 8 Jan 2002 20:52:08 -0500
From: mike stump <mrs@windriver.com>
Date: Tue, 8 Jan 2002 17:51:18 -0800 (PST)
Message-Id: <200201090151.RAA04843@kankakee.wrs.com>
To: dewar@gnat.com, paulus@samba.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: dewar@gnat.com
> To: dewar@gnat.com, mrs@windriver.com, paulus@samba.org
> Date: Tue,  8 Jan 2002 19:51:35 -0500 (EST)

I noticed you failed to answer my question.  Why's that?  The answer
is, the standard is not a formal document.  If it were, you would be
able to point at the line that had the requirement that said it would
not scribble all over memory.  It is just that simple.

The intent is to not.  We (they people that write the standard) expect
you to just know.  Personally, I find it rather obvious.  I suspect
most all people do, at least for the scribbling case.

> OK, but where do you find this intent?

The C standard is set in a historical context, and in the context of
existing implementations, and existing expectations.  A setting with
experts that know what the intent is to some varying degree.  A
setting with an installed base of users, and an installed base of
code.  Using all that as a backdrop, some types of experts I think can
discern the intent fairly well.  Somethings are contentious.
Somethings are so trivially true that even a beginner could know
you're violating the intent.

Some things hinge on specific choices an implementor might make.  For,
for example, on UNIX, with separate compilation without the compilers
ability to talk across the boundary, on a byte addressable machine, if
we have three translation units:

unit 1:

volatile char c1;

void foo1() {
     c1 = 1;
}

unit 2:

volatile char c2;

void foo2() {
     c2 = 2;
}

unit 3:

volatile char c3;

void foo3() {
     c3 = 3;
}

and we load each one into our app, and place c1, c2 and c3 immediately
next to each other, and then run foo1, then foo2, then foo3, and then
check the side effects, c1, c2 and c3, I would claim we _must_ get
write 1 c1, write 2 c2, write 3 c3, and at the end, c1, c2 c3 should
be 1,2,3.  I find it obvious.

One cure, is a completely formal language.  Do you know of any real
languages that are?  By real, I mean a real language that is used to
code real programs and used in the real world.  I don't.

So yes, sometimes, from time to time, people might have to be told
what the intent is, if they don't get it.

In part, it is because gcc has adopted this model of independent
translation units, that makes it a hard requirement in the case above,
for the accesses to be byte based.  Because if it had not, gcc would
not be able to implement the intended required semantics of each of
the units.  The requirements of the standard forced this because of
the implementation choice.


Welcome to the world of programming.
