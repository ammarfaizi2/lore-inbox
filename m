Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262695AbVG3NLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbVG3NLr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 09:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbVG3NLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 09:11:46 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:12977 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S262695AbVG3NLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 09:11:46 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH] swsusp: simpler calculation of number of pages in PBE list
Date: Sat, 30 Jul 2005 15:16:31 +0200
User-Agent: KMail/1.8.1
Cc: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
References: <Pine.LNX.4.44L0.0507292126390.16749-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0507292126390.16749-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507301516.32003.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 30 of July 2005 03:35, Alan Stern wrote:
> On Fri, 29 Jul 2005, Michal Schmidt wrote:
> 
> > Rafael J. Wysocki wrote:
> > > On Friday, 29 of July 2005 21:46, Michal Schmidt wrote:
> > > 
> > >>The function calc_nr uses an iterative algorithm to calculate the number 
> > >>of pages needed for the image and the pagedir. Exactly the same result 
> > >>can be obtained with a one-line expression.
> > > 
> > > 
> > > Could you please post the proof?
> > > 
> > > Rafael
> > 
> > OK, attached is a proof-by-brute-force program. It compares the results 
> > of the original function and the simplified one.
> 
> Here's a more general proof.
> 
> As I understand it, calc_nr is given nr_copy, the number of data pages
> that need to be written out, and it has to return the number of pages
> needed to hold the image data plus a bunch of PBE pagedir indexes, where
> each page gets one index (and pages containing PBEs need their own indexes
> as well).
> 
> For brevity, let n = nr_copy, let p = PBES_PER_PAGE, and let x be the 
> number of pagdir pages needed.  Since each page can hold p PBEs, there 
> will be room to store px PBEs.  The total number of pages is n + x, so 
> the routine needs to find the smallest value of x for which
> 
> 	px >= n + x
> 
> or
> 
> 	(p-1)x >= n
> 
> or
> 
> 	x >= n / (p-1).
> 
> The obvious solution is
> 
> 	x = ceiling(n / (p-1)),
> 
> so calc_nr should return n + ceiling(n / (p-1)), which is exactly what 
> Michal's patch computes.

Nice. :-)

Could we perhaps add your proof to the Michal's patch as a comment,
for reference?

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
