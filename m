Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286214AbRL0Fdp>; Thu, 27 Dec 2001 00:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286215AbRL0Fd0>; Thu, 27 Dec 2001 00:33:26 -0500
Received: from fc.capaccess.org ([151.200.199.53]:33033 "EHLO fc.Capaccess.org")
	by vger.kernel.org with ESMTP id <S286214AbRL0FdK>;
	Thu, 27 Dec 2001 00:33:10 -0500
Message-id: <fc.008584120025657a008584120025657a.256592@Capaccess.org>
Date: Thu, 27 Dec 2001 00:31:55 -0500
Subject: rehash
To: linux-kernel@vger.kernel.org
From: "Rick A. Hohensee" <rickh@Capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of you enjoy doing things that IBM will have to replicate. I don't.
I don't see the fun in it at all, much less the point of it, and as I
think this recap shows, I never have seen any point to it. IBM seems to be
trying to distance themselves from personal computing. Do an Amiga guy and
personal computing in general a favor and _GET_ _OUT_ _OF_ _THIER_ _WAY_ .
Leave distinctly Big Unix(TM)  stuff to the behemoths. OK, fine, you
actually ENJOY SMP, journalling and so on, and you ENJOY being redundant.
At least don't be smug about Little Unixoid(TM) stuff, stuff they won't
have to replicate, such as the following.


Looking back over my posts, I sometimes don't even understand myself. Bad,
Rick, Bad. Humans require repetition at times. I'm human.  This is a
rehash of stuff I've submitted or otherwise presented here over the last
five years or so, less the antitrust rants and whatnot.  For the humans
among you, I reiterate...


H3rL            Hohensee's 3-ring Linux

H3rL is my 3-stack Forth-like language installed in the Linux kernel as a
kernel daemon or thread. It runs, like e.g. kswapd, as a coroutine or
co-kernel with Linux itself, with unrestricted access to everything. With
a System.map handy you can snoop on or tweak or sabotage a running Linux
to your heart's content. In short, it fuses unix and Forth, plus my
variable-size ints. I don't know how kdb and similar work, but H3sm is a
thread in H3rL, and Linux is still running normally. I just have to leave
vt1 open in my init stuff for one H3sm.

I didn't mention possible uses of H3rL much when I announced it. It allows
Forth-like interactive hardware twiddling. It allows interactive
reprogramming of itself, and Linux. It creates 0wnerland, interactive
extensible kernelspace. The 0 is for ring 0. The same stunt could be done
with a plain old 2-stack Forth, or a Lisp. Or you could emulate Forth or
whatever with H3sm.

An ANSI Standard plain old 2-stack Forth brings Open Firmware into the
picture, in the kernel. One then has a system that can import _drivers_ as
Forth _source_ from certain OF-compliant cards. H3rL might, in fact,
consume Linux from the inside out. So might the Open Driver Initiative. So
might <your name here>. The only mercy is that one does get to pick one's
own parasites. I prefer my parasites small. The H3sm I stuck in the kernel
gzips to about 8k, but it's currently x86-specific. The earlier C one is
bigger, and slower, and is among the wrongest C code ever written.

H3rL is of course not something the Production Environment Admin(TM) will
want anywhere on her LAN, IFF she's a network servers admin. (Actually,
it's not much worse that root, and it's console-only, but...) If you are
doing other things, like embedded, games, multimedia, process control,
client apps, etc., you want to be well aware of H3rL. I'd put it in 2.5.

        ftp://linux01.gwdg.de/pub/cLIeNUX/interim/ABOUT



make relink Linux appendage

This was a patch to a couple makefiles that simplifies and expedites the
hackerly activity of changing one source file and rebuilding (make
relink), puts a bzimage named "Linux" in ./linux (make Linux) which would
save many users several unnecessary hours of fruitless bewilderment, and
concatenates .config, System.map and, uh, maybe the build shell state, I
forget, to ./Linux, i.e. to the recently made image. That's "make
appendage". That keeps a collection of kernel images almost implicitly
organized. There's a "make state" thing in there too that saves the build
make state, which can be handy. I am normally openly hostile to make, as a
general rule, but most of the parts for "make relink" were already handy,
and one thing led to another...  Feed "make appendage" to google for the
original post.




unasm("")

