Return-Path: <linux-kernel-owner+w=401wt.eu-S932757AbWLaTpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757AbWLaTpG (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 14:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932759AbWLaTpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 14:45:05 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:62331 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932757AbWLaTpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 14:45:04 -0500
Date: Sun, 31 Dec 2006 21:45:01 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, trivial@kernel.org
Subject: Re: [PATCH] Documentation: Explain a second alternative for multi-line macros.
Message-ID: <20061231194501.GE3730@rhun.ibm.com>
References: <Pine.LNX.4.64.0612311430370.18269@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612311430370.18269@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2006 at 02:32:25PM -0500, Robert P. J. Day wrote:

>  Generally, inline functions are preferable to macros resembling
>  functions.

This should be stressed, IMHO. We have too many macros which have no
reason to live.

> -Macros with multiple statements should be enclosed in a do - while block:
> +There are two techniques for defining macros that contain multiple
> +statements.
> 
> -#define macrofun(a, b, c) 			\
> -	do {					\
> + (a) Enclose those statements in a do - while block:
> +
> +	#define macrofun(a, b, c) 		\
> +		do {				\
> +			if (a == 5)		\
> +				do_this(b, c);	\
> +		} while (0)
> +
> + (b) Use the gcc extension that a compound statement enclosed in
> +     parentheses represents an expression:
> +
> +	#define macrofun(a, b, c) ({		\
>  		if (a == 5)			\
>  			do_this(b, c);		\
> -	} while (0)
> +	})

When giving two alternatives, the reader will thank you if you explain
when each should be used. In this case, the second form should be used
when the macro needs to return a value (and you can't use an inline
function for whatever reason), whereas the first form should be used
at all other times.

Cheers,
Muli
