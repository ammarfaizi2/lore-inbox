Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUBMANi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 19:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266632AbUBMANi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 19:13:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34694 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266626AbUBMANf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 19:13:35 -0500
Date: Fri, 13 Feb 2004 00:13:33 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Michael Frank <mhf@linuxmail.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle
Message-ID: <20040213001333.GV21151@parcelfarce.linux.theplanet.co.uk>
References: <200402130615.10608.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402130615.10608.mhf@linuxmail.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 06:15:10AM +0800, Michael Frank wrote:
> +		Chapter : Macros
> +
> +Macros defining constants are capitalized.
> +
> +#define CONSTANT 0x12345
> +
> +CAPITALIZED macro names are appreciated but macros resembling functions
> +may be named in lower case.
> +
> +Macros with multiple statements should be enclosed in a do - while block.
> +
> +#define macrofun(a,b,c) 		\
> +do {					\
> +	if (a == 5)			\
> +		do_this(b,c);		\
> +					\
> +} while (0)
> +
> +Macros defining expressions must enclose the expression in parenthesis
> +to reduce sideeffects.
> +
> +#define CONSTEXP (CONSTANT | 3)
> +#define MACWEXP(a,b) ((a) + (b))

Generally, enum and inline functions are preferable to the above.

Things to avoid when doing macros:

	1) macros that affect control flow:

#define FOO(x) do {if (blah(x) < 0) return -EBUGGERED;} while(0)

is _not_ a good idea.  It looks like a function call; don't break the internal
parsers of those who will read the code.

	2) macros that depend on having a local variable with magic name:

#define FOO(val) bar(index, val)

might look like a good thing, but it's confusing as hell when one reads the
code and it's prone to breakage from seemingly innocent changes.

	3) macros with arguments that are used as l-values: FOO(x) = y; will
bite you if somebody e.g. turns FOO into inlined function.


