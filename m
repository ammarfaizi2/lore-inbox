Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270969AbTHKEbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 00:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270976AbTHKEbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 00:31:24 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:29573 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270969AbTHKEbU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 00:31:20 -0400
Date: Mon, 11 Aug 2003 05:30:56 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Chip Salzenberg <chip@pobox.com>
Cc: Willy Tarreau <willy@w.ods.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
Message-ID: <20030811043056.GG10446@mail.jlokier.co.uk>
References: <1060488233.780.65.camel@cube> <20030810072945.GA14038@alpha.home.local> <20030811012337.GI24349@perlsupport.com> <20030811020957.GE10446@mail.jlokier.co.uk> <20030811023912.GJ24349@perlsupport.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811023912.GJ24349@perlsupport.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chip Salzenberg wrote:
> > It's portable as long as the compiler is GCC :)
> No; wrong; please pay attention.

I was being facetious :)

> Both parameters of __builtin_expect() are long ints.

So it is broken if passed a "long long"?  The documentation says "you
are limited to integral expressions".

...You're right.  The documentation is wrong.  It's strictly takes
"long int" arguments and returns a long.

> On an architecture where there's a pointer type larger than long[1],
> __builtin_expect() won't just warn, it'll *fail*.

A pointer really should fail on all architectures.
Fortunately you do get a warning.

> Also, on an architecture where a conversion of a null pointer to
> long results in a non-zero value[2], it'll *fail*.  That makes it
> non-portable twice over.  Wouldn't you agree?

[2] - I don't believe such architectures are supported by GCC, hence
the facetious comment.

>    Since you are limited to integral expressions for exp, you should use constructions such as
> 
>         if (__builtin_expect (ptr != NULL, 1))
>           error ();
> 
>    when testing pointer or floating-point values.

I think we all agree with this.

-- Jamie
