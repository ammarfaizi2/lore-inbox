Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313661AbSDURlr>; Sun, 21 Apr 2002 13:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313666AbSDURlq>; Sun, 21 Apr 2002 13:41:46 -0400
Received: from mailc.telia.com ([194.22.190.4]:46804 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S313661AbSDURli>;
	Sun, 21 Apr 2002 13:41:38 -0400
To: morten.helgesen@nextframe.net
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: [patch] ide updates
In-Reply-To: <20020419180851.C334@sexything>
	<Pine.LNX.4.33.0204191238080.19090-100000@coffee.psychology.mcmaster.ca>
	<20020419193914.D334@sexything>
From: Peter Osterlund <petero2@telia.com>
Date: 21 Apr 2002 19:41:34 +0200
Message-ID: <m2k7r1t0dt.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Morten Helgesen <morten.helgesen@nextframe.net> writes:

> On Fri, Apr 19, 2002 at 12:39:24PM -0400, Mark Hahn wrote:
> > > guys with other WD drives, in particular :) You can use the
> > > attached perl script, sent to me by Jens, to check you drives.
> > 
> > did the script give valid results?  (I wrote it...)
> 
> sure - seems to work like a charm :)

There appears to be an off by one bug in the test that decides whether
to mail the results. The results are mailed if there are != 1 drives
found, instead of the supposedly intended != 0 test.

Here is a patch to fix it:

--- test-tcq.pl.old	Sun Apr 21 19:35:22 2002
+++ test-tcq.pl	Sun Apr 21 19:34:57 2002
@@ -22,7 +22,7 @@
         }
 }
 
-if ($addr && $#goodies) {
+if ($addr && scalar(@goodies)) {
         open(M, "| mail -s TCQ-report $addr");
         print M @goodies;
         close(M);

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
