Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261309AbRFUARS>; Wed, 20 Jun 2001 20:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264083AbRFUARI>; Wed, 20 Jun 2001 20:17:08 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:55430 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S261309AbRFUAQz>; Wed, 20 Jun 2001 20:16:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: "J . A . Magallon" <jamagallon@able.es>, landley@webofficenow.com
Subject: Re: [OT] Threads, inelegance, and Java
Date: Wed, 20 Jun 2001 15:15:53 -0400
X-Mailer: KMail [version 1.2]
Cc: Aaron Lehmann <aaronl@vitelus.com>, hps@intermeta.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010620042544.E24183@vitelus.com> <01062007252301.00776@localhost.localdomain> <20010621000725.A24672@werewolf.able.es>
In-Reply-To: <20010621000725.A24672@werewolf.able.es>
MIME-Version: 1.0
Message-Id: <0106201515530C.00776@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 June 2001 18:07, J . A . Magallon wrote:
> On 20010620 Rob Landley wrote:

> What do you worry about caches if every bytecode turns into a jump and more
> code ?

'cause the jump may be overlappable with extra execution cores in RISC and 
VLIW?

I must admit, I've never actually seen somebody try to assembly-level 
optimize a non-JIT java VM before.  JIT always struck me as a bit of a 
kludge...

> And that native code is not in a one-to-one basis with respect to
> bytecode, but many real machine code instructions to exec a bytecode op ?

Sure.  But if they're honestly doing real work, that's ok then.  (If they're 
setting up and tearing down unnecessary state, that's bad.  I must admit the 
friction between register and stack based programming models was pretty bad 
in the stuff I saw back around JavaOS, which was long enough ago I can't say 
I remember the details as clearly as I'd like...)

Then again JavaOS was an abortion on top of Slowaris.  Why they didn't just 
make a DPMI DOS port with an SVGA AWT and say "hey, we're done, and it boots 
off a single floppy", I'll never know.  I mean, they were using green threads 
and a single task for all threads ANYWAY...  (Actually, I know exactly why.  
Sun thinks in terms of Solaris, even when it's totally the wrong tool for the 
job.  Sigh...)

Porting half of Solaris to Power PC for JavaOS has got to be one of the most 
peverse things I've seen in my professional career.

> I have seen school projects with interfaces done in java (to be 'portable')
> and you could go to have a coffee while a menu pulled down.

Yeah, but the slowness there comes from the phrase "school project" and not 
the phrase "done in java".  I've seen menuing interfaces on a 1 mhz commodore 
64 that refreshed faster than the screen retrace, and I've WRITTEN java 
programs that calculated animated mathematical function plots point by point 
in realtime on a 486.

> Would you implement a search funtion into a BIG BIG database in java ?

You mean spitting out an SQL request that goes to a backend RDMS?  I've done 
it.  (Via MQSeries to DB2.)

Interestingly, a rather large chunk of DB2 itself seems to be implemented in 
Java  Dunno how much, though.  Probably not the most performance critical 
sections.  But it uses a heck of a lot of it...

> No, you give a java interface to C or C++ code.

A large part of this is "not reinventing the wheel".

Also, I'd like to point out that neither Java 1.0 nor Java 1.1 had an API to 
truncate an existing file.  (I pointed that out to Mark English at Sun back 
when I worked at IBM, and apparently nobody'd ever noticed it before me.  
Fixed in 1.2, I'm told.)

> Until java can be efficiently compiled, it is no more than a toy.

I haven't played with Jikes.

> Then why do you use Java ? If you just write few objects with many methods
> you are writing VisualBasic.

That was below the belt.  I'm trying to figure out if you've just violated a 
corolary of Godwin's law with regards to language discussions, but I'll let 
it pass and answer seriously.

Because used that way, Java doesn't suck nearly as badly as visual basic 
does?  (My cumulative life experience trying to program in visual basic adds 
up to about three hours, so I don't consider myself an authority on it.  But 
I've had enough exposure to say it sucks based on actually trying to use it.) 
 That and it was developed on OS/2 to be deployed on (at least) windows 95, 
98, and power macintosh?

I still had threading inherent in the language.  The graphics() class is 
actually a fairly nice API for doing simple 2d line drawing stuff in a 
portable way.  (It is too, except for fonts.  If you don't use any 
heavyweight AWT objects, and you're religious about using fontmetrics to 
measure your text, you can actually get pretty portable displays.)  I still 
had the GOOD bits of C++ syntax without having to worry about conflicting 
virtual base classes.  It's TRULY object oriented, with metaclasses and 
everything.

> See above. Traversing a list of objects to draw is not time consuming,
> implementing a zbuffer or texturing is. Try to implement a zbuffer in java.

I'll top that, I tried to implement "deflate" in java 1.0.  (I was porting 
info-zip to java when java 1.1 came out.

Yeah, the performance sucked.  But the performance of IBM's OS/2 java 1.0 jdk 
sucked compared to anything anybody's using today (even without JIT).

> The problem with java is that people tries to use it as a general purpose
> programming language, and it is not efficient. It can be used to organize
> your program and to interface to low-level libraries written in C. But
> do not try to implement any fast path in java.

I once wrote an equation parser that took strings, substituted values for 
variables via string search and replace, and performed the calculation the 
string described.  It did this for every x pixel in a 300 pixel or so range 
to get the resulting y value, then iterated through the array thus created 
and played connect the dots to graph the function.  On a 486 it could update 
the display about four times a second as different values were plugged in.

That may not have been nearly as fast as it would have been in C, but it was 
fast enough for me.  (And most of that was the darn string creation to 
substitue in the values, but I never got around to doing a more efficient 
variable lookup table method because I didn't have to, the performance was 
good enough.)

> If java or pyton were so efficient, you could write a ray-tracer or a
> database search engine in java or python, etc. Look, write it in java, not
> use a java interface to a binary module.

And it'd be even faster if you wrote it in hand optimized assembly.  Your 
point being?.

Somebody wrote a distributed.net key cracker in Java, which is about 5% as 
efficient as the hand-optimized assembly native code key crackers people 
usualy used.  Benchmarking one of those on a pentium desktop, it still beat 
my little 486 laptop using the native thing, which had been the height of 
technology about six years earlier.  And I can leave the java key cracker 
running for an hour or two in a web browser at the local library without 
anyone getting too upset.  I can't do that with a native one.  (What they 
object to is installing software, you see.  Not running it.)

I'm upset that Red Hat 7.1 won't install on that old laptop because it only 
has 24 megs of ram and RedHat won't install in that.  I haven't heard anybody 
else complain about that.  (Their questionable compiler descisions, sure.  
The security, of course.  The fact they will no longer install in 16 megs of 
ram, no.)

There's a gameboy emulator written in java out on the net somewhere that 
plays gameboy games in a web page as fast as the original gameboys used to.  
I find that useful.

Attacking java because of the performance is like attacking C because its 
memory management system is held together with duct tape (stack overflows, 
memory leaks, wild pointers, all so easy to do in C).  It's a complete red 
herring if you ask me...

Rob
