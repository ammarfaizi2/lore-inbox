Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267951AbTBYMaM>; Tue, 25 Feb 2003 07:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267954AbTBYMaM>; Tue, 25 Feb 2003 07:30:12 -0500
Received: from ns.suse.de ([213.95.15.193]:1287 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267951AbTBYMaL>;
	Tue, 25 Feb 2003 07:30:11 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
X-Yow: Are you still SEXUALLY ACTIVE?  Did you BRING th' REINFORCEMENTS?
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 25 Feb 2003 13:40:25 +0100
In-Reply-To: <Pine.LNX.4.44.0302241429150.13406-100000@penguin.transmeta.com> (Linus
 Torvalds's message of "Mon, 24 Feb 2003 14:39:36 -0800 (PST)")
Message-ID: <je7kbo5y9y.fsf@sykes.suse.de>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.3.50
References: <Pine.LNX.4.44.0302241429150.13406-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

|> On Mon, 24 Feb 2003, Andreas Schwab wrote:
|> > 
|> > But that's not the point.  It's the runtime value of i that gets converted
|> > (to unsigned), not the compile time value of COUNT.  Thus if i ever gets
|> > negative you have a problem.
|> 
|> The point is that the compiler should see that the run-time value of i is 
|> _obviously_never_negative_ and as such the warning is total and utter 
|> crap.

This requires a complete analysis of the loop body, which means that the
warning must be moved down from the front end (the common type of the
operands only depends on the type of the operands, not of any current
value of the expressions).

|> The compiler actually does end up doing some of that kind of analysis when
|> optimizing, since it is required for some of the loop optimizations 
|> anyway. But the warning is emitted before the analysis has taken place.
|> 
|> In other words, gcc is stupidly warning about something that is obviously 
|> not an error. And it is obviously not an error because:
|> 
|>  - array indexes are "int". They aren't size_t, and never have been. Thus 
|>    it is _correct_ to use "int" for the index. You write
|> 
|> 	int array[5];
|> 
|>    and you do NOT write
|> 
|> 	int array[5UL];
|> 
|>    and anybody who writes 'array[5UL]' is considered a stupid git and a 
|>    geek. Face it.

But array[-1] is wrong.  An array can never have a negative index (I'm
*not* talking about pointers).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
