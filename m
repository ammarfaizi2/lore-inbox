Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130870AbQLNHy2>; Thu, 14 Dec 2000 02:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131191AbQLNHyT>; Thu, 14 Dec 2000 02:54:19 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:38110 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130870AbQLNHyI>;
	Thu, 14 Dec 2000 02:54:08 -0500
Date: Thu, 14 Dec 2000 02:23:39 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Lattner <sabre@nondot.org>
cc: linux-kernel@vger.kernel.org, korbit-cvs@lists.sourceforge.net
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012140007540.25306-100000@www.nondot.org>
Message-ID: <Pine.GSO.4.21.0012140127060.6300-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2000, Chris Lattner wrote:

> > Oh, great. So we don't have to care about formatting changes. We just
> > have to care about the data changes. IOW, we are shielded from the
> > results of changes that should never happen in the first place. And the
> > benefit being...?
> 
> What the hell are you talking about?  Did you even read my example? I was
> giving an example of extending an API, adding new functionality to it.

Yes, I did. What I don't understand is how kernel mechanism for marshalling
would make your life easier wrt changes.

> > Notice that we could equally well add /dev/floatymouse and everything that
> > worked with old API would keep working. The only programs that would need
> > to know about floats would be ones that would... need to know about floats
> > since they want to work with them.
> 
> Wonderful solution.  This is exactly what you would _have_ to do.  Are you
> aware of why devfs came into existence?  It is because there are already
> so damn many device nodes in /dev.  Lets keep adding more.

And? The only _wrong_ thing here is storing that stuff on a physical disk.
Let the driver export the filesystem and union-mount it on /dev. End of
story. Or mount it anywhere else, whatever place makes you happy. It's not
like we were eating majors/minors that way...

> > Notice also that I can say ls /dev/*mouse* and get some idea of the files
> > there. I can't do that for your interfaces.
> 
> And you know what?  I can't do ls /dev/*net* and get all the network
> devices either.  Actually, one of the very cool things about CORBA is that
> you can BROWSE/LIST/SEARCH all objects currently instantiated.  Being
> able to browse all in kernel objects would be very cool.

So what's to stop you from letting readdir() do the work? WTF do we need
one more API for returning the list of objects?

> > The point being: if your program spends efforts on marshalling it would
> > better _do_ something with the obtained data. And then we are back to
> > the square 1.
> 
> Uh huh, go ahead and read the example I sent to you.

Did that.

> > Returning to your example, I could not tee(1) the stream into file for
> > later analysis. Not unless I write a special-case program for intercepting
> > that stuff. I don't see why it is a good thing.
> 
> On the contrary, it would be pretty easy to do something like that with
> CORBA.  No you wouldn't be able to use tee, but why would you want to tee
> a binary data file?  The only reason that tee works in this situation is

For the same reasons why I use tar, gzip, whatever. I don't _want_ to
invent a new utility every time when Joe Doe adds a new piece of interface.
Data is data is data. I can uuencode it and send to somebody who would
care to analize the bloody thing. Do you mean that I need to write a
special tool for that? For _every_ member of every interface somebody
decided to add? I don't think so. I really don't.

> because it's agnostic to the format of the data coming off the

Exactly.

> line... your analysis program would have to have special purpose code to
> parse the file.  EVERY consumer of "mouse data" would have to parse the

Or I would look at the size. Or I would say od and look at the result. Don't
tell me what to do with the data, when I'll need to parse it I will. And
if you expect me to bother with writing more stuff when generic tools would
work fine - too bad, I've been there, done that and I'm not coming back.

BTW, you cared about size of /dev, didn't you? /usr/bin choke-full of tee-foo,
tee-bar, yodda, yodda would be better?

> file.  That seems pretty silly to me.

Difference between good program and bad one: the former gets used in ways
its authors never thought about...

> > I also don't see where the need in new system calls (or ioctls, same shit)
> > comes from. Notice that your way is much closer to new system call than
> > read()/write() of the right stuff.
> 
> A new syscall was one example.  It would be very simple to implement this
> by making _yet_another_ device node in /dev and issue reads and writes to
> it.  That's more of a syntactic issue than a symantic one.

No, it isn't. The difference being: letting driver to define a filesystem
and mounting/exporting it/whatever means that you get to use _all_ _normal_
_data-agnostic_ _tools_. And believe me, it matters. If you don't understand
that - no offense, but you don't understand UNIX.

To get this stuff working without excessive PITA you'll need to teach
userland about the new mechanism. Shells, mailers, archivers, backup, you
name it. It might be an interesting OS, but it sure as hell wouldn't be
UNIX and what's worse, it doesn't exist.

Mix of that CORBA_OS and UNIX would be extremely nasty. I have a serious
suspicion that CORBA_OS in itself would be a wonderful illustration to
"Why Pascal is Not My Favorite Programming Language", but that's
another story (BTW, that paper may make an interesting reading - check
http://www.lysator.liu.se/c/bwk-on-pascal.html).

Sigh... OK, as far as I'm concerned we are in the dead-end - data-agnostic
tools are very useful and I don't believe that you can convince me in the
contrary. If it leaves something to discuss - you are welcome. If it doesn't
we probably ought to stop wasting the bandwidth and agree that we disagree.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
