Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264537AbRFOVwv>; Fri, 15 Jun 2001 17:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264538AbRFOVwl>; Fri, 15 Jun 2001 17:52:41 -0400
Received: from front5.grolier.fr ([194.158.96.55]:52917 "EHLO
	front5.grolier.fr") by vger.kernel.org with ESMTP
	id <S264537AbRFOVw0> convert rfc822-to-8bit; Fri, 15 Jun 2001 17:52:26 -0400
Date: Fri, 15 Jun 2001 20:39:56 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: Mike Black <mblack@csihq.com>
cc: "Heusden, Folkert van" <f.v.heusden@ftr.nl>, linux-kernel@vger.kernel.org
Subject: Re: Client receives TCP packets but does not ACK
In-Reply-To: <03c701c0f5c8$e15f7e10$e1de11cc@csihq.com>
Message-ID: <Pine.LNX.4.10.10106152000210.1464-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Jun 2001, Mike Black wrote:

> This is a very common misconception -- I worked a contract many years ago
> where I actually had to quote the author of TCP to convince a banking
> company I was working with that TCP is not a guaranteed protocol.
> Guaranteed delivery at layer 5 - yes -- but NOT a guaranteed protcol.
> 
> Guaranteed means that there is absolutely NO way that data can be dropped by
> an application if either sender or receiver screws up.
> 
> The only way to do this is at layer 7 of the OSI model -- even then you end
> up making assumptions.

You are mixing oranges (protocols) and apples (implementations and APIs)
here.

The layer that is expected to provide reliable end to end communication is
layer 4 (transport layer). TCP, at least in theory, is as good as OSI
transport in providing reliable end to end communication. 

> Here's some examples for layer 5 (which TCP operates at) but talking at
> Layer 7:
> 
> #1 - You send() data -- meanwhile the receiver terminates the connection --
> what happened to the data?  It's gone!  Your app never receives feedback
> that it didn't send() correctly.  You'll see the reset on the next read but
> you don't know what happened to the data.
> #2 - You send() data and overrun your IP queue -- nobody will ever know the
> difference without a layer 7 protocol (or int the case quoted in this
> subject it might lock up).
> #3 - You send() data and either machine has bad RAM and flips a bit -- guess
> what? -- data corruption.
> 
> Even when you do layer 7 (with checksums and ack/nak) you make assumptions:
> 
> #1 - You checksum the packet you just received -- what's to say a bit can't
> flip?
> 
> TCP may be guaranteed at layer 5 but we don't typically program at layer
> 5 -- we program at layer 7 and then lots of people assume they're doing it
> at layer 5 -- ergo the problems.

Layers above layer 4 provide additionnal services for applications but
they assume that layer 4 is reliable. In other words, a broken transport
layer breaks all layers above it and thus the applications.

In fact, when you build your application above layer 4 and need services
normally provided by upper OSI layers, you have to implement equivalent
services in your application, using layered protocols or not.

> To look at it another way -- "Just 'cuz I told my C library to send a packet
> doesn't mean it's going to work".
> For example, if you're using non-blocking sockets you have to check to
> ensure there's room in your IP queue to transmit.

That's API semantic issue, not protocol issue.

  Gérard.