This didn't lead to a specific patch or anything. It is leading me more in
the direction of writing a kernel, and I also have a "compembler" now,
which obviously eliminates asm("") escapes. I posted a mockup of Linux
schedule() in it just days ago. The thing is, Plan 9 does quite well
(perhaps not quite as performantly as Linux though) with a C compiler that
doesn't even have asm("") or similar. No such facility. Torvalds entered
the thread where I posited that it might be beneficial to lose asm("")
altogether. The Unit Penguin dumped a bracing blizzard of purest Finnish
snow on the argument, and added that it might be nice also if Gcc was more
flexible about specifying arg/register mappings, and rth seemed to think
that might be prudent.

Torvalds said something to the effect of "also a good idea" when talking
to rth about increasing argument passing controls in Gcc. That "also" was
as close to a positive response, or a direct response of any kind, as I've
ever gotten out of him in l-k, so I was going great guns for a while on
the unasm thing, but at this point, having gotten my 15 minutes of fame
for an assembler, and having more power in the assembler lately, and
having written an assembler in large part because of things like asm(""),
I'm more prone to un-C the whole thing, or worse. Others may prefer a less
abrupt approach. The subject line of the thread was roughly "Why Plan 9 C
compilers don't have asm("")".

A follow-on report remains to be reported. I did poke around for a week or
two with un-asm-ing Linux 1.2.13. Here's what I have. What is being
compared here is an IN LINE IN THE C asm("") versus what you could do with
no asm("") facility at all, which is a named normally linked labeled
routine containing the requisite impossible-or-really-slow-in-C
instructions, or plain C.  There are very few asm("")s where performance
is going to matter, and where, due to the rift between C and asm at the
call interface Torvalds so lucidly elaborated on, C or a plain call to a
regularly linked labeled regular assembly routine isn't good enough. I
didn't see any asm()s in 1.2.13 that were, to my UP client-use
comprehension limits, clearly indispensible.

Most asm()s exist because C just can't do the requisite instructions, not
because of performance. In removing asm()s there are cases where a new .S
file would arise. That's cheap.  The things C doesn't have for the most
part don't happen very often. The network checksums for example are big
loops per asm(""). Any performance issue is thus trivial proportionally.
Spinlocks might be a bitch. They are also SMP-only, yes? So asm("") is
partially an SMP dependancy? Icky. A Big Buff SMP Box can't afford a bit
of clarity in the code?  OK, I don't have clue-the-first about
spinlocks/SMP, but the point is looking at each use of asm("")
dispassionately and in full context might show that none are
indispensible, at no noticeable overall performance losses. Another one
that appears at first glance to be worth the asm("") is scanning a bitmap,
which Linux probably actually does a fair bit of. But then, C can check
whole ints for on-bits, or off-bits, quite quickly. And it's a loop
anyway. And then it's got to move a whole block of data for each bitscan?
What's the average iterations per asm("")? Hmmmmm. They all bear a look.
An unasm.patch would be a big, spread out patch, touching everything right
in the crotch. Each touch is just a touch though; no semantics change. It
behooves you to look closely at what the cost of unasming really would be.
I'm saying the cost is less than currently believed.

I realize the effort on the part of Gcc developers is all of the best
intentions, and I loved the GNU extensions as much as anybody. There's a
delightful joy of capability evident in them. And given asm()s, the GNU
implementation is pretty slick. My first H3sm was utterly dependant on
labels-as-values, for example, but it's a phase you go through.
Technical decisions like to asm("") or not to asm("") is where geeks are
supposed to remain a-social. GNU is great, but I don't think they need a
monopoly on building Linux, nor do Linux and Gcc need to version-track
each other. Gcc 3.0 can't build Linux 1.2.13 at all because of asm()
changes (dono about >3.0). That's Gcc breaking itself on fringe stuff.
Hmmmmmm. I can't express it clearly, but inter-project modularity is key
to the value of open source somehow. Otherwise you have Windows, and then
the Toolchains Of GNU afford you little more real freedom than a EULA.
Maybe I'm wierd, but I just don't feel geeky enough to shrinkwrap myself
to a wildebeast, even in a tuxedo.




DSFH

