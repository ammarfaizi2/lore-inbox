Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156694AbPLTNzV>; Mon, 20 Dec 1999 08:55:21 -0500
Received: by vger.rutgers.edu id <S156515AbPLTNzH>; Mon, 20 Dec 1999 08:55:07 -0500
Received: from granada.iram.es ([150.214.224.100]:4668 "EHLO granada.iram.es") by vger.rutgers.edu with ESMTP id <S156897AbPLTNyQ>; Mon, 20 Dec 1999 08:54:16 -0500
Date: Mon, 20 Dec 1999 14:57:21 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Gerard Roudier <groudier@club-internet.fr>
Cc: Jes Sorensen <Jes.Sorensen@cern.ch>, Linux <linux-kernel@vger.rutgers.edu>
Subject: Re: readX/writeX semantic and ordering
In-Reply-To: <Pine.LNX.3.95.991220141721.1274A-100000@localhost>
Message-ID: <Pine.HPX.4.10.9912201420040.4055-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



On Mon, 20 Dec 1999, Gerard Roudier wrote:

> > All PPC snoop (the data and L2 cache) provided the host bridge flags the
> > accesses it performs on behalf of PCI devices as global (with the GBL bus
> > signal). Setting or not this signal is an option on some bridges but you
> > can safely assume that it will be set since it makes things much simpler
> > (otherwise you'd have to explicitly flush the caches).
> 
> Could I suggest the kernel to be made careful about that, if detection is 
> possible, and warn about misconfiguration.
> I have been reported some problem on the G3 that seems to disappear when 
> the cache is set write-through. Could a bridge misconfiguration explain 
> that ?

It could, but changing the cache to write through has other side effects
and potential slowdowns so I would never swear that this is the actual
cause. Note that the only bridges which I know to have programmable
processor cache snoop are the Raven and Hawk from Motorola which are only
used in boards from Motorola computer group (MVME, MTX...).

> The current readX/writeX implementation does eieio (that's full chinese to
> me, especially when I try to pronounce it;-)) after MMIOing.  The
> sym53c8xx driver knows about (since I teached it about :)) and performs
> mb() = "sync" for PPC in places when ordering between MMIO and memory
> accesses has to be guaranteed. This works on paper but has been reported
> not to be enough with some G3 (cache snooping against DMA is assumed).

Try to pronounce eieio in English and not in French (being french myself,
I can appreciate how horrible it sounds) it becomes much funnier,
epscially when accompanied with the right tune ;-) 

Do you have any pattern about which type of G3 (uP revision, size of
backside L2 cache, output of lspci, especially host bridge) ?

> A single micro-second (hundreds of cycles) per IO does not make difference
> with SCSI when mastering and a single interrupt per IO is possible. I (and
> user) can invest this micro-second per IO for the system to work reliably.
> I may end-up differentiating arch at driver level if needed, but this
> requires me to learn about all of them. If I add everything needed for
> PCI, SCSI and freinds, may-be I should overclock my brain in order to deal
> properly with all of that. :-)

I agree for an SCSI driver, my case was obviously completely different,
where saving a few hundred nanoseconds from a total of 3 microseconds was
noticeable...

> > Ok, I've put them on ftp://vlab1.iram.es/pub/ppcdocs since it's too big
> > for email (even private, I never considered posting it to the list).
> 
> Thanks very much. I have downloaded them, but haven't had time for now to
> look into them.

BTW: I also found yesterday a programming environment manual on
www.chips.ibm.com but I did not have time to download to see if it is more
recent or not (I'm in a hurry leaving for Christmas holiday, a whole week
without any net connection).

	Regards,
	Gabriel.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
