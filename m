Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136398AbREDO0i>; Fri, 4 May 2001 10:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136400AbREDO03>; Fri, 4 May 2001 10:26:29 -0400
Received: from juicer13.bigpond.com ([139.134.6.21]:40178 "EHLO
	mailin1.bigpond.com") by vger.kernel.org with ESMTP
	id <S136398AbREDO0P>; Fri, 4 May 2001 10:26:15 -0400
Message-Id: <m14vgas-001QLrC@mozart>
From: Rusty Russell <rusty@rustcorp.com.au>
To: l.s.r@web.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] strtok -> strsep (The Easy Cases) 
In-Reply-To: Your message of "Fri, 04 May 2001 13:07:56 +0200."
             <01050413055100.00907@golmepha> 
Date: Sat, 05 May 2001 00:30:05 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <01050413055100.00907@golmepha> you write:
> Am Freitag,  4. Mai 2001 02:57 schrieb Rusty Russell:
> > There are two cases where the substitution is problematic:
> 
> Yes, but...
> 
> The cases which my patch modifies are of a different kind:

The very first hunk of your patch is wrong.  I didn't check the
others.  Note that the declaration of switches is:

    char switches[len+1];

--- linux-2.4.4/arch/m68k/atari/config.c	Tue Nov 28 02:57:34 2000
+++ linux-2.4.4-rs/arch/m68k/atari/config.c	Tue May  1 17:03:46 2001
@@ -206,13 +206,15 @@
 
     /* parse the options */
-    for( p = strtok( switches, "," ); p; p = strtok( NULL, "," ) ) {
+    while( p = strsep( &switches, "," ) ) {
+	if (!*p)
+		continue;
 	ovsc_shift = 0;
 	if (strncmp( p, "ov_", 3 ) == 0) {
 	    p += 3;

Cheers,
Rusty.
--
Premature optmztion is rt of all evl. --DK
