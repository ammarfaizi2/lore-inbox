Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131496AbRCWXA0>; Fri, 23 Mar 2001 18:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131501AbRCWXAQ>; Fri, 23 Mar 2001 18:00:16 -0500
Received: from jalon.able.es ([212.97.163.2]:24008 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S131496AbRCWW75>;
	Fri, 23 Mar 2001 17:59:57 -0500
Date: Fri, 23 Mar 2001 23:59:09 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Bill Wendling <wendling@ganymede.isdn.uiuc.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "J . A . Magallon" <jamagallon@able.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gcc-3.0 warnings
Message-ID: <20010323235909.C3098@werewolf.able.es>
In-Reply-To: <20010323162956.A27066@ganymede.isdn.uiuc.edu> <Pine.LNX.4.31.0103231433380.766-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.31.0103231433380.766-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Mar 23, 2001 at 23:34:15 +0100
X-Mailer: Balsa 1.1.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.23 Linus Torvalds wrote:
> 
> I agree. I'd much prefer that syntax also.
> 
> Or just remove the "default:" altogether, when it doesn't make any
> difference.
> 

Well, at last some sense. The same is with that ugly out: at the end
of the function. Just change all that 'goto out' for a return.
It does not matter, -O2 is going to do what it wants.

And the missing return 0 at the end of functions that call a 'noreturn'
function. gcc 2.96 still wants them. But it looks like a religious matter
to put ot not to put that stupid return just to shut up the compiler.
As I understand, the noreturn says that the function that is marked as
noreturn is allowed to have missing correct return paths, and the compiler
can build, for example <panic>, without worring about the global state
once it has entered <panic>. But <info gcc> says nothing about functions
that call a 'noreturn' function. So I see as INCORRECT to omit a return path
in a function that calls <panic>.

And if people is so worried about fast paths, begin to use 'const' or
'pure' functions. I think that can help the compiler to generate fast code
more than trying to do hancrafted fast paths that the compiler will reorganize.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.2-ac22 #3 SMP Fri Mar 23 02:06:00 CET 2001 i686

