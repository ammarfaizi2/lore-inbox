Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154927AbPIBWIX>; Thu, 2 Sep 1999 18:08:23 -0400
Received: by vger.rutgers.edu id <S154935AbPIBVx5>; Thu, 2 Sep 1999 17:53:57 -0400
Received: from stm.lbl.gov ([131.243.16.51]:3362 "EHLO stm.lbl.gov") by vger.rutgers.edu with ESMTP id <S154929AbPIBVnR>; Thu, 2 Sep 1999 17:43:17 -0400
Date: Thu, 2 Sep 1999 14:42:51 -0700
From: David Schleef <ds@stm.lbl.gov>
To: Gerard Roudier <groudier@club-internet.fr>
Cc: Paul Ashton <lk@mailandnews.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.rutgers.edu
Subject: Re: Shared interrupt (lack of) handling
Message-ID: <19990902144251.A32648@stm.lbl.gov>
References: <19990902104044.A31769@stm.lbl.gov> <Pine.LNX.3.95.990902205502.393A-100000@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.3.95.990902205502.393A-100000@localhost>; from Gerard Roudier on Thu, Sep 02, 1999 at 09:41:48PM +0200
Sender: owner-linux-kernel@vger.rutgers.edu

On Thu, Sep 02, 1999 at 09:41:48PM +0200, Gerard Roudier wrote:
> > 
> > I'd vote for changing the return value of the interrupt handlers to
> > (int), and return a I_DID_SOME_STUFF flag.  That way, if none of the
> 
> This does not make sense at all for PCI.
> 
> In PCI, INTERRUPT ARE NOT SYNCHRONISATION EVENTS!  Synchronisation events
> are PCI TRANSACTIONS in the context of ordering rules defined by the
> specs, but unfortunately only a few hardware implemented that stuff
> correctly. People that think interrupts as synchronisations events are not
> able to write PCI device drivers that will work reliably in presence of
> posted transactions. A PCI interrupt just kicks the driver code that has
> then to synchronize correctly with de device, both using PCI transactions
> and relying on PCI ordering rules (or the subset available on the involved
> hardware). 


I appear to be missing something.  What do PCI synchonization issues
have anything to do with a driver giving the OS hints?  The delivery
of interrupts to the handlers would not change, but only that messages
*might* get printk'd if an interrupt occurs and no handler thinks that
the interrupt belongs to it.  How often do spurious interrupts occur
in a correctly functioning computer that shares interrupts between,
say, a NIC and SCSI card?

One thing that you could do with the I_DID_SOME_STUFF flag is use the
statistics to reorder the execution of interrupt handlers so that the
device that causes the most interrupts gets called first.  Might be
cool, difficult to tell.




dave...


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
