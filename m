Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318079AbSHIAEj>; Thu, 8 Aug 2002 20:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318085AbSHIAEj>; Thu, 8 Aug 2002 20:04:39 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:33156 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S318079AbSHIAEi>; Thu, 8 Aug 2002 20:04:38 -0400
Date: Thu, 8 Aug 2002 12:42:27 -0500
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 64bit clean drivers was Re: Linux 2.4.20-pre1
Message-ID: <20020808174227.GE380@cadcamlab.org>
References: <20020808220317.A14531@wotan.suse.de> <Pine.LNX.4.44.0208082216150.28515-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208082216150.28515-100000@serv>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Andi Kleen]
> > dependency is met when the symbol is not defined.

Right.

[Roman Zippel]
> Boolean is simple, what about tristate symbols? How does it modify
> the input range?

!y == n
!m == n
!n == y

To me these are the only semantics that make any sense.  Certainly if
it goes in the kernel it needs to be added to config-language.txt.

(Note: these are only small changes, but thanks to word-wrapping...)

--- 2.4.20pre1/Documentation/kbuild/config-language.txt	2002-02-25 13:37:51.000000000 -0600
+++ 2.4.20pre1p/Documentation/kbuild/config-language.txt	2002-08-08 12:39:36.000000000 -0500
@@ -85,7 +85,9 @@
     making one massive dependency on include/linux/autoconf.h.
 
     A /dep/ is a dependency.  Syntactically, it is a /word/.  At run
-    time, a /dep/ must evaluate to "y", "m", "n", or "".
+    time, a /dep/ must evaluate to "y", "!y", "m", "!m", "n", "!n",
+    "", or "!".  The !-prefixed forms have a negated sense: "!y" and
+    "!m" are equivalent to "n"; "!n" and "!" are equivalent to "y".
 
     An /expr/ is a bash-like expression using the operators
     '=', '!=', '-a', '-o', and '!'.
@@ -439,12 +441,12 @@
 === dep_bool /prompt/ /symbol/ /dep/ ...
 
 This verb evaluates all of the dependencies in the dependency list.
-Any dependency which has a value of "y" does not restrict the input
-range.  Any dependency which has an empty value is ignored.
-Any dependency which has a value of "n", or which has some other value,
-(like "m") restricts the input range to "n".  Quoting dependencies is not
-allowed. Using dependencies with an empty value possible is not
-recommended.  See also dep_mbool below.
+Any dependency which has a value of "y", "!n" or "!" does not restrict
+the input range.  Any dependency which has an empty value is ignored.
+Any dependency which has a value of "n", or which has some other
+value (like "m"), restricts the input range to "n".  Quoting
+dependencies is not allowed. Using dependencies with an empty value
+possible is not recommended.  See also dep_mbool below.
 
 If the input range is restricted to the single choice "n", dep_bool
 silently assigns "n" to /symbol/.  If the input range has more than
@@ -469,11 +471,12 @@
 === dep_mbool /prompt/ /symbol/ /dep/ ...
 
 This verb evaluates all of the dependencies in the dependency list.
-Any dependency which has a value of "y" or "m" does not restrict the
-input range.  Any dependency which has an empty value is ignored.
-Any dependency which has a value of "n", or which has some other value,
-restricts the input range to "n".  Quoting dependencies is not allowed.
-Using dependencies with an empty value possible is not recommended.
+Any dependency which has a value of "y", "m", "!n" or "!" does not
+restrict the input range.  Any dependency which has an empty value is
+ignored.  Any dependency which has a value of "n", or which has some
+other value, restricts the input range to "n".  Quoting dependencies
+is not allowed.  Using dependencies with an empty value possible is
+not recommended.
 
 If the input range is restricted to the single choice "n", dep_bool
 silently assigns "n" to /symbol/.  If the input range has more than
@@ -514,12 +517,13 @@
 === dep_tristate /prompt/ /symbol/ /dep/ ...
 
 This verb evaluates all of the dependencies in the dependency list.
-Any dependency which has a value of "y" does not restrict the input range.
-Any dependency which has a value of "m" restricts the input range to
-"m" or "n".  Any dependency which has an empty value is ignored.
-Any dependency which has a value of "n", or which has some other value,
-restricts the input range to "n".  Quoting dependencies is not allowed.
-Using dependencies with an empty value possible is not recommended.
+Any dependency which has a value of "y", "!n" or "!" does not restrict
+the input range.  Any dependency which has a value of "m" restricts
+the input range to "m" or "n".  Any dependency which has an empty
+value is ignored.  Any dependency which has a value of "n", or which
+has some other value, restricts the input range to "n".  Quoting
+dependencies is not allowed.  Using dependencies with an empty value
+possible is not recommended.
 
 If the input range is restricted to the single choice "n", dep_tristate
 silently assigns "n" to /symbol/.  If the input range has more than
