Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSIAOsI>; Sun, 1 Sep 2002 10:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSIAOsH>; Sun, 1 Sep 2002 10:48:07 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:9186 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S317101AbSIAOsG>;
	Sun, 1 Sep 2002 10:48:06 -0400
Date: Sun, 1 Sep 2002 16:52:31 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200209011452.QAA17260@harpo.it.uu.se>
To: szepe@pinerecords.com
Subject: Re: [PATCH] warnkill trivia 2/2
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Sep 2002 14:39:03 +0200, Tomas Szepe wrote:
>I've been playing a bit with how gcc handles the const qualifiers
>and made an interesting discovery:
>
>Trying to compile
>
>typedef int *p_int;
>void a(const p_int t) { *t = 0; }
>void b(const p_int t) { t = (int *) 0; }
>void c(const int *t) { *t = 0; }
>void d(const int *t) { t = (int *) 0; }
>void e(int const *t) { *t = 0; }
>void f(int const *t) { t = (int *) 0; }
>
>will give 'assignment of read-only location' warnings for
>b(), c() and e(),

In b() t is a const value and you're trying to assign to it,
and in c() and e() t is a pointer-to-const and you're trying
to assign to *t. The compiler catches this. What's the problem?

>i.e. it's impossible to have a constant
>pointer to a non-constant value w/o using a qualified
>typedef.

void g(int * const t) { *t = 0; }

>W/o a typedef, gcc seems unable to tell the difference
>between 'const int *' and 'int const *' altogether.

There is no difference. Read the C spec, or Harbison&Steele
which has had an explanation of 'const' since their '87 2nd Ed.

/Mikael
