Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264910AbRFUJqW>; Thu, 21 Jun 2001 05:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264911AbRFUJqM>; Thu, 21 Jun 2001 05:46:12 -0400
Received: from turnover.lancs.ac.uk ([148.88.17.220]:26101 "EHLO
	helium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id <S264910AbRFUJqG>; Thu, 21 Jun 2001 05:46:06 -0400
Mime-Version: 1.0
Message-Id: <a05101001b757645ed828@[192.168.239.105]>
In-Reply-To: <0106201515530C.00776@localhost.localdomain>
In-Reply-To: <20010620042544.E24183@vitelus.com>
 <01062007252301.00776@localhost.localdomain>
 <20010621000725.A24672@werewolf.able.es>
 <0106201515530C.00776@localhost.localdomain>
Date: Thu, 21 Jun 2001 10:40:02 +0100
To: landley@webofficenow.com, "J . A . Magallon" <jamagallon@able.es>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: [OT] Threads, inelegance, and Java
Cc: Aaron Lehmann <aaronl@vitelus.com>, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > I have seen school projects with interfaces done in java (to be 'portable')
>>  and you could go to have a coffee while a menu pulled down.
>
>Yeah, but the slowness there comes from the phrase "school project" and not
>the phrase "done in java".  I've seen menuing interfaces on a 1 mhz commodore
>64 that refreshed faster than the screen retrace, and I've WRITTEN java
>programs that calculated animated mathematical function plots point by point
>in realtime on a 486.

Sure, but the Commodore had highly-optimised code working for it.  I 
think I'm a long way beyong the "school project" stage, but I've had 
REAL difficulty getting Java to perform well.

As one of the assignments in my 1st-year CompSci course, we got to 
write a program which checked for balanced braces in a source file. 
We were supposed to do this in Java - at the time, the Blackdown 
1.1.8 JVM was current.  I and a classmate used a 160K C source file 
from a MUD as a test load.  He ran it multiple times on the Solaris 
system provided for 1st-year programming, I ran it on my Linux 486.

My first effort was a nice "clean" OOP-friendly implementation which 
made heavy use of Java's nice-looking String operators.  As anyone 
who has worked with Java will be able to guess, this was also an 
extremely slow and inefficient implementation.  I recall it took 
upwards of 2 minutes to parse that source file and confirm that it 
had properly-paired braces.  This on a machine which now handles DNS, 
e-mail, webcaching, webserving, and sometimes gateway duties for my 
other machines.

Much work later, I garnered an implementation that used more C-like 
operators and looked much messier, but ran 6 times quicker.  Most of 
the work went into eliminating object creation and destruction, which 
tickled Java's extremely slow garbage collection.  I still don't 
fully understand why free() has no equivalent in Java.  My classmate 
got his version running even faster, but I don't know how he managed 
it.

Then I quickly hacked up a C version of the same program using the 
same algorithm, and compiled it using GCC.  It immediately ran 6 
times quicker still, and consumed less than a 50th of the memory.

With 28Mb RAM, I could only run 4 copies of the Java program in 
parallel before the machine started thrashing, but the C version got 
to 20 copies before the terminal simply got too sluggish to start any 
more (the machine was not thrashing, it was just under severe load). 
All 20 copies completed in less time than a single instance of the 
original Java implementation.

Incidentally, I've used VB as well, and it's even worse.  I couldn't 
get a P75 to drive a stepper-motor at more than 4 steps per second, 
and that was hardly a complex algorithm.  Given that I learned basic 
programming techniques using BBC BASIC on a 2MHz 6502, I *know* 
that's pathetic even for interpreted BASIC.  When an ARM610 at 40MHz 
running interpreted BASIC can outperform highly-optimised 16-bit x86 
assembly on a 486SX/40, you know Acorn got their interpreter done 
better than M$ did.

>  > Until java can be efficiently compiled, it is no more than a toy.
>
>I haven't played with Jikes.

Nor have I.  But frankly, I don't care.  Neither C, nor C++, nor Java 
make good beginner's languages.  The former two are efficient and 
safe if handled with some care.  The latter is safe but not efficient 
even in an expert's hands.

>I still
>had the GOOD bits of C++ syntax without having to worry about conflicting
>virtual base classes.

Hmmmm...  a well-designed C++ system doesn't have to worry about that 
either.  C++'s features are only bad if misused - it's an expert's 
language for crying out loud.

>  > See above. Traversing a list of objects to draw is not time consuming,
>  > implementing a zbuffer or texturing is. Try to implement a zbuffer in java.
>
>I'll top that, I tried to implement "deflate" in java 1.0.  (I was porting
>info-zip to java when java 1.1 came out.
>
>Yeah, the performance sucked.  But the performance of IBM's OS/2 java 1.0 jdk
>sucked compared to anything anybody's using today (even without JIT).

That reminds me...  allocating a two-dimensional array in Java is a 
*real* *pain*.  You have to declare the darn thing as an array of 
arrays, and then allocate that array of arrays explicitly, and then 
loop through that bloody array and allocate each subarray 
individually!  The alternative is to allocate a one-dimensional array 
and use what amounts to heavy pointer arithmetic, which can't be 
cheap on the CPU.

>  > The problem with java is that people tries to use it as a general purpose
>>  programming language, and it is not efficient. It can be used to organize
>>  your program and to interface to low-level libraries written in C. But
>>  do not try to implement any fast path in java.
>
>I once wrote an equation parser that took strings, substituted values for
>variables via string search and replace, and performed the calculation the
>string described.  It did this for every x pixel in a 300 pixel or so range
>to get the resulting y value, then iterated through the array thus created
>and played connect the dots to graph the function.  On a 486 it could update
>the display about four times a second as different values were plugged in.
>
>That may not have been nearly as fast as it would have been in C, but it was
>fast enough for me.  (And most of that was the darn string creation to
>substitue in the values, but I never got around to doing a more efficient
>variable lookup table method because I didn't have to, the performance was
>good enough.)

I'd really like to see how you did that - my experience of Java is 
that you'd need some extremely clever code to handle such an 
operation even that fast.  I had to move my main 1st-year project 
from the 486 to a PowerBook (which benchmarks considerably faster 
than a P166/MMX) and Apple's JVM before it performed adequately for 
presentation.  Incidentally, that same project refused to compile on 
Sun's JDK under Solaris - oh, the irony.  My team received the 
runners-up prize for that effort.

>  > If java or pyton were so efficient, you could write a ray-tracer or a
>>  database search engine in java or python, etc. Look, write it in java, not
>>  use a java interface to a binary module.
>
>And it'd be even faster if you wrote it in hand optimized assembly.  Your
>point being?.

You can write a raytracer and a database in Java or Python all you 
like, or even VB if you're a masochist.  Just don't complain when it 
eats 5x the RAM and is 50x slower than the competition which uses 
bogstandard C or C++.  Raytracing is slow enough on state-of-the-art 
hardware and well-optimised C code, as it is.  From what I hear, 
databases need all the efficiency they can get too.

>Somebody wrote a distributed.net key cracker in Java, which is about 5% as
>efficient as the hand-optimized assembly native code key crackers people
>usualy used.  Benchmarking one of those on a pentium desktop, it still beat
>my little 486 laptop using the native thing, which had been the height of
>technology about six years earlier.  And I can leave the java key cracker
>running for an hour or two in a web browser at the local library without
>anyone getting too upset.  I can't do that with a native one.  (What they
>object to is installing software, you see.  Not running it.)

