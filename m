Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286655AbRL1B6d>; Thu, 27 Dec 2001 20:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286649AbRL1B6X>; Thu, 27 Dec 2001 20:58:23 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:22791 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286685AbRL1B6N>;
	Thu, 27 Dec 2001 20:58:13 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Larry McVoy <lm@bitmover.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Thu, 27 Dec 2001 17:47:23 -0800."
             <20011227174723.V25698@work.bitmover.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Dec 2001 12:57:58 +1100
Message-ID: <19047.1009504678@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001 17:47:23 -0800, 
Larry McVoy <lm@bitmover.com> wrote:
>On Fri, Dec 28, 2001 at 12:41:48PM +1100, Keith Owens wrote:
>> On Thu, 27 Dec 2001 17:37:39 -0800, 
>> Larry McVoy <lm@bitmover.com> wrote:
>> >A couple of questions:
>> >
>> >a) will 2.5 be as fast as the current system?  Faster?
>> 
>> At the moment kbuild 2.5 ranges from 10% faster on small builds to 100%
>> slower on a full kernel build.  
>
>I don't understand why it would be slower.  Maybe I'm clueless but I thought
>you were moving more towards a single makefile system

It uses a single generated Makefile, that is not the problem.  The slow
code is extracting the dependencies.

Unlike the broken make dep, kbuild 2.5 extracts accurate dependencies
by using the -MD option of cpp and post processing the cpp list.  The
post processing code is slow because the current design requires every
compile to read a complete list of all the files, giving O(n^2)
effects.  Mark 2 of the core code will use a shared database with
concurrent update so post processing is limited to looking up just the
required files, instead of reading the complete list every time.

