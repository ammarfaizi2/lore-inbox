Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287111AbSAGVWM>; Mon, 7 Jan 2002 16:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287115AbSAGVWC>; Mon, 7 Jan 2002 16:22:02 -0500
Received: from THANK.THUNK.ORG ([216.175.175.163]:39138 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S287111AbSAGVVs>;
	Mon, 7 Jan 2002 16:21:48 -0500
Date: Mon, 7 Jan 2002 16:21:12 -0500
From: Theodore Tso <tytso@mit.edu>
To: mike stump <mrs@windriver.com>
Cc: gdr@codesourcery.com, paulus@samba.org, dewar@gnat.com, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020107162112.A31911@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	mike stump <mrs@windriver.com>, gdr@codesourcery.com,
	paulus@samba.org, dewar@gnat.com, gcc@gcc.gnu.org,
	linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
	velco@fadata.bg
In-Reply-To: <200201071936.LAA12038@kankakee.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <200201071936.LAA12038@kankakee.wrs.com>; from mrs@windriver.com on Mon, Jan 07, 2002 at 11:36:45AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 11:36:45AM -0800, mike stump wrote:
> #define hide(x) ({ void *vp = x; asm ("" : "+r" (vp)); vp; })
> 
> > My main problem with this is that it doesn't actually solve the
> > problem AFAICS.
> 
> It does for now.  It will for the next 10 years, my guess.  volatile
> will solve it longer, at some performance penalty, if you prefer.
> 
> > Dereferencing x is still undefined according to the rules in the gcc
> > manual.
> 
> ?  So what?  Pragmatically, for now, it does what the user wants.  By
> the time we break it, we'll probably have enough intelligence in the
> compiler to figure out what they were doing and still not break it.

Why not fix the problem by adding some a GCC-specific construct which
allows the programmer to say, I know what I'm doing; don't make any
assumptions about this pointer.  (i.e., "my gun, my foot, my rules").

I.e., something like this:

#hide(x)  (__builtin_gcc_this_is_not_the_pointer_you_were_looking_for__(x))

(or __builtin_gcc_jedi_mind_trick__, or pick some other name if you
like :-)

That way, you don't have to posit adding AI to GCC in the future to be
able to intuit what was going on, and programmers can take comfort in
the fact the behaviour is will defined, and won't get screwed up when
in GCC 4.0, the compiler writers decide that "Gee, most people write
inefficient assembly; so let's go and reverse engineering people's
__asm__ statements in an effort to 'optimize' their code".

						- Ted
