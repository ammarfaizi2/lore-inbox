Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270928AbTHKCj6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 22:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270930AbTHKCj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 22:39:57 -0400
Received: from tandu.perlsupport.com ([66.220.6.226]:54657 "EHLO
	tandu.perlsupport.com") by vger.kernel.org with ESMTP
	id S270928AbTHKCjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 22:39:47 -0400
Date: Sun, 10 Aug 2003 22:39:12 -0400
From: Chip Salzenberg <chip@pobox.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Willy Tarreau <willy@w.ods.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
Message-ID: <20030811023912.GJ24349@perlsupport.com>
References: <1060488233.780.65.camel@cube> <20030810072945.GA14038@alpha.home.local> <20030811012337.GI24349@perlsupport.com> <20030811020957.GE10446@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811020957.GE10446@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Jamie Lokier:
> Chip Salzenberg wrote:
> > According to Willy Tarreau:
> > >   likely => __builtin_expect(!(x), 0)
> > > unlikely => __builtin_expect((x), 0)
> > 
> > Well, I'm not sure about the polarity, but that unlikely() macro isn't
> > good -- it the same old problem that first prompted my message, namely
> > that it's nonportable when (x) has a pointer type.
> 
> It's portable as long as the compiler is GCC :)

No; wrong; please pay attention.

Both parameters of __builtin_expect() are long ints.  On an
architecture where there's a pointer type larger than long[1],
__builtin_expect() won't just warn, it'll *fail*.  Also, on an
architecture where a conversion of a null pointer to long results in
a non-zero value[2], it'll *fail*.  That makes it non-portable twice
over.  Wouldn't you agree?

Allow me to quote gcc's documentation:

   Since you are limited to integral expressions for exp, you should use constructions such as

        if (__builtin_expect (ptr != NULL, 1))
          error ();

   when testing pointer or floating-point values.

Could you please believe the docs?

[1] Yes, they exit.
[2] I don't know if they exist, but they're allowed by ANSI C.
-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
