Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131532AbQLNDMg>; Wed, 13 Dec 2000 22:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131909AbQLNDM0>; Wed, 13 Dec 2000 22:12:26 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:63237 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S131532AbQLNDMT>;
	Wed, 13 Dec 2000 22:12:19 -0500
Date: Wed, 13 Dec 2000 20:42:22 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Alexander Viro <viro@math.psu.edu>,
        "Mohammad A. Haque" <mhaque@haque.net>, Ben Ford <ben@kalifornia.com>,
        linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: [Korbit-cvs] Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <E146Mvx-0003Zj-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0012132025310.24483-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Don't worry about kORBit.  Like most open source projects, it will simply
> > die out after a while, because people don't find it interesting and there
> > is really no place for it.  If it becomes useful, mature, and refined,
> > however, it could be a very powerful tool for a large class of problems
> > (like moving code OUT of the kernel).
> 
> I do have one sensible question. Given that corba is while flexible a 
> relatively expensive encoding system, wouldn't it be better to keep corba
> out of kernel space and talk something which is a simple and cleaner encoding

Very good point.  I think this distills down to common misconception of
CORBA: that it must be slow.  Actually, a LOT of research has been done
to improve CORBA performance, but you have to keep in mind one very
IMPORTANT THING:

CORBA does NOT dictate a transport or data format for the data going out
"over the wire".

CORBA does specify one "standard" used for interoperability: GIOP.  It
also specifies one important incarnation of GIOP: IIOP (GIOP over
IP).  kORBit currently uses this to communicate from user space to kernel
space... obviously this is not ideal.  :)

There is absolutely NOTHING that prevents us from defining our own "data
marshalling" protocol/algorithm that is lighter weight than IIOP.  In
fact, we had planned to implement that for our project, but of course, ran
out of time.  It would be relatively straight forward to define this
extension in the ORBit code base, and in fact "ORBit 2" is striving to
make this much much easier than it is now (basically sorting out IIOP
specific code from the main code base better, and generally cleaning
things up).  Currently, ORBit supports IIOP and its own proprietary (as
far as I know) Unix domain socket protocol (obviously only works
intramachine).

There is a large perception of CORBA being slow, but for the most part it
is unjustified.  I believe that the act of _designing_ a completely new
protocol, standardizing it, and making it actually work would be a huge
process that would basically reinvent CORBA (obviously some of the design
decisions could be made differently, but all the same issues would have be
dealt with).

CORBA, today, gives us superior interoperability (through IIOP), with
extensibility for the future.  As Alexander Viro mentions, 9P may be a
better protocol for local communications... so CORBA gives us a framework
to try that out with.  Even IIOP is smart enough to, for example, only do
endian swapping of data if the two machines actually differ... so at least
it doesn't specify a "network" byte order. 

CORBA isn't ideal for all applications, it certainly isn't the ideal IPC
or RPC mechanism (the L4 designers would have a laughing fit if you tried
to use it for _general_ IPC), but it is very useful for a lot of
things.  kORBit is very pre-alpha code, it works, but has lots of room for
enhancements, experiementation, and toying around with.  

That's what makes it cool.  :)

-Chris

http://www.nondot.org/~sabre/os/
http://www.nondot.org/MagicStats/
http://korbit.sourceforge.net/



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
