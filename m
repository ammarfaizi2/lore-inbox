Return-Path: <linux-kernel-owner+w=401wt.eu-S1755204AbXAAOU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204AbXAAOU0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 09:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755203AbXAAOU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 09:20:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57764 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204AbXAAOUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 09:20:25 -0500
Date: Mon, 1 Jan 2007 14:20:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Randy Dunlap <randy.dunlap@oracle.com>, trivial@kernel.org
Subject: Re: [PATCH] Documentation: Explain a second alternative for multi-line macros.
Message-ID: <20070101142020.GA16425@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>, trivial@kernel.org
References: <Pine.LNX.4.64.0612311430370.18269@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612311430370.18269@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2006 at 02:32:25PM -0500, Robert P. J. Day wrote:
> + (a) Enclose those statements in a do - while block:
> +
> +	#define macrofun(a, b, c) 		\
> +		do {				\
> +			if (a == 5)		\
> +				do_this(b, c);	\
> +		} while (0)

nitpick, please don't add an indentaion level for the do {.  Do this
should look like:

	#define macrofun(a, b, c) 	\
	do {				\
		if (a == 5)		\
			do_this(b, c);	\
	} while (0)


> + (b) Use the gcc extension that a compound statement enclosed in
> +     parentheses represents an expression:
> +
> +	#define macrofun(a, b, c) ({		\
>  		if (a == 5)			\
>  			do_this(b, c);		\
> -	} while (0)
> +	})

I'd rather document to not use this - it makes the code far less
redable.  And it's a non-standard extension, something we only
use if it provides us a benefit which it doesn't here.

