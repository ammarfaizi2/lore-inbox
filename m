Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130569AbQLNJwt>; Thu, 14 Dec 2000 04:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131881AbQLNJwj>; Thu, 14 Dec 2000 04:52:39 -0500
Received: from anakin.xinit.se ([194.14.168.3]:14344 "HELO anakin.xinit.se")
	by vger.kernel.org with SMTP id <S131876AbQLNJwY>;
	Thu, 14 Dec 2000 04:52:24 -0500
Message-ID: <3A389183.41AEB0B4@arrowhead.se>
Date: Thu, 14 Dec 2000 10:23:15 +0100
From: josef höök <josef.hook@arrowhead.se>
Organization: Arrowhead
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012132133190.24718-100000@www.nondot.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Lattner wrote:

> > > Err shame on you, don't forget about lcall and exceptions, and interrupts,
> > > and... That is technically more than _o_n_e_ "entry point".  :)  Oh wait,
> > > what about sysenter/exit too? :)
> > OK, you got me on lcall (however, that's iBCS-only, IIRC), but the rest...
> > what the hell does userland to interrupts? <thinks> OK, make it 2 - pagefault
> > can be arguably used in that way.
>
> The reason that I considered exceptions and interrupts is that often,
> exceptions get reflected as signals to the running processes (SIGSEGV,
> SIGFPE, SIGILL, others?), and interrupts can wake up processes (from
> sys_poll among others).  I was considering more of the user->kernel and
> kernel->user transitions... anyways, that's really besides the point.  :)
>
> > > this wonderful design we get all kinds of stuff like sys_oldumount vs
> > > sys_umount and others...
> > Check how often anything uses the majority of that stuff...
>
> Correct, it's for backwards compatibility with old programs (for example
> libc5 uses a lot of those "old" syscalls).
>
> > > > Yes, standard RPC mechanism would be nice. No, CORBA is not a good
> > candidate - > > too baroque and actually known to lead to extremely
> > tasteless APIs being > > implemented over it. Yes, I mean GNOME. So
>
> > Check 9P and compare. Really. Section 5 of Plan 9 manpages. Available on
> > plan-9.bell-labs.com/sys/man/
>
> That's fine.  Since the server is down (or the URL is bad), can you please
> give me an example of how 9P is better than CORBA?  I freely admit to not
> knowing much about 9P... how much do you know about CORBA (aside from
> your opinion that GNOME uses it, and therefore it is bad. ;)?
>
> > > without breaking backwards compatibility).  Please don't tell me that OOP
> > > is bad... or else we will have the eviscerate the VFS layer from the
> > > kernel (amount other subsystems)... :)
>
> > OOP is a nice tool. However, it's a tool that has incredible potential of
> > shooting one's foot. It's wonderful if you have sane set of methods. And
> > that's a _big_ if. "Easily extensible" is not an absolutely good thing -
> > C++ wankers all over the world are busily proving it every day. Heck, they
> > make a living out of that. IOW, the problem with interface changes is _not_
> > in converting the old code. It's in choosing the right changes. And that
> > part of the game can't be simplified.
>
> Oif.  That's like telling someone that C is evil because it has for loops,
> and for loops can be used to write nasty code.  "just write in
> assembler" he says.  :)  I would claim that someone could write a bad
> program (or shoot themselves in the foot) with any turing complete
> language.  C++ definately give you more rope to do that with, but used
> wisely, it can also be nice.  The trick is to just not have to work with
> other peoples C++ code.  :)  Hey, did I mention that kORBit and all its
> extensions are written in C? :)
>
> > > Like I mentioned in a previous email, CORBA does not preclude 9P.  What
> > > it does buy you though, is compatibility with LOTS of preexisting CORBA
> > > tools.  How much development infrastructure is there for 9P?  I thought
> > > so.  :)
>
> > All UNIX userland on the client side. lib9p on the server side (23Kb of sparse
> > C). Examples of use in servers - see the aforementioned site.
>
> Err... yeah, so you're effectively mapping UNIX/POSIX across 9P.  That's
> not very creative, and you could do the same thing with CORBA.  I ask
> again, "How much development infrastructure is there for 9P?".  If you say
> "just use unix", then what is the point of 9P at all?  (on linux).  Linux
> already has most of posix (and some would claim all of the "good
> stuff" in posix.).

Plan9 aint unix/posix though it has its Ape environment.
What we do need to look at is a good implementation for distributed resources.
The ideal would bee getting 9P and IL into linux. Think of having thousand of small

linux boxes dedicated to either run as a CPU server or a Fileserver or whatever
service there is.
kOrbit is good idea in theory (havent looked at the code yet) though the drawback
with corba is that is
client/server oriented.The advantage of 9P/IL is that it's a small protocol for
distributing services, objects, devices on a file basis. Different computers can
act as a server or client transparent to the users. 9P is still a client server
protocol in a manner of users and services ( files ) instead of the "old" thinking
of pc's and servers.

/josef

>
>
> > > For one of our demos, we ran a file server on a remote linux box (that we
> > > just had a user account on), mounted it on a kORBit'ized box, and ran
> > > programs on SPARC Solaris that accessed the kORBit'ized linux box's file
> > > syscalls.  If nothing else, it's pretty nifty what you can do in little
> > > code...
> > Duh. And what's new about that?
>
> The "new" part is that our servers were < 100 lines of code each.  Compare
> that to kNFS.  :)
>
> -Chris
>
> http://www.nondot.org/~sabre/os/
> http://www.nondot.org/MagicStats/
> http://korbit.sourceforge.net/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
