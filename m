Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVGYSAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVGYSAq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 14:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVGYSAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 14:00:46 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:15840 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261413AbVGYSAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 14:00:43 -0400
Subject: [PATCH] make signal.c more readable (was: Re: xor as a lazy
	comparison)
From: Steven Rostedt <rostedt@goodmis.org>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: Linus Torvalds <torvalds@osdl.org>, Puneet Vyas <vyas.puneet@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Grant Coady <lkml@dodo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1122281833.10780.32.camel@tara.firmix.at>
References: <Pine.LNX.4.61.0507241835360.18474@yvahk01.tjqt.qr>
	 <kis7e1d4khtde78oajl017900pmn9407u4@4ax.com>
	 <Pine.LNX.4.61.0507242342080.9022@yvahk01.tjqt.qr>
	 <42E4131D.6090605@gmail.com>  <1122281833.10780.32.camel@tara.firmix.at>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 25 Jul 2005 14:00:05 -0400
Message-Id: <1122314405.6019.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the double post. I added [PATCH] and changed the subject, and added Linus.

On Mon, 2005-07-25 at 10:57 +0200, Bernd Petrovitsch wrote:
> On Sun, 2005-07-24 at 18:15 -0400, Puneet Vyas wrote:
> [...]
> > I just compiled two identical program , one with "!=" and other with 
> > "^". The assembly output is identical.
> 
> Hmm, which compiler and which version?
> You might want to try much older and other compilers.
> 

Doesn't matter. The cycles saved for old compilers is not rational to
have obfuscated code.

Here's the patch to make the code more readable.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

--- linux-2.6.13-rc3/kernel/signal.c.orig	2005-07-25 13:50:20.000000000 -0400
+++ linux-2.6.13-rc3/kernel/signal.c	2005-07-25 13:50:51.000000000 -0400
@@ -665,8 +665,8 @@ static int check_kill_permission(int sig
 			(unsigned long)info != 2 && SI_FROMUSER(info)))
 	    && ((sig != SIGCONT) ||
 		(current->signal->session != t->signal->session))
-	    && (current->euid ^ t->suid) && (current->euid ^ t->uid)
-	    && (current->uid ^ t->suid) && (current->uid ^ t->uid)
+	    && (current->euid != t->suid) && (current->euid != t->uid)
+	    && (current->uid != t->suid) && (current->uid != t->uid)
 	    && !capable(CAP_KILL))
 		return error;
 


