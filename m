Return-Path: <linux-kernel-owner+w=401wt.eu-S932768AbWLaTy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768AbWLaTy5 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 14:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932770AbWLaTy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 14:54:57 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:36378 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932768AbWLaTy5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 14:54:57 -0500
X-Originating-Ip: 74.109.98.100
Date: Sun, 31 Dec 2006 14:49:48 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Muli Ben-Yehuda <muli@il.ibm.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, trivial@kernel.org
Subject: Re: [PATCH] Documentation: Explain a second alternative for multi-line
 macros.
In-Reply-To: <20061231194501.GE3730@rhun.ibm.com>
Message-ID: <Pine.LNX.4.64.0612311447030.18368@localhost.localdomain>
References: <Pine.LNX.4.64.0612311430370.18269@localhost.localdomain>
 <20061231194501.GE3730@rhun.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2006, Muli Ben-Yehuda wrote:

> On Sun, Dec 31, 2006 at 02:32:25PM -0500, Robert P. J. Day wrote:
>
> >  Generally, inline functions are preferable to macros resembling
> >  functions.
>
> This should be stressed, IMHO. We have too many macros which have no
> reason to live.
>
> > -Macros with multiple statements should be enclosed in a do - while block:
> > +There are two techniques for defining macros that contain multiple
> > +statements.
> >
> > -#define macrofun(a, b, c) 			\
> > -	do {					\
> > + (a) Enclose those statements in a do - while block:
> > +
> > +	#define macrofun(a, b, c) 		\
> > +		do {				\
> > +			if (a == 5)		\
> > +				do_this(b, c);	\
> > +		} while (0)
> > +
> > + (b) Use the gcc extension that a compound statement enclosed in
> > +     parentheses represents an expression:
> > +
> > +	#define macrofun(a, b, c) ({		\
> >  		if (a == 5)			\
> >  			do_this(b, c);		\
> > -	} while (0)
> > +	})
>
> When giving two alternatives, the reader will thank you if you
> explain when each should be used. In this case, the second form
> should be used when the macro needs to return a value (and you can't
> use an inline function for whatever reason), whereas the first form
> should be used at all other times.

that's a fair point, although it's certainly not the coding style
that's in play now.  for example,

  #define setcc(cc) ({ \
    partial_status &= ~(SW_C0|SW_C1|SW_C2|SW_C3); \
    partial_status |= (cc) & (SW_C0|SW_C1|SW_C2|SW_C3); })

there would appear to be *lots* of cases where the ({ }) notation is
used when nothing is being returned.  i'm not sure you can be that
adamant about that distinction at this point.

rday
