Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTE0Eyb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 00:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTE0Eyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 00:54:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57610 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263369AbTE0Eya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 00:54:30 -0400
Date: Mon, 26 May 2003 22:07:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Aaron Lehmann <aaronl@vitelus.com>
cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5] [Cool stuff] "checking" mode for kernel builds
In-Reply-To: <20030527044744.GJ9947@vitelus.com>
Message-ID: <Pine.LNX.4.44.0305262159290.12230-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 May 2003, Aaron Lehmann wrote:
> 
> The output between "#include <...> search starts here:" and "End of
> search list." seems like the combination of what you want for
> gcc_includepath and sys_includepath. I assume the output is ordered. I
> might send a patch if I'm bored tonight.

If it comes to parsing "gcc -v" output, I have to say that I personally
find that to be just crazy, and I'd much rather just see the (incorrect
but working) '-print-file-name=include' hack.

Note that to some degree the _better_ approach is to just make 
sparse-specific header files available to sparse itself, instead of making 
the checker try to look too much like gcc including using gcc's internal 
header files.

The kernel in particular only needs a very few files for the compiler,
notably <stdarg.h>.

Of course, for debugging I especially initially used a lot of non-kernel
files, and while my own personal interest is purely in the front-end, I'm
actually hoping that some crack-smoking crazy person would actually write
a back-end for it too, just for fun.

My own "test-parse.c" has it's own little back-end that outputs a very
strange kind of pseudo-assembler, and that was absolutely _critical_ to 
finding a lot of parsing and evaluation bugs. 

I guess I'm just a hopeless retard, but I initially tried to print out the
parse tree with all the type information, and I couldn't make sense of it
visually. Making a stupid back-end that outputs something that looks
almost like real assembly language was a huge advantage for me, because it
meant that I could mentally parse the output much better, and I found an
incredible number of type evaluation bugs that way.

But that's clearly all my back-end is useful for. 

			Linus

