Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264912AbTFCDQD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 23:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbTFCDQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 23:16:03 -0400
Received: from mail.casabyte.com ([209.63.254.226]:35341 "EHLO
	mail.1casabyte.com") by vger.kernel.org with ESMTP id S264912AbTFCDQB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 23:16:01 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "Steven Cole" <elenstev@mesatop.com>, "Larry McVoy" <lm@bitmover.com>
Cc: "Willy Tarreau" <willy@w.ods.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Question about style when converting from K&R to ANSI C.
Date: Mon, 2 Jun 2003 20:29:25 -0700
Message-ID: <PEEPIDHAKMCGHDBJLHKGAEBMCOAA.rwhite@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1054479734.19552.51.camel@spc>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Um... ich!  (ignoring the return type debate)

static unsigned long
insert_bba(unsigned long insn,
           long value,
           const char **errmsg)
{
   return insn | (((insn >> 16) & 0x1f) << 11);
}


...OR...

static unsigned long insert_bba(unsigned long insn,
                                long value,
                                const char **errmsg)
{
   return insn | (((insn >> 16) & 0x1f) << 11);
}


NEVER line up the return type and the argument type like the text below.  It
is mind-clobbering after a couple hundred pages.

Also, though it didn't come up, once you decide to put the arguments on
separate lines for readability never mix the styles in one function call.

int X(int A, int B,
      char **errormsg)
{
}

is "very bad".  the above "looks ok" in that one instance but it isn't.
Either I have to count the arguments, or there is one per line, but never
seven arguments on five lines (if you please) as that is evil!  (It is good
for driving instructors crazy too... 8-)


Also, in your automatics, it is never ok to write

   int A, *b;
or even
   int A, B;

One variable per line please.

  int A;
  int *b;

  (Especially if you are programming, or ever hope to program, tiny little
embedded systems where you really have to visualize your stack requirements.
8-)  The real reason is to facilitate and encourage automatic
initializations.  Particularly of classes in C++, but profoundly so in basic
C none the less.  Uninitialized variables should look bare and lonely, and
perhaps even a tad wrong.  (Not to mention having more than one alphabetic
character as a name, but I was being minimalist... 8-)

Rob.



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Steven Cole

/*ARGSUSED*/
-static unsigned long
-insert_bba (insn, value, errmsg)
-     unsigned long insn;
-     long value;
-     const char **errmsg;
+static unsigned long insert_bba(
+       unsigned long insn,
+       long value,
+       const char **errmsg
+)
{
   return insn | (((insn >> 16) & 0x1f) << 11);
}


