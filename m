Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTKQRAq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 12:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbTKQRAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 12:00:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:59019 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263583AbTKQRAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 12:00:41 -0500
Date: Mon, 17 Nov 2003 08:55:29 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Will Dyson <will_dyson@pobox.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add lib/parser.c kernel-doc
Message-Id: <20031117085529.427bbb0b.rddunlap@osdl.org>
In-Reply-To: <1069061369.1139.83.camel@thalience>
References: <1068970562.19499.11.camel@thalience>
	<1069022225.19499.59.camel@thalience>
	<20031117072822.GO26866@lug-owl.de>
	<1069061369.1139.83.camel@thalience>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003 04:29:29 -0500 Will Dyson <will_dyson@pobox.com> wrote:

| On Mon, 2003-11-17 at 02:28, Jan-Benedict Glaw wrote:
| > On Sun, 2003-11-16 17:37:05 -0500, Will Dyson <will_dyson@pobox.com>
| > wrote in message <1069022225.19499.59.camel@thalience>:
| > > On Sun, 2003-11-16 at 03:16, Will Dyson wrote:
| > 
| > > -int match_token(char *s, match_table_t table, substring_t args[]);
| > > -
| > > +int match_token(char *, match_table_t table, substring_t args[]);
| > 
| > Dropping the blank line is okay, but I don't like dropping "s"
| > altogether:)

First, thanks for doing this since I never got around to it.

I like having the arg names in function prototypes, but they don't
have to be terribly descriptive IMO.  Read the kernel-doc for
descriptions...
Consequently I don't find the arg-rename patch needed.

BTW, where did you find good references for creating kernel-doc?

...

| Got any ideas about how to name that argument in a way that is more
| helpful to a developer looking to use the functions? I was thinking 
| "char *token" for match_token (because you must tokenize the argument
| string before feeding each token to match_token) and "substring_t arg"
| for the others.
| 
| Here is a(nother) rediff of the kernel-doc patch, changing no prototypes
| at all. And also a follow-on that renames the arguments in the manner I
| describe in the previous paragraph. Feel free to provide an alternate
| renaming patch if you've got a better idea than "token" and "arg".

Evolution mangles in-line patches??  That's too bad.
Attachments are more difficult to review/reply to.

+++ b/include/linux/parser.h	Mon Nov 17 04:02:55 2003
@@ -1,3 +1,14 @@
+/*
+ * linux/include/linux/parser.h
+ *
+ * Header for lib/parser.c

Don't need that last line.  Kernel headers don't normally say things
like that, and it's #included by callers to parser as well as parser
itself.  I.e., it's not only for lib/parser.c.


+++ b/lib/parser.c	Mon Nov 17 04:02:55 2003

for match_token:

+ * Description: Detects which if any of a set of token strings has been passed
+ * to it. Tokens can include up to MAX_OPT_ARGS instances of basic c-style
+ * format identifiers which will be taken into account when matching the
+ * tokens, and whose locations will be returned in the @args array.

Use %MAX_OPT_ARGS consistently.
Don't need "c-style" at all IMO, or at least make it "C-style".


for match_strcpy:

+ * Description: Copies the set of characters represented by the given
+ * &substring_t @s to the c-style string @to. Caller guarantees that @to is
+ * large enough to hold the characters of @s.

s/c-style//


Thanks again.

--
~Randy
MOTD:  Always include version info.
