Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVGYR4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVGYR4U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 13:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVGYR4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 13:56:20 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:12696 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261403AbVGYR4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 13:56:17 -0400
Subject: Re: xor as a lazy comparison
From: Steven Rostedt <rostedt@goodmis.org>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Grant Coady <lkml@dodo.com.au>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Puneet Vyas <vyas.puneet@gmail.com>
In-Reply-To: <1122281833.10780.32.camel@tara.firmix.at>
References: <Pine.LNX.4.61.0507241835360.18474@yvahk01.tjqt.qr>
	 <kis7e1d4khtde78oajl017900pmn9407u4@4ax.com>
	 <Pine.LNX.4.61.0507242342080.9022@yvahk01.tjqt.qr>
	 <42E4131D.6090605@gmail.com>  <1122281833.10780.32.camel@tara.firmix.at>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 25 Jul 2005 13:55:50 -0400
Message-Id: <1122314150.6019.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
 


