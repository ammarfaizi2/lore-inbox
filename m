Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132881AbRDYWOM>; Wed, 25 Apr 2001 18:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132886AbRDYWOA>; Wed, 25 Apr 2001 18:14:00 -0400
Received: from theseus.mathematik.uni-ulm.de ([134.60.166.2]:41920 "HELO
	theseus.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S132881AbRDYWNt>; Wed, 25 Apr 2001 18:13:49 -0400
Message-ID: <20010425221347.532.qmail@theseus.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Thu, 26 Apr 2001 00:13:47 +0200
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com
Subject: Re: Long standing bug in alternate stack handling
In-Reply-To: <20010221220217.29816.qmail@theseus.mathematik.uni-ulm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010221220217.29816.qmail@theseus.mathematik.uni-ulm.de>; from ehrhardt@mathematik.uni-ulm.de on Wed, Feb 21, 2001 at 11:02:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2001 at 11:02:17PM +0100, Christian Ehrhardt wrote:

Hi,

[ Sorry for the follow up on my own post ]

> If a signal handler is registered with the SA_ONSTACK flag the
> kernel will try to execute the signal handler on the alternate
> stack even if no such stack is registered.

Here's a simple patch for i386. Please consider it for inclusion.
Posix explicitly requires the behaviour implemented by this patch.


--- arch/i386/kernel/signal.c.old	Mon Sep 25 22:10:28 2000
+++ arch/i386/kernel/signal.c	Sun Apr 22 16:04:47 2001
@@ -371,7 +371,7 @@
 
 	/* This is the X/Open sanctioned signal stack switching.  */
 	if (ka->sa.sa_flags & SA_ONSTACK) {
-		if (! on_sig_stack(esp))
+		if (sas_ss_flags(esp) == 0)
 			esp = current->sas_ss_sp + current->sas_ss_size;
 	}
 
NOTE: As far as I can tell all archs are affected by this bug.

   best regards   Christian Ehrhardt

-- 
THAT'S ALL FOLKS!
