Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133019AbRAQLKt>; Wed, 17 Jan 2001 06:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132796AbRAQLKj>; Wed, 17 Jan 2001 06:10:39 -0500
Received: from mail.zmailer.org ([194.252.70.162]:6156 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S133015AbRAQLK3>;
	Wed, 17 Jan 2001 06:10:29 -0500
Date: Wed, 17 Jan 2001 13:10:16 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Rajiv Majumdar <rmajumda@tcg-software.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: detecting bounced mails
Message-ID: <20010117131016.B25659@mea-ext.zmailer.org>
In-Reply-To: <652569D7.003CB690.00@gemini.tcg-software.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <652569D7.003CB690.00@gemini.tcg-software.com>; from rmajumda@tcg-software.com on Wed, Jan 17, 2001 at 04:33:08PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2001 at 04:33:08PM +0530, Rajiv Majumdar wrote:
> Sorry..the topic does not fit here. But wanted to know, how can we check
> validity of an email id "in advance" so that we can skip "bounce".

	There are theorethical ways using SMTP's VRFY command, however
	it has never been implemented at all systems, and modern
	environment of firewalls just simply doesn't allow it to work.

	The only thing you *can* verify is to look for the domain
	part in the address from the DNS.  At first query for MX
	record(s), and if *not* found any, then query for A record(s).
	If you encounter CNAME, do resolve it couple times towards
	MX or A.

	If you find neither MX, nor A, then the DOMAIN part is non-routable
	in the internet, but nothing can be said about the left side of
	the @-character (the LOCAL part).

	If you have a RFC-821 statemachine scanner to recognize the address
	syntax and accept only  LOCAL@DOMAIN form (not @GW1,@GW2:LOCL@DOM),
	plus do that MX/A lookup, you should pretty much be done.

	It will trap honest mistakes - usually.

	I have code to do this type of analysis at my ZMailer, works fine.

> Thanks!
> Rajiv

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
