Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267970AbTBYP3l>; Tue, 25 Feb 2003 10:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267971AbTBYP3l>; Tue, 25 Feb 2003 10:29:41 -0500
Received: from ns.suse.de ([213.95.15.193]:38158 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267970AbTBYP3k>;
	Tue, 25 Feb 2003 10:29:40 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
X-Yow: ..  I see TOILET SEATS...
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 25 Feb 2003 16:39:53 +0100
In-Reply-To: <Pine.LNX.4.44.0302250712110.10210-100000@home.transmeta.com> (Linus
 Torvalds's message of "Tue, 25 Feb 2003 07:27:26 -0800 (PST)")
Message-ID: <jevfz84bee.fsf@sykes.suse.de>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.3.50
References: <Pine.LNX.4.44.0302250712110.10210-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

|> On Tue, 25 Feb 2003, Andreas Schwab wrote:
|> > |> 
|> > |> The point is that the compiler should see that the run-time value of i is 
|> > |> _obviously_never_negative_ and as such the warning is total and utter 
|> > |> crap.
|> > 
|> > This requires a complete analysis of the loop body, which means that the
|> > warning must be moved down from the front end (the common type of the
|> > operands only depends on the type of the operands, not of any current
|> > value of the expressions).
|> 
|> So? Gcc does that anyway. _Any_ good compiler has to.

But the point is that determining the common type does not require _any_
kind of data flow analysis, and this is the place where the unsigned
warning is generated.

|> Trivial example:
|> 
|> 	int x[2][2];
|> 
|> 	int main(int argc, char **argv)
|> 	{
|> 		return x[1][-1];
|> 	}
|> 
|> 
|> the above is actually a well-defined C program, and 100%
|> standards-conforming ("strictly conforming").

This isn't as trivial as it seems.  Look in comp.std.c for recent
discussions on this topic (out-of-array references).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
