Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKWRu7>; Thu, 23 Nov 2000 12:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129153AbQKWRuj>; Thu, 23 Nov 2000 12:50:39 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:56839 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129091AbQKWRu2>; Thu, 23 Nov 2000 12:50:28 -0500
Date: Thu, 23 Nov 2000 09:20:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: {PATCH} isofs stuff
In-Reply-To: <20001123175849.A116@macula.net>
Message-ID: <Pine.LNX.4.10.10011230911200.7992-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Nov 2000, Ragnar Hojland Espinosa wrote:
> 
> Yup, indeed it solves the dir/namei problem.  

Can you check whether the single patch of _just_ removing the extra "f_pos
>= i_size" test in do_isofs_readdir() fixes it? The other changes of
Andries patch look like they should not affect code generation at all, but
I'd still like to verify that it's only that part. If so, it definitely
looks like a gcc-2.95.2 code generation bug - that single if() statement
does not actually matter for the end result, it's just a (misguided)
early-out optimization.

[ Btw, looking at the generated assembly is quite painful. Ugh. It reminds
  me again why "long long" is to be avoided with gcc. Getting rid of the
  extra test actually improves and speeds up that function probably
  simply because the 64-bit arithmetic just cofuses gcc so badly. ]

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
