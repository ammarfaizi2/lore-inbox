Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266067AbUGJBnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266067AbUGJBnV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 21:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266072AbUGJBnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 21:43:21 -0400
Received: from lakermmtao03.cox.net ([68.230.240.36]:21639 "EHLO
	lakermmtao03.cox.net") by vger.kernel.org with ESMTP
	id S266067AbUGJBnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 21:43:19 -0400
In-Reply-To: <20040709164919.6b6a077d.pj@sgi.com>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org> <m1fz80c406.fsf@ebiederm.dsl.xmission.com> <20040709164919.6b6a077d.pj@sgi.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <849F7707-D212-11D8-8B07-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: ebiederm@xmission.com (Eric W. Biederman), chrisw@osdl.org,
       sds@epoch.ncsc.mil, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       herbert@gondor.apana.org.au, mika@osdl.org, akpm@osdl.org,
       jmorris@redhat.com
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Date: Fri, 9 Jul 2004 21:43:18 -0400
To: Paul Jackson <pj@sgi.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 09, 2004, at 19:49, Paul Jackson wrote:
> I suspect not.  Up to Linus.  This is all about writing code that
> doesn't bite.
>
> Since mostly it's us humans doing the writing, this is more a human
> engineering problem than a pure mathematics problem such as Dijkstra
> or Wirth were closer to addressing.
>
> Let someone with demonstrated good taste dictate the style choices
> that lead to short, sweat, but seldom screwy code.
>
> It's all arbitrary as hell.  The proof is in the pudding.

The place this probably matters most is in various function calls. For
example, given the following prototype, (and ignoring the fact that
gcc is generally able to properly compile all of these), which is the
most clear?  These are all "logically" correct, for the most part, but
as humans we have certain readability standards.

int some_function(int a, void *b, char *c, unsigned char d, int e);

A)	int res = some_function(0,0,0,0,0);
B)	int res = some_function(NULL,NULL,NULL,NULL,NULL);
C)	int res = some_function(0,NULL,NULL,'\0',0);

C is the most expressive of the intent of the code, and the least
likely to contain bugs.

Cheers,
Kyle Moffett

