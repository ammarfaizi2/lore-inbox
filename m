Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264437AbTCZATP>; Tue, 25 Mar 2003 19:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264449AbTCZATP>; Tue, 25 Mar 2003 19:19:15 -0500
Received: from pat.uio.no ([129.240.130.16]:34546 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S264437AbTCZATO>;
	Tue, 25 Mar 2003 19:19:14 -0500
To: Yedidyah Bar-David <didi@tau.ac.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: kernel BUG at highmem.c:169!
References: <20030325231418.GA8112@ibm-giga.math.tau.ac.il>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 26 Mar 2003 01:30:21 +0100
In-Reply-To: <20030325231418.GA8112@ibm-giga.math.tau.ac.il>
Message-ID: <shsu1dr55r6.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Yedidyah Bar-David <didi@tau.ac.il> writes:

     > Hi all, Today, a machine with vanilla 2.4.20 hung with this in
     > syslog:

     > kernel BUG at highmem.c:169!  invalid operand: 0000

Known problem (see the L-k archives). The following patch fixes it...

Cheers,
  Trond

--- linux-2.4.21-pre4/fs/nfs/symlink.c.orig	2002-08-14 05:59:37.000000000 -0700
+++ linux-2.4.21-pre4/fs/nfs/symlink.c	2003-02-25 20:42:39.000000000 -0800
@@ -46,7 +46,6 @@
 
 error:
 	SetPageError(page);
-	kunmap(page);
 	UnlockPage(page);
 	return -EIO;
 }