And this increases your chances of finding the key by very little for 
a significant amount of effort.  Big deal.

>I'm upset that Red Hat 7.1 won't install on that old laptop because it only
>has 24 megs of ram and RedHat won't install in that.  I haven't heard anybody
>else complain about that.  (Their questionable compiler descisions, sure. 
>The security, of course.  The fact they will no longer install in 16 megs of
>ram, no.)

SuSE 4.3 won't do a network install with less than 75Mb to it's name, 
but it'll install from disc in much less than that.  I persuaded an 
8Mb 486 to start running the Red Hat 6.1 installer by running fdisk, 
mkswap and swapon by hand from that nice little terminal they give 
you on tty2.  However it thrashed for several days before I told it 
to give up and used a spare machine with more RAM to perform the 
install.

>There's a gameboy emulator written in java out on the net somewhere that
>plays gameboy games in a web page as fast as the original gameboys used to. 
>I find that useful.

Fair enough.  Just remember that the PC you're running it on is 
hundreds of times more powerful than the machine it's emulating.  I'd 
like to see the same trick done for the Gameboy Advance though.

>Attacking java because of the performance is like attacking C because its
>memory management system is held together with duct tape (stack overflows,
>memory leaks, wild pointers, all so easy to do in C).  It's a complete red
>herring if you ask me...

Actually, it isn't.  An experienced coder can use techniques to avoid 
C's pitfalls by doing it right.  Java's performance and 
resource-hogging problems hurt everyone, even the experts.

Now, don't get me wrong here.  Java does have uses, in applications 
where fast development time and portability are more important than 
performance or resource utilisation.  However, that set of 
applications is a lot smaller than most Java defenders realise.

-- 
--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
website:  http://www.chromatix.uklinux.net/vnc/
geekcode: GCS$/E dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$
           V? PS PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r++ y+(*)
tagline:  The key to knowledge is not to rely on people to teach you it.
