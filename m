Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbRAKAaL>; Wed, 10 Jan 2001 19:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130431AbRAKAaB>; Wed, 10 Jan 2001 19:30:01 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:40466 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129584AbRAKA3w>; Wed, 10 Jan 2001 19:29:52 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: * 4 converted to << 2 for networking code
Date: 10 Jan 2001 16:29:27 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <93iup7$6s4$1@cesium.transmeta.com>
In-Reply-To: <20010110174859.R7498@prosa.it> <3A5C778C.CFB363F3@didntduck.org> <20010110180322.T7498@prosa.it> <20010110161146.A3252@unthought.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010110161146.A3252@unthought.net>
By author:    =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
In newsgroup: linux.dev.kernel
> 
> On most processors <<2 is slower than *4.
> 

That's a funny statement.  Which processors do you include in "most"?
That has not been my experience.

> It's outright stupid to write <<2 when we mean *4 in order to optimize for one out of a
> gazillion supported architectures - even more so when the compiler
> for the one CPU where <<2 is faster, will actually generate a shift
> instead of a multiply as a part of the standard optimization.
> 
> One question for the GCC people:  Will gcc change <<2 to *4 on other 
> architectures ?    If so, then my case is not quite as strong of course.
> 

gcc should consider the statements equivalent, and generate whichever
pattern is preferred.  On an i386 that may mean take a pattern such as

	foo = (bar << 2) + quux;

... and generate ...

	lea ecx,[esi*4+ebx]

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
