Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264470AbRFOS1t>; Fri, 15 Jun 2001 14:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264472AbRFOS1k>; Fri, 15 Jun 2001 14:27:40 -0400
Received: from picard.csihq.com ([204.17.222.1]:9631 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S264470AbRFOS1a>;
	Fri, 15 Jun 2001 14:27:30 -0400
Message-ID: <03c701c0f5c8$e15f7e10$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "Heusden, Folkert van" <f.v.heusden@ftr.nl>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <27525795B28BD311B28D00500481B7601F1477@ftrs1.intranet.ftr.nl>
Subject: Re: Client receives TCP packets but does not ACK
Date: Fri, 15 Jun 2001 14:27:47 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a very common misconception -- I worked a contract many years ago
where I actually had to quote the author of TCP to convince a banking
company I was working with that TCP is not a guaranteed protocol.
Guaranteed delivery at layer 5 - yes -- but NOT a guaranteed protcol.

Guaranteed means that there is absolutely NO way that data can be dropped by
an application if either sender or receiver screws up.

The only way to do this is at layer 7 of the OSI model -- even then you end
up making assumptions.

Here's some examples for layer 5 (which TCP operates at) but talking at
Layer 7:

#1 - You send() data -- meanwhile the receiver terminates the connection --
what happened to the data?  It's gone!  Your app never receives feedback
that it didn't send() correctly.  You'll see the reset on the next read but
you don't know what happened to the data.
#2 - You send() data and overrun your IP queue -- nobody will ever know the
difference without a layer 7 protocol (or int the case quoted in this
subject it might lock up).
#3 - You send() data and either machine has bad RAM and flips a bit -- guess
what? -- data corruption.

Even when you do layer 7 (with checksums and ack/nak) you make assumptions:

#1 - You checksum the packet you just received -- what's to say a bit can't
flip?

TCP may be guaranteed at layer 5 but we don't typically program at layer
5 -- we program at layer 7 and then lots of people assume they're doing it
at layer 5 -- ergo the problems.

To look at it another way -- "Just 'cuz I told my C library to send a packet
doesn't mean it's going to work".
For example, if you're using non-blocking sockets you have to check to
ensure there's room in your IP queue to transmit.

TCP is guaranteed delivery at layer 5 -- but that's all -- not a "guaranteed
protocol"
________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355
----- Original Message -----
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: "Mike Black" <mblack@csihq.com>; <linux-kernel@vger.kernel.org>
Sent: Friday, June 15, 2001 8:53 AM
Subject: RE: Client receives TCP packets but does not ACK


> TCP is NOT a guaranteed protocol -- you can't just blast data from one
port
> to another and expect it to work.

Isn't it? Are you really sure about that? I thought UDP was the
not-guaranteed-one and TCP was the one guaranting that all data reaches the
other end in order and all. Please enlighten me.

