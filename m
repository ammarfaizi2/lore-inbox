Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261696AbTCNJsn>; Fri, 14 Mar 2003 04:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261697AbTCNJsn>; Fri, 14 Mar 2003 04:48:43 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:60426 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261696AbTCNJrl>; Fri, 14 Mar 2003 04:47:41 -0500
Message-ID: <3E71A838.9020306@aitel.hist.no>
Date: Fri, 14 Mar 2003 11:00:24 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Szakacsits Szabolcs <szaka@sienet.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
References: <Pine.LNX.4.30.0303140703010.24704-100000@divine.city.tvnet.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Szakacsits Szabolcs wrote:
[...]
> Bcode, meaning before code [well, wrong choise, could be misunderstend
> as byte code], would mean it's the bytes before Code. They are not
> necessarily start on the _correct_ instruction boundary (14% they
> are). One should disassemble them separately from offset 0,1,...6
> (pedantic coders or in case of a later failure to 14) and choose the
> one that makes sense based on
> 
> 	1) next instruction boundary is on EIP (can be automated)
> and
The problem is that several offsets will fit into this.  Going
backwards from those positions gives even more options when
going two instructions back and so on.  And if you run into
an illegal opcode - was it a "wrong" attempt or did you
merely go beyond the start of the function?

> 	2) has something to do with the C source code
And how do you plan on achieving that?  This one is
impossible for the kernel, as the kernel don't know its
own sources.  (Now that _can_ be arranged, but it
won't be easy without regular file access in the kernel.)
But even with the source, how would you determine that the
disassembled stuff "has something to do with the source?"
Even programmers are sometimes surprised by what compilers,
and particularly opimizing compilers do.  I don't think
you or anybody else can provide a tool that reliably maps
assembly to source.  And if it isn't reliable, it is no use.


> and
> 	3) the assembly makes sense (considering compiler
>            optimizations, generated dead/bad code, etc)
> and
> 	4) the assembly fits the context after EIP.
> 
> If you think this would result more confusion than benefit, I
> understand (promised to my fiancee to say so ;)
> 
A tool doing this would be nice, but achieving 2 and 3 is impossible.
And even if you could do backwards disassembly with 95% success per
instruction you'd run into more and more trouble the farther backwards 
you get.  And then there's the problem of loops and jumps.  Perhaps
the code did a nice long jump to the instruction that faulted.  The
"previous instructions" are then useless because they weren't executed.
But there won't be any hint of that in the oops.

If you want an interesting excercise, try implementing (1) above.
Make a tool and try to disassemble perhaps 2-3 instructions
backwards from some random point in an object file.  Make sure
your tool outputs _all_ valid combinations of instructions, not
just the first one.  See how many you get.  Then see how
far you get with 2,3 and 4.


> On the other hand, if the kernel did this, a simple script could be
> written analysing the last two years kernel oopses [and future ones]

Most really old oopses are either fixed ot otherwise irrelevant.  The
code they refer to is changed, and there are newer versions of
the compiler.

Helge Hafting

