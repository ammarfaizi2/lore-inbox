Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130792AbRAVJxI>; Mon, 22 Jan 2001 04:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131555AbRAVJw6>; Mon, 22 Jan 2001 04:52:58 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:62724 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S130792AbRAVJwv>; Mon, 22 Jan 2001 04:52:51 -0500
Message-ID: <3A6C02C4.E34E3A6@idb.hist.no>
Date: Mon, 22 Jan 2001 10:52:04 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: James Sutherland <mandrake@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.30.0101210945220.8238-100000@dax.joh.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Sutherland wrote:
> 
> On Sat, 20 Jan 2001, Linus Torvalds wrote:
> 
> >
> >
> > On Sat, 20 Jan 2001, Roman Zippel wrote:
> > >
> > > On Sat, 20 Jan 2001, Linus Torvalds wrote:
> > >
> > > > But point-to-point also means that you don't get any real advantage from
> > > > doing things like device-to-device DMA. Because the links are
> > > > asynchronous, you need buffers in between them anyway, and there is no
> > > > bandwidth advantage of not going through the hub if the topology is a
> > > > pretty normal "star" kind of thing. And you _do_ want the star topology,
> > > > because in the end most of the bandwidth you want concentrated at the
> > > > point that uses it.
> > >
> > > I agree, but who says, that the buffer always has to be the main memory?
> >
> > It doesn't _have_ to be.
> >
> > But think like a good hardware designer.
> >
> > In 99% of all cases, where do you want the results of a read to end up?
> > Where do you want the contents of a write to come from?
> >
> > Right. Memory.
> 
> For many applications, yes - but think about a file server for a moment.
> 99% of the data read from the RAID (or whatever) is really aimed at the
> appropriate NIC - going via main memory would just slow things down.
> 
> Take a heavily laden webserver. With a nice intelligent NIC and RAID
> controller, you might have the httpd write the header to this NIC, then
> have the NIC and RAID controller handle the sendfile operation themselves
> - without ever touching the OS with this data.

And when the next user wants the same webpage/file you read it from the
RAID again?
Seems to me you loose the benefit of caching stuff in memory with this
scheme.
Sure - the RAID controller might have some cache, but it is usually
smaller
than main memory anyway.  And then there are things like
retransmissions...


Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
