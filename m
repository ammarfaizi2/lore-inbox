Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbTFCDCn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 23:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264909AbTFCDCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 23:02:43 -0400
Received: from mail.casabyte.com ([209.63.254.226]:34061 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S264911AbTFCDB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 23:01:58 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "Larry McVoy" <lm@bitmover.com>, "Willy Tarreau" <willy@w.ods.org>
Cc: "Steven Cole" <elenstev@mesatop.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Question about style when converting from K&R to ANSI C.
Date: Mon, 2 Jun 2003 20:15:22 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGAEBLCOAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20030601140602.GA3641@work.bitmover.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My personal preference(s) are:

In C or naked scope of C++:

static inline
int function_name(type arg, type arg)
{
  body
}

By putting the scope modifiers and compiler directives on one line and the
calling conventions on another it makes a distinction between what the user
needs to know as opposed to the compiler.

In C++ classes:

class   				ClassName {
	static inline int		function_name(type arg, type arg) { return expression; }
	static inline int       function_name(type arg, type arg) {
						complex body;
					}
					ClassName();
	virtual		     ~ClassName();
};

(If the above doesn't look right because of email handling cruft) The names
of the class and members all line up vertically, the destructor is proceeded
by seven spaces and a tilde instead of a tab (so the destructor "stands out"
in a quick code scan) and the "static" and "inline" in this usage are
actually part of the type of the member function of a class in a way that
they are only hints in a naked scope, so they move down onto the line
itself.

There is no good "find it" trick if you don't do the below, but if you do
use the rest of "my personal standard" then doing "egrep ')$'" gets you all
of the function definitions with only the occasional split-line-conditional,
and since I also "&&" and "||" those at the end of the line I never have
that problem either...


(And not that anybody asked)

if (test) {
  code
} else {
  more code
}

while (test) {
  code
}

do {
  code
} while (test);

and so on...

and also (for the advanced reader):

if ((conditional) &&
    (conditional)) {
}

This one being "advanced" because it reads like a book but you have to "hold
in your head" were you are in the conditional more aggressively than the
prefixing version.

These preferences go back to when vi would delete lines if you scrolled down
through a file quickly using the arrow keys.  Even in the absence of that
particular annoyance (because we don't need a vi versus emacs holy war flare
up, they are both evil anyway, even if I do use vi constantly 8-), I have
never liked the floating brace styles like

  if (test)
  {
     code
  }


because the code still works and even looks right if you accidentally
damage/remove the if.  Just like "while (test);" on a line by itself is
transformed into a hang if the "do" ten pages up is removed.

  if ((conditional)
    &&(conditional))
  {
    code
  }

is subject to problems on line delete too.  Accidentally remove the "&&"
line and it is really easy to decide you made a parenthesis counting
mistake.  If the conditional is on the leading line then when you see

  if ((conditional) &&
  {
    code
  }

you instantly know something is amiss.

Fully correct, the dropped line would leave
  if ((conditional) &&
    code
  }

because the leading brace would have been eaten with the bad line too.
Neither positioning will protect you from dropping a middle term of three,
for obvious reasons.

AND MOST IMPORTANTLY:

while (test)
  one line of code;

AND

if (test)
  one line of code;

(etc) are fundamentally _*EVIL*_  (evil I say! do you hear me? EVIL!!!!! 8-)

Whatever the language designers might say, braces are not optional in
"morally correct" C or C++.

(I have maintained too much crappy code in my life, most of it written by
students, to think the other "standards" are anything but accidents waiting
to happen.  The only reason the floating-brace standard is taught in schools
is because it makes red-pen grading easier because of the blank page space.)


Rob.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Larry McVoy

static inline int cdrom_write_check_ireason(ide_drive_t *drive, int len, int
ireason)
{
}

vs

static inline int
cdrom_write_check_ireason(ide_drive_t *drive, int len, int ireason)
{
}