Dotted Standard File Hierarchy. This allows visible directory names to be
utterly localized, with dotted standard names like .sbi hidden, but
allowing normal unix sources and binaries to be installed with one
additional step (an ed script pass) that basically works on anything. Two
measly little lines in main.c. (and maybe another couple somewhere to
catch the odd literal "/dev/", "/tmp/"  and so on in the kernel).
Dummmmest code ever. Obviously bug-impossible. With some preceding
context...

        /*
         * We try each of these until one succeeds.
         *
         * The Bourne shell can be used instead of init if we are
         * trying to recover a really broken machine.
         */

        if (execute_command)
                execve(execute_command,argv_init,envp_init);
        execve("/sbin/init",argv_init,envp_init);
        execve("/etc/init",argv_init,envp_init);
        execve("/bin/init",argv_init,envp_init);
        execve("/bin/sh",argv_init,envp_init);
        execve("/.sbi/init",argv_init,envp_init);
        execve("/.bi/shell",argv_init,envp_init);



I've been using DSFH for a couple years now. Because I like it. Lots.
And I only speak English. Much of the benefit of Plan 9 namespaces on unix
in basically no code. And now on e.g. cLIeNUX you can

        mv /subroutine /lib
        mv /device /dev
                                if it makes you feel like Ken Thompson.
Now, HERE's the funny part. No one on Planet Earth needs DSFH in the
mainline Linux worse than Al Viro. Not even me. I'm fine patching locally
for cLIeNUX, which is why I haven't whined about DSFH more.

"Plan 9 namespaces? Cold turkey? I don't think so, Sen~or Viro. Do you
have, perhaps, some way to work us all up to that, Sen~or?"

Al doesn't, but I do, and it works nice here, and mine doesn't imply a
fundamental restructuring of unix. Do it for Al >;o)




one step up from    vi .config

A perfect config script that knows all the build interdependancies is
nice. It's also a mighty gob of work. I question whether such a thing can
be proven correct. That's not the problem, though. Adding a huge build
dependancy to achieve it equals defeat, theorem-provers and other scriptly
delights notwithstanding. This is an aspect of a kernel build that is
utterly unlike most scripting tasks, even if it is done with scripting.
Extraneous dependancies are simply un-OK for a kernel build. Linux already
needs several Turing-complete utils to build. FULL STOP.

A sloppy config util works most times. One will be rebooting or running
UML or whatever to try out the results anyway, so the cost of the ultimate
check has already been bought into. This means slop will usually get
caught very shortly after it becomes a problem without a rigorous config
setup. Most people with oddball hardware dependancies are aware of them,
and can make the necessary adjustments without proving any theorems,
mentally or automatedly. And a 200 line sh script is EASY to customize.
THAT is what open source is about, and will remain so, I hope. Systemic
mutability.

Ah, but we all love esr, and he's worked so hard (indeed, too hard), CML2
has had lots of collateral benefit, and CML2 is *very* *nice* yaddayadda.
All true. (Switching to my left hand...) His prose is as good as ANY.
Gorgeous, timeless stuff.

I suggest that something like my sloppy 200 line config script that was 2
days work be the guaranteed fall-back. It's a good alternative to CML2.
Tiny, risky, rustic, customizeable, zero-maintenance and unstoppable; or
luxurious, idiot-proof, and fragile from over-dependance; user's option.
The subject line in linux-kernel was

                one step up from vi .config
                                                        That version is
alpha, but it has made good kernels. It hasn't progressed because I don't
track mainline kernels anymore. That demo script has dependancies on
$VISUAL, m4 and clear, but they're fixable.



outro

I don't know at this point if I'll roll my own kernel from scratch, or
rape and dismember 1.2.13, or hock this stupid PC and go fishing. I'm
currently setting up to write a kernel from scratch. Having now written
two distinct programming languages that I prefer to C, one a stack machine
and one for register machines, my taste for unix is waning, and Linux is
in ./alien_examples/unix/Linux/ in my nascent new kernel devel dir. BUT,
the above are among many things (ggi, rtlinux, eol=CRLF...) I'd still do
in the main Linux line or an authorized fork, even if I was a devout open
source unix bigot, if I wanted to remain relevant in a fast-changing world
populated by monsters like IBM, Sun, big China, India, et cetera. It is
painfully obvious to me that the monster an open source unix should be
encroaching upon is Microsoft. Unix, not Windows-clone-on-unix, unix
itself, without X even, should be winning large chunks of mindshare. It
isn't, and the way it's going, it won't. At least it's a suitable platform
to develop something that might.



bottom line

If clinging strictly to POSIX, and therefor to mid-eighties unix design
and Ye Olde Centralized Timesharing Paradigm, constitutes presiding over a
microcosmic pool of evolution, that pool is very stagnant, and I don't
expect anything very pleasing or compelling to waft from it.


Best wishes,

Rick Hohensee
cLIeNUX User 0


