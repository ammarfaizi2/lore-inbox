Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264990AbSJRGcf>; Fri, 18 Oct 2002 02:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264991AbSJRGcf>; Fri, 18 Oct 2002 02:32:35 -0400
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:3473
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S264990AbSJRGcd>; Fri, 18 Oct 2002 02:32:33 -0400
Subject: Re: Posix capabilities
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <200210171322.g9HDME7o024177@pincoya.inf.utfsm.cl>
References: <200210171322.g9HDME7o024177@pincoya.inf.utfsm.cl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1034923112.10326.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2.99 (Preview Release)
Date: 18 Oct 2002 01:38:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-17 at 08:22, Horst von Brand wrote:
> GrandMasterLee <masterlee@digitalroadkill.net> said:
> > On Wed, 2002-10-16 at 22:26, Theodore Ts'o wrote:
> 
> [...]
> 
> > > Personally, I'm not so convinced that capabilities are such a great
> > > idea.  System administrators have a hard enough time keeping 12 bits
> > > of permissions correct on executable files; with capabilities they
> > > have to keep track of several hundred bits of capabilties flags, which
> > > must be set precisely correctly, or the programs will either (a) fail
> > > to function, or (b) have a gaping huge security hole.  
> 
> Nodz.
> 
> > While working with LIDS in it's early stages of implementation, and
> >... 
> 
> It is easier on the sysadmin for the people upstream (developers,
> distributors, ...) to set up stuff sanely in the executable. Sure, a lot of
> flexibility is lost this way.

I think the real perspective on this should be that lots of flexibility
can be lost this way, but not necessarily so that it inherently will be
lost. I say that because programming with the specification in mind that
flexibility should be as maintained as possible, while attempting to
provide the security in a sane and well thought out manner is a better
vehicle to acceptance. Thus people adopt things which are secure, but
flexible. 

I respect the *BSD folks for taking a somewhat inverse approach to this
though, since a lot of flexibility is maintained while security is job
one.

> > > This probablem could be solved with some really scary, complex user
> > > tools (which no one has written yet). 
> 
> > Looking at CA Unicenter, they have an ACLs and CAPs product which does
> > centralized management of those attributes to keep the configs sane
> > across your environment. Not trying to advertise for them, but the point
> > is, if a commercial product exists to do this, then it should be highly
> > possible in the OSS community as well.
> 
> Sorry, but I gather the vast mayority of Linux instalations to be
> single-machine (home use, ...). I have yet to see a hundred-machine setup
> myself (maximal is some 30 around here),

I have over 100 linux machines, which could benefit from this sort of
thing, which is why I mentioned CA eTrust's suite for this purpose. I
still have unanswered questions to this, but we'll probably give it a
trial run and see just what it really can/can't do. I'll be taking notes
of course to see what the OSS community can benefit from this
methodology. 

>  so this is out of the league of
> most people anyway. Plus Linux is falling more and more into the hands of
> the unwashed masses, who have a dificult time remembering not to do
> everything as root (leave alone fix up permissions).

I don't really agree about the unwashed masses bit, though I do
understand that viewpoint. To really open Linux to the world though, the
"unwashed masses" should be allowed to have input into something even if
they don't understand it fully. Their viewpoints and opinions will help
to fine tune some of the corner cases in the security area, and others
too. 

All that aside, Linux in the enterprise is becoming *very* common. If
all goes well in our environment, we'll have several 2TB+ DBs in
production by this time next year.

> > >  Alternatively you could just
> > > let programs continue to be setuid root....
>
> > To make management easy for the admins when I dealt with LIDS and making
> > it *very* tight, I had to write several wrappers, replace commands, etc
> > so they ran chrooted automatically, etc. It was a PITA. Cool when it
> > worked, but it was still a PITA.
> 
> But a once-in-the-development PITA, not a once-for-each-installation PITA

That's not really what I was getting at. The problem is that I had to
make these things not a PITA for the admins, and it was a PITA, compared
to an "every day" system, to administer. In a sense all functionality
was there, but there were many more hoops to jump to do normal
administration. In a sense, it was re-learning how to administer 100
boxen, which just got more tedious. 

The missing piece in this overall security architecture, to make things
more flexible, or semi-automated, was a distributed(or centralized)
state management system and repository for all ACLs and CAPs for all
users and the commands, filesystems, etc, affected. If there'd been
something like Kerberos on Steroids, thus supporting all ACLs and CAPs
in an authoritative way, it would've been much easier to configure and
maintain those configurations. 

> > > It perhaps only gives you 90% of the benefits of the full-fledged
> > > capabilities model, but it's much more fool proof, and much easier to
> > > administer.
> 
> > Perhaps exntending the security module to actually have a centralized
> > host configuration utility, using say AES or diffie-hellman and SSL or
> > SSH to do the configuration management of this. Centralizing, or
> > distributing the management of this, but with a decided upon security
> > architecture is what, imho, will actually make this type of
> > configuration very useable, and manageable. 
> 
> Have you seen any such centralized configuration management in real use?

Yes, as a matter of fact, we rolled our own, but it is still very basic,
though far more capable than just kickstart.

> The nearest we come here is Red Hat's kickstart for configuring the whole
> Lab (mostly) the same when installing, and that is for only slightly
> heterogeneous machines that must look the same to users.

Using something like System Imager, or the SystemInstaller suite from
IBM and Brian Finely, you can couple Kickstart with an image and then
version that image, with some custom programming around it, very easily.
You could, take it so far as to even use CVS or something similar, to
just keep track of changes in a cron'd manner just using a few scripts,
and have the images update as you please. 

You should look at a combination of Kickstart, Current, and SI. I think
with a little work on top of all of those pieces, you could easily have
a free, kick ass configuration management system. (which btw, the SI
suite is becoming very good at that.)

The real point of all of this rhetoric though, is that CAPs are good,
ACLs are good, and extended attributes are good. It's just that darn
administrative bit that becomes a hassle in large environments. 

 --The GrandMaster
