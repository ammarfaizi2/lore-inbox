Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269366AbUJFTdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269366AbUJFTdY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269384AbUJFTdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:33:24 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:65284 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S269366AbUJFTaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:30:55 -0400
Date: Wed, 6 Oct 2004 21:30:53 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Joris van Rantwijk <joris@eljakim.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041006193053.GC4523@pclin040.win.tue.nl>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl> <1097080873.29204.57.camel@localhost.localdomain> <Pine.LNX.4.58.0410061955230.7057@eljakim.netsystem.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410061955230.7057@eljakim.netsystem.nl>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 08:04:29PM +0200, Joris van Rantwijk wrote:

> > On Mer, 2004-10-06 at 15:52, Joris van Rantwijk wrote:
> > > My understanding of POSIX is limited, but it seems to me that a read call
> > > must never block after select just said that it's ok to read from the
> > > descriptor. So any such behaviour would be a kernel bug.

Alan answers - and I don't like his answer a bit:

> > Select indicates there may be data. That is all - it might also be an
> > error, it might turn out to be wrong.
> >
> > You should always combine select with nonblocking I/O

Joris replies again:

> Sorry about my wrongly blaming the kernel. I do think this issue shows hat
> the select(2) manual needs fixing.

It may need fixing in the sense that it must point out that the Linux kernel
might not conform to POSIX in its handling of select on sockets.

We now not only have "man 2 select", but also "man 3p select".
This is the POSIX text:

       A  descriptor shall be considered ready for reading when a
       call to an input function with O_NONBLOCK clear would  not
       block,  whether  or  not  the function would transfer data
       successfully. (The function might return data, an  end-of-
       file  indication,  or  an  error other than one indicating
       that it is  blocked,  and  in  each  of  these  cases  the
       descriptor shall be considered ready for reading.)

As far as I can interpret these sentences, Linux does not conform.

Andries


Neil Horman wrote:

>> I think you could also pass the MSG_ERRQUEUE flag to the recvfrom call 
>> and receive the errored frame, eliminating the case where errored frames 
>> might cause you to block on a read after a good return from a select call.

davem wrote:

>> There is no such guarentee.

>> Incorrect UDP checksums could cause the read data to
>> be discarded.  We do the copy into userspace and checksum
>> computation in parallel.  This is totally legal and we've
>> been doing it since 2.4.x first got released.


ahu wrote:

>> This can happen, and is fully to be expected. For a host of reasons the
>> packet might not in fact appear. Whenever using select for non-blocking IO
>> always set your sockets to non-blocking as well.

>> One of the legitimate reasons is the reception of packets which, on copying,
>> turn out to have a bad checksum.

>> Stevens has a section on this, recommended reading.

Reference?
