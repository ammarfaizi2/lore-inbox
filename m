Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267725AbUIWQbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267725AbUIWQbk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 12:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUIWQbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 12:31:33 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:41679 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267650AbUIWQbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:31:06 -0400
Subject: __attribute__((always_inline)) fiasco
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: rth@twiddle.net
Content-Type: text/plain
Organization: 
Message-Id: <1095956778.4966.940.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Sep 2004 12:26:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm displeased with someone's workaround for decisions made by
> the (rather weak) inliner in gcc 3.[123].  In particular, that
> someone doesn't understand all of the implications of always_inline.
...
> In the Alpha port I have a number of places in which I have 
> functions that I would like inlined when they are called directly,
> but I also need to take their address so that they may be registered
> as part of a dispatch vector for the specific machine model.
>
> This scheme fails because my functions got marked always_inline
> behind my back, which means they didn't get emitted in the right
> place.

If it hurts, don't do that. It looks like bloat anyway.

Are benchmarks significantly affected if you remove the inline?
If so, simply have a second function:

extern void uninline_foo(void);
...
void uninline_foo(void)
{
        foo();
}

> Rather than fight the unwinnable fight to remove this hack entirely,
> may I ask that at least one of the different names for inline, e.g.
> __inline__, be left un-touched so that it can be used by those that
> understand what the keyword is supposed to mean?
>
> Of course, there does not exist a variant that isn't used by all
> sorts of random code, so presumably all existing occurences would
> have to get renamed to plan "inline" in order to keep people happy..

Hey, I argued for INLINE when the static/extern changes
came along. That's the sanest, because one never knows
what the next annoying compiler will demand. Then you
can have one of:

#define INLINE
#define INLINE inline
#define INLINE static inline  // an oxymoron
#define INLINE extern inline  // an oxymoron
#define INLINE __force_inline
#define INLINE __attribute__((always_inline))
#define INLINE _Pragma("inline")
#define INLINE __inline_or_die_you_foul_compiler
#define INLINE _Please inline


