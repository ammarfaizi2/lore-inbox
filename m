Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbTLVLZG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 06:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTLVLZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 06:25:06 -0500
Received: from mx2.elte.hu ([157.181.151.9]:21958 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264472AbTLVLZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 06:25:02 -0500
Date: Mon, 22 Dec 2003 12:25:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Gabor MICSKO <gmicsko@szintezis.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [test] exec-shield  vs. paxtest 0.9.5 horrible results
Message-ID: <20031222112558.GA10337@elte.hu>
References: <1072090466.1471.4.camel@gmicsko03>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072090466.1471.4.camel@gmicsko03>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gabor MICSKO <gmicsko@szintezis.hu> wrote:

> Any idea?

yes. Undo the patch below. The paxtest author decided to add this
pointless mprotect(stackptr, PROT_EXEC) to make sure the test lists
exec-shield as 'vulnerable' while listing PaX as non-vulnerable. I sent
the fix but (not surprisingly) it was not added. Marketing via testsuite
eh?

	Ingo

--- paxtest-0.9.4/body.c
+++ paxtest-0.9.5/body.c
@@ -29,6 +29,7 @@
 	fflush( stdout );
 
 	if( fork() == 0 ) {
+		do_mprotect((unsigned long)argv & ~4095U, 4096, PROT_READ|PROT_WRITE|PROT_EXEC);
 		doit();
 	} else {
 		wait( &status );
