Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312928AbSDYF2f>; Thu, 25 Apr 2002 01:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312931AbSDYF2e>; Thu, 25 Apr 2002 01:28:34 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:65041 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S312928AbSDYF2d>;
	Thu, 25 Apr 2002 01:28:33 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200204250528.g3P5SHo462311@saturn.cs.uml.edu>
Subject: Re: [PATCH] gcc 3.1 breaks wchan
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 25 Apr 2002 01:28:17 -0400 (EDT)
Cc: anton@samba.org (Anton Blanchard), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204242158140.6714-100000@home.transmeta.com> from "Linus Torvalds" at Apr 24, 2002 09:59:38 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> On Thu, 25 Apr 2002, Anton Blanchard wrote:

>> I noticed on a ppc64 kernel compiled with gcc 3.1 that context_switch
>> was left out of line. It ended up outside of the
>> scheduling_functions_start_here/end_here placeholders which breaks
>> wchan.
>>
>> This is one place where we require the code to be inline, so we
>> should use extern.
>
> ABSOLUTELY NOT!
>
> "extern inline" does not guarantee inlining. It only guarantees that _if_
> the code isn't inlined, it also won't be compiled as a static function.
>
> Complain to the gcc guys, they've made up some not-backwards-compatible
> thing called "always_inline" or something, apparently without any way to
> know whether it is supported or not.

This is why anything but INLINE or _INLINE (chosen in a Makefile
or header) is broken. Every compiler wants something different
these days. So, as needed, we get one of:

#define INLINE inline /* sanity! */
#define INLINE extern inline /* an oxymoron */
#define INLINE static inline /* another oxymoron */
#define INLINE __forceinline
#define INLINE __attribute__((always_inline))
#define INLINE inline_me_harder
#define INLINE inline_this_or_I_shove_it_up_your_gnu

BTW, I said this during the "extern inline" to "static inline" conversion.

IMHO "extern inline" and "static inline" are oxymorons and, were it
not for the silly C99 standard, ought to produce error messsages.
They make as much sense as "extern static" does. The compiler's
inability to inline something ought to be an error as well. Oh well.


