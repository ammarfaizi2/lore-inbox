Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVHOW7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVHOW7h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVHOW7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:59:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14805 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932312AbVHOW7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:59:13 -0400
Date: Mon, 15 Aug 2005 15:59:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@gmail.com>, akpm@osdl.org
Subject: Re: rc6 keeps hanging and blanking displays - bisection complete
In-Reply-To: <20050815221109.GA21279@aitel.hist.no>
Message-ID: <Pine.LNX.4.58.0508151550360.3553@g5.osdl.org>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org>
 <20050805104025.GA14688@aitel.hist.no> <21d7e99705080503515e3045d5@mail.gmail.com>
 <42F89F79.1060103@aitel.hist.no> <42FC7372.7040607@aitel.hist.no>
 <Pine.LNX.4.58.0508120937140.3295@g5.osdl.org> <43008C9C.60806@aitel.hist.no>
 <Pine.LNX.4.58.0508150843380.3553@g5.osdl.org> <20050815221109.GA21279@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Aug 2005, Helge Hafting wrote:
>
> This was interesting.  At first, lots of kernels just kept working,
> I almost suspected I was doing something wrong. Then the second last kernel
> recompiled a lot of DRM stuff - and the crash came back!
> The kernel after that worked again, and so the final message was:
> 
> 561fb765b97f287211a2c73a844c5edb12f44f1d is first bad commit

Ok, that definitely looks bogus. 

That commit should not matter at _all_, it only changes ppc64 specific 
things. 

If the bug is sometimes hard to trigger, maybe one of the "good" kernels 
wasn't good after all. That would definitely throw a wrench in the 
bisection.

Anyway, with something like this, where there may be false positives 
(false "good" kernels), the only thing you can _really_ trust is a kernel 
that got marked bad, because that one definitely has the problem. So make 
sure that you remember all known-bad kernels.

Btw, we haven't had a lot of testign of the termination condition for "git 
bisect", so it's possible it's off by a commit or two. However, the commit 
you actually ended up on is literally just two commits before 2.6.13-rc5, 
which makes me suspect that it's not the termination condition, as much as 
the fact that it really was an earlier kernel that had the problem, but 
you bisected it as "good" because the problem just didn't trigger quickly 
enough..

			Linus
