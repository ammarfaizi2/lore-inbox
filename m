Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263600AbUFFN14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbUFFN14 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 09:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbUFFN14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 09:27:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48812 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263600AbUFFN1w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 09:27:52 -0400
Date: Sun, 6 Jun 2004 14:27:51 +0100
From: Matthew Wilcox <willy@debian.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: trond.myklebust@fys.uio.no, akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       willy@debian.org, linux-kernel@vger.kernel.org
Subject: Killing POSIX deadlock detection
Message-ID: <20040606132751.GZ5850@parcelfarce.linux.theplanet.co.uk>
References: <200406050725.i557P3hQ004052@supreme.pcug.org.au> <20040606130422.0c8946b3.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040606130422.0c8946b3.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2004 at 01:04:22PM +1000, Stephen Rothwell wrote:
> Here's my (contrived) example:
> 
> Process P1 contains threads T1 and T2
> Process P2
> 
> I am using "process id" and "thread id" in the POSIX sense.  These are
> exclusive, whole file locks for simplicity.
> 
> T1 locks file F1 -> lock (P1, F1)
> P2 locks file F2 -> lock (P2, F2)
> P2 locks file F1 -> blocks against (P1, F1)
> T1 locks file F2 -> blocks against (P2, F2)

Less contrived example -- T2 locks file F2.  We report deadlock here too,
even though T1 is about to unlock file F1.

I pointed this out over a year ago when NPTL first went in and nobody
seemed interested in having the discussion then.  All I got was a private
reply from Andi Kleen suggesting that we shouldn't remove it.

So, final call.  Any objections to never returning -EDEADLCK?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
