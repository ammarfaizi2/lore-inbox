Return-Path: <linux-kernel-owner+w=401wt.eu-S965259AbXAHACD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965259AbXAHACD (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 19:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965260AbXAHACD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 19:02:03 -0500
Received: from web55609.mail.re4.yahoo.com ([206.190.58.233]:31582 "HELO
	web55609.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965259AbXAHACB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 19:02:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=noFM2uBk0Bc5pfwYOrz5j86srDtOMnPPWfPP7hddTro7TJ4DAzAjG/1TvwXdC4nZTbshixGQv6gNiajsU0sWpCUBW48MhwC/EHV2fp6oWSP86iRiewmRCKFvzwAbg3qXUERG9YeKSOrDaNi2/v6lQd7XgQYwcCXummfjlBZ5ZKw=;
X-YMail-OSG: AXo83p4VM1k_eBG_ePsJYqKw91aBCOo78Tjt1JuX4Wg92Ad64sPW_cL.jYjwmZvZuIde.pl4aQH05l59f4586RUeoYXVD.WkEUYJ2gAV3.rTH0NP5U4.O5TCIR3eaDJSqlgWG1Q91vAl8bo-
Date: Sun, 7 Jan 2007 16:02:00 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1168212133.2744.17.camel@dsl081-166-245.sea1.dsl.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <261558.33282.qm@web55609.mail.re4.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Vadim Lobanov <vlobanov@speakeasy.net> wrote:

> On Sun, 2007-01-07 at 14:43 -0800, Amit Choudhary wrote:
> > Any strong reason why not? x has some value that does not make sense and can create only
> problems.
> > And as I explained, it can result in longer code too. So, why keep this value around. Why not
> > re-initialize it to NULL.
> 
> Because it looks really STRANGE(tm). Consider the following function,
> which is essentially what you're proposing in macro-ized form:
> 	void foobar(void)
> 	{
> 		void *ptr;
> 
> 		ptr = kmalloc(...);
> 		// actual work here
> 		kfree(ptr);
> 		ptr = NULL;
> 	}

That's where KFREE(ptr) comes in so that the code doesn't look ugly and still the purpose is
achieved.

"I still do not know of a single good reason as to why we should not do this."

And if all programmers did the right thing always then why do we have all the debugging options in
the first place.

> Reading code like that makes me say "wtf?", simply because 'ptr' is not
> used thereafter,

Really? Then why do we have all the debugging options to catch re-use of the memory that has been
freed. So many debugging options has been implemented, so much effort has gone into them, partly
because programmers sometimes miss correct programming.

> so setting it to NULL is both pointless and confusing
> (it looks out-of-place, and therefore makes me wonder if there's
> something stupidly tricky going on).
> 
> Also, arguably, your demonstration of why the lack of the proposed
> KFREE() macro results in longer code is invalid. Whereas you wrote:
> 	pointer *arr_x[size_x];
> 	pointer *arr_y[size_y];
> 	pointer *arr_z[size_z];
> That really should have been:
> 	pointer *arr[size_x + size_y + size_z];
> or:
> 	pointer **arr[3] = { arr_x, arr_y, arr_z };
> In which case, the you only need one path in the function to handle
> allocation failures, rather than the three that you were arguing for.
> 

I do not know what you are talking about here. You are saying that a function does not need three
different arrays with different names. How can you say that? How do you know what is the
requirement?

-Amit


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
