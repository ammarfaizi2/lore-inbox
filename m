Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131645AbQLNFQH>; Thu, 14 Dec 2000 00:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132466AbQLNFPu>; Thu, 14 Dec 2000 00:15:50 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:51174 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132446AbQLNFPg>;
	Thu, 14 Dec 2000 00:15:36 -0500
Date: Wed, 13 Dec 2000 23:45:07 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Lattner <sabre@nondot.org>
cc: linux-kernel@vger.kernel.org, korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012132208430.24782-100000@www.nondot.org>
Message-ID: <Pine.GSO.4.21.0012132334050.6300-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, Chris Lattner wrote:

> Which is exactly why it doesn't work well for many applications.  The
> problem is this: how do you get from a byte stream to a structured data
> stream?  There are many answers:
> 
> 1. Keep your data structures so simple, that it's obvious.  Not a good
> choice.  :)
> 2. Defined interfaces to the bytestream for every interface that you
> define.
> 3. Define a standard for inflating/deflating "things" into
> bytestreams.  Oh wait, that's what corba does.  :)

OK, now I'm completely confused. 
	* which complex data structures do you want to export from the kernel
in non-opaque way? 
	* which of those structures are guaranteed to remain unchanged?
	* if you have userland-to-userland RPC in mind - why put anything
marshalling-related into the kernel?

> The 9P way of doing things is not fundementally new, they just applied the
> idea that "everything is a file" more broadly.  What annoys me is that it
> is not immediately obvious how to "demarshall" the data that comes out of
> /dev/mouse for example.  Combine that with the problem that /dev/mouse
> might change format in the future (okay stupid example, but you get the
> idea) to use floating point coordinates, and things certainly get hairy.

HUH? OK, suppose it had happened. Do you really expect that you will not
need to change your applications? I mean, if you expected a bunch of
ints and received a bunch of doubles... You either need to decide on
rounding (and it's a non-obvious question) or you need to change quite a
bit of code in your program. It goes way past the demarshalling, no
matter whether you use CORBA, 9P or printf/scanf.

OK, suppose you have a CORBA-based system and mouse drivers' API had been
changed - they really want to return floating point coordinates. How will
CORBA help you? Aside of making your programs scream aloud, that is.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
