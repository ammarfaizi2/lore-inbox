Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319080AbSH2DMd>; Wed, 28 Aug 2002 23:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319085AbSH2DMd>; Wed, 28 Aug 2002 23:12:33 -0400
Received: from dp.samba.org ([66.70.73.150]:26245 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319080AbSH2DMc>;
	Wed, 28 Aug 2002 23:12:32 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: junio@siamese.dyndns.org
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [TRIVIAL] strlen("literal string") -> (sizeof("literal string")-1) 
In-reply-to: Your message of "28 Aug 2002 17:49:51 MST."
             <7vd6s2lc9c.fsf@siamese.dyndns.org> 
Date: Thu, 29 Aug 2002 13:15:57 +1000
Message-Id: <20020828221716.1A73C2C09E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <7vd6s2lc9c.fsf@siamese.dyndns.org> you write:
> >>>>> "JT" == Jim Treadway <jim@stardot-tech.com> writes:
> 
> JT> Would redefining strlen() as __strlen() and then using
> 
> JT> #define strlen(x) (__builtin_constant_p(x) ? (sizeof(x) - 1) : __strlen(x
))
> 
> JT> work in this situation?
> 
> I thought about that before I posted the previous patch, but
> rejected it.
> 
> If it worked in all situations then it would have been great,
> but it fails in at least one way [*1*], so you cannot generally
> define the above in a header file which everybody includes.

If you really care about that, try:

	/* Be paranoid in case someone uses strlen(&("FOO"[0])) */
	#define strlen(x) \
		(__builtin_constant_p(x) && sizeof(x) != sizeof(char *)
		? (sizeof(x) - 1) : __strlen(x))

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
