Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133012AbREERIj>; Sat, 5 May 2001 13:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133018AbREERI3>; Sat, 5 May 2001 13:08:29 -0400
Received: from dsl081-246-098.sfo1.dsl.speakeasy.net ([64.81.246.98]:28937
	"EHLO are.twiddle.net") by vger.kernel.org with ESMTP
	id <S133012AbREERIS>; Sat, 5 May 2001 13:08:18 -0400
Date: Sat, 5 May 2001 10:06:35 -0700
From: Richard Henderson <rth@twiddle.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org, gcc-patches@gcc.gnu.org
Subject: __builtin_expect vs inlining
Message-ID: <20010505100635.A14004@twiddle.net>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org, gcc-patches@gcc.gnu.org
In-Reply-To: <20010503194747.A552@jurassic.park.msu.ru> <20010504141318.B11122@twiddle.net> <20010505181718.B2302@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010505181718.B2302@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Sat, May 05, 2001 at 06:17:18PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2001 at 06:17:18PM +0400, Ivan Kokshaysky wrote:
> > Eh?  Would you give me an example that isn't working properly?
> 
> Sure.

Fixed thus.

> So one of the questions: can one rely on current branch predictions
> algorithms (val < 0, val = 0 false etc.) in the long term?

Err, no.  We reserve the right to tweek the predictions, or to replace
them with different heuristics.  I'd hope they'd be _generally_ better
heuristics, though the effect on any one particular test might change.


r~


        * integrate.c (copy_insn_list): Substitute NOTE_EXPECTED_VALUE.

Index: integrate.c
===================================================================
RCS file: /cvs/gcc/gcc/gcc/integrate.c,v
retrieving revision 1.142
diff -c -p -r1.142 integrate.c
*** integrate.c	2001/05/03 16:14:34	1.142
--- integrate.c	2001/05/05 16:54:24
*************** copy_insn_list (insns, map, static_chain
*** 1536,1541 ****
--- 1536,1546 ----
  		  else
  		    NOTE_BLOCK (copy) = *mapped_block_p;
  		}
+ 	      else if (copy
+ 		       && NOTE_LINE_NUMBER (copy) == NOTE_INSN_EXPECTED_VALUE)
+ 		NOTE_EXPECTED_VALUE (copy)
+ 		  = copy_rtx_and_substitute (NOTE_EXPECTED_VALUE (insn),
+ 					     map, 0);
  	    }
  	  else
  	    copy = 0;
