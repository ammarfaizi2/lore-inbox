Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267296AbUBNAj1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 19:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267301AbUBNAj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 19:39:27 -0500
Received: from smtp.everyone.net ([216.200.145.17]:57759 "EHLO
	rmta04.mta.everyone.net") by vger.kernel.org with ESMTP
	id S267296AbUBNAjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 19:39:24 -0500
Date: Fri, 13 Feb 2004 19:38:21 -0500
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Michael Frank <mhf@linuxmail.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle
Message-ID: <20040214003821.GA8183@arizona.localdomain>
References: <200402130615.10608.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402130615.10608.mhf@linuxmail.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 06:15:10AM +0800, Michael Frank wrote:
> +int fun(int )
> +{
> +	int result = 0;
> +	char *buffer = kmalloc(SIZE);
> +
> +	if (buffer == 0) {
> +		result = -1;
> +		goto out;
> +	}
> +
> +	if (condition1) {
> +		while (loop1) {
> +			...
> +		}
> +		result = 1;
> +		goto out;
> +	}
> +	if (condition2) {
> +		while (loop2) {
> +			...
> +		}
> +		result = 2;
> +		goto out;
> +	}
> +out:
> +	if (buffer)
> +		kfree(buffer);
> +	return result;
> +}

This is a bit of a nitpick, but if you're going to give a code example in a
file titled "Coding style" I'd recommend two changes:

1 - kfree already checks for null, so checking for null before calling
    kfree is pointless.

2 - I personally think testing pointers against an integer is bad style, so
    I'd prefer to see the original test changed to "if (!buffer)" or
    less-preferably "if (buffer == NULL)".

> +Macros with multiple statements should be enclosed in a do - while block.
> +
> +#define macrofun(a,b,c) 		\
> +do {					\
> +	if (a == 5)			\
> +		do_this(b,c);		\
> +					\
> +} while (0)

Enclosing macros in a do-while block is sound advice, but the above is an
example of something that should be an inline function.

-Kevin

-- 
 ---------------------------------------------------------------------
 | Kevin O'Connor                  "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net               'IMHO', 'FAQ', 'BTW', etc. !"    |
 ---------------------------------------------------------------------
