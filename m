Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267623AbTAMPM4>; Mon, 13 Jan 2003 10:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267633AbTAMPM4>; Mon, 13 Jan 2003 10:12:56 -0500
Received: from chaos.analogic.com ([204.178.40.224]:16005 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267623AbTAMPMy>; Mon, 13 Jan 2003 10:12:54 -0500
Date: Mon, 13 Jan 2003 10:23:39 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Rob Wilkens <robw@optonline.net>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
In-Reply-To: <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
Message-ID: <Pine.LNX.3.95.1030113102041.21084A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2003, Rob Wilkens wrote:

> Linus,
> 
> I'm REALLY opposed to the use of the word "goto" in any code where it's
> not needed.  OF course, I'm a linux kernel newbie, so I'm in no position
> to comment
>
I'm sure Linus can hold his own on this one, but this has become
a FAQ or FSB (Frequently stated bitch).


Programming 101:
All known microprocessors execute instructions called
"op-codes". The logic of program-flow is implemented
by testing condition "flags" and jumping somewhere else,
based upon the condition. These jumps are "GOTOs".

To implement logic, you have three, and only three choices.
You can jump to some code that's earlier in the instruction
stream, you can jump to some code that's later in the
instruction-stream, or you can just keep executing the
current instruction stream.

Assemblers generate op-codes that programmers program.
They are not allowed to change anything a programmer inputs.
For all practical purposes, they simply change programmer-
defined names to processor-specific op-codes.

Compilers have more latitude. Compilers, including 'C' compilers
attempt to convert logic that a programmer defines to op-codes.
Since a compiler needs to generate code that will give the
correct logic, regardless of the previous logic or the following
logic, it is constrained in its code generation capabilities in
a manner that an assembly-language programmer would not necessarily
be. However, an astute programmer can, using the tools provided
by the compiler, including 'goto', cause code-generation in which
the usual case allows the processor to continue executing the
current execution-stream without jumping.

When the processor is forced to jump on a condition, this usually
costs CPU cycles. An astute kernel programmer may spend hours
mucking with a single piece of code trying to make it execute as
fast as possible. When a new-be comes along and complains about
the methods used, he is going to get his feet wet real quickly!

Here is an example of how some junior instructors in college
teach...
        if(...){
        {
            if(...){
            {
                if(...){
                 {

They just don't get it. When you get to something that's not
true you can't readily "get out". Further, the normal program-
flow ends up with all those "ifs". The above code should be:

         if(!...) goto get_out;
         if(!...) goto get_out;
         if(!...) goto get_out;
         {do something()...}
         get_out:

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


