Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWCQDLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWCQDLY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 22:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWCQDLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 22:11:23 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:6284 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964918AbWCQDLX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 22:11:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oToBMb5aRxooohkJOzAmQb4ZnWbbHS85ojV0NU6n/n87UJglQIm2NB5oRY7RtQFR7LC+aw8NqU2SAOfIv8F4bzfuESXKGcSTsocJZRsTGaMRSzUHKQEyy5r5A+6Ye04Ch9y7lHlTlrHNUqWSnx9aDM9/l/CzCGsNavVZdFspV5s=
Message-ID: <dda83e780603161911o7c2babb7wfc6671f9bc3441e4@mail.gmail.com>
Date: Thu, 16 Mar 2006 19:11:21 -0800
From: "Bret Towe" <magnade@gmail.com>
To: "Neil Brown" <neilb@suse.de>
Subject: Re: nfs udp 1000/100baseT issue
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <17434.7434.626268.71114@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <dda83e780603151424u1b3ea605vd6e8dea896fc276e@mail.gmail.com>
	 <Pine.LNX.4.61.0603162139450.11776@yvahk01.tjqt.qr>
	 <dda83e780603161733o10a3c330kddf96a726f162fa7@mail.gmail.com>
	 <17434.7434.626268.71114@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/06, Neil Brown <neilb@suse.de> wrote:
> On Thursday March 16, magnade@gmail.com wrote:
> > On 3/16/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> > > >
> > > >a while ago i noticed a issue when one has a nfs server that has
> > > >gigabit connection
> > > >to a network and a client that connects to that network instead via 100baseT
> > > >that udp connection from client to server fails the client gets a
> > > >server not responding
> > > >message when trying to access a file, interesting bit is you can get a directory
> > > >listing without issue
> > > >work around i found for this is adding proto=tcp to the client side
> > > >and all works
> > > >without error
> > >
> > > UDP has its implications, like silently dropping packets when the link
> > > is full, by design. Try tcpdump on both systems and compare what packets
> > > are sent and which do arrive. The error message is then probably because
> > > the client is confused of not receiving some packets.
> >
> > after compairing a working and not working client i found that
> > packets containing offset 19240, 20720, 22200 are missing
> > and the 100baseT client had an extra offset of 32560
> > on the working client it ends at 31080
> >
> > the missing ones are mostly constantly missing 22200 appears every so often
> > on retransmission and 23680 also disappears every so often
> >
> > i hope that isnt too confusing i dont use tcpdump type stuff much
> > (well i did give up on tcpdump and had to use ethereal...)
>
> This is all to be expected.  I remember having this issue with a
> server on 100M and clients in 10M...
>
> There is no flow control in UDP

is this a linux design flaw or just nature of udp?

>.  If anything gets lots, the client
> has to resend the request, and the server then has to respond again.
> If the respond is large (e.g. a read) and gets fragmented (if > 1500bytes)
> then there is a good chance that one or more fragments of a reply will
> get lots in the switch stepping down from 1G to 100M.  Every time.
>
> Your options include:
>
>   - use tcp

im wondering why this isnt the default to begin with

>   - get a switch with a (much) bigger packet buffer
>   - drop the server down to 100M
>   - drop the nfs rsize down to 1024 to you don't get fragments.
these last 2 options sound rather painfull speed wise
tcp work around is prob by far the easiest

>
> NeilBrown
>
