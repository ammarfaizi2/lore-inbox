Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264336AbTEaOaK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 10:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbTEaOaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 10:30:10 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:37547 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264336AbTEaOaI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 10:30:08 -0400
Date: Sat, 31 May 2003 07:43:23 -0700
From: Larry McVoy <lm@bitmover.com>
To: Christoph Hellwig <hch@infradead.org>, Chris Heath <chris@heathens.co.nz>,
       linux-kernel@vger.kernel.org
Subject: coding style (was Re: [PATCH][2.5] UTF-8 support in console)
Message-ID: <20030531144323.GA22810@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Christoph Hellwig <hch@infradead.org>,
	Chris Heath <chris@heathens.co.nz>, linux-kernel@vger.kernel.org
References: <20030531095521.5576.CHRIS@heathens.co.nz> <20030531152133.A32144@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030531152133.A32144@infradead.org>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please linewrap after 80 chars.

Amen to that.

> +	if (!q) {
> 
> Kill the blank line above.
> 
> +		if (!q) return;
> 
> Two lines again.

A couple of comments: in the BK source tree, we've diverged from the Linux
coding style a bit (maybe a lot, Linus has read the source, ask him).

One thing is 

	unless (p) {
		....
	}
instead of 
	if (!p) {
		....
	}

It's just a
#define unless(x) if (!(x)) 
but it makes some code read quite a bit easier.  I'm a stickler for not using
2 lines where one will do, i.e.,

	FILE	*f;

	...
	unless (f = fopen(file, "r")) {
		error handling;
		return (-1);
	}

You hiccup the first time you see it, then you can read it, then you
start using it.  Yeah, I know, I'm using the value of an assignment in
a conditional, trust me, it works fine.

One other one is the 

	if (!q) return;

Chris said two lines, we don't do it that way.  The coding style we use is
a) one line is fine for a single statement.
b) in all other cases there are curly braces

	unless (q) return;	/* OK */
	unless (q) {		/* also OK */
		return;
	}
	unless (q)
		return;		/* not OK, no "}" */


The point of this style is twofold: save a line when the thing you are
doing is a singe statement, and make it easier for your eyes (or my 
tired old eyes) to run over the code.  If you see indentation you know
it is a block and there will be a closing } without exception.

It keeps the line counts about 10% smaller or so in our source base.
If you are looking for bragging rights about how big your stuff is that
might be bad but I like it because I can read more code in a window.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
