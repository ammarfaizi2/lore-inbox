Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWFSVrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWFSVrt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 17:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWFSVrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 17:47:48 -0400
Received: from web50207.mail.yahoo.com ([206.190.38.48]:14763 "HELO
	web50207.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964912AbWFSVrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 17:47:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=5pcRs4yz1FpLA4s2FbAc6hXczKzxVdLvKjeDYWiXTcScuYMzqzclSv7iSf665VvEv+wEObh+TBth6wMI9hjJRKr96s7EsGcPpmLEBPzplzyZH4lipJ1bwF8tgfLZLYYxYd7lRCy5Re7BQspxlb0NyQh1oiC4D5BuQd0GgSsQoCY=  ;
Message-ID: <20060619214746.89919.qmail@web50207.mail.yahoo.com>
Date: Mon, 19 Jun 2006 14:47:46 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: Kernel panic when re-inserting Adaptec PCMCIA card
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
In-Reply-To: <200606190600_MC3-1-C2D8-23E6@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Chuck Ebbert <76306.1226@compuserve.com> wrote:

> In-Reply-To: <20060614022139.21737.qmail@web50208.mail.yahoo.com>
> 
> On Tue, 13 Jun 2006 19:21:39 -0700, Alex Davis wrote:
> 
> Same panic occurs in 2.6.17rc6:
> 
> > Jun 13 17:50:36 siafu kernel: [4295220.230000] pccard: PCMCIA card inserted into slot 0
> > Jun 13 17:50:36 siafu kernel: [4295220.230000] pcmcia: registering new device pcmcia0.0
> > Jun 13 17:50:37 siafu kernel: [4295220.281000] aha152x: resetting bus...
> > Jun 13 17:50:37 siafu kernel: [4295220.637000] aha152x13: vital data: rev=1, io=0xd340
> > (0xd340/0xd340), irq=3, scsiid=7, reconnect=enabled,
> >  parity=enabled, synchronous=enabled, delay=100, extended translation=disabled
> > Jun 13 17:50:37 siafu kernel: [4295220.637000] aha152x13: trying software interrupt, ok.
> > Jun 13 17:50:37 siafu kernel: [4295221.638000] scsi13 : Adaptec 152x SCSI driver; $Revision:
> 2.7 $
> > Jun 13 17:50:37 siafu kernel: [4295221.650000]
> > Jun 13 17:50:37 siafu kernel: [4295221.650000] aha152x22856: bottom-half already running!?
> > Jun 13 17:50:37 siafu kernel: [4295221.650000]
> > Jun 13 17:50:37 siafu kernel: [4295221.650000] queue status:
> > Jun 13 17:50:37 siafu kernel: [4295221.650000] issue_SC:
> > Jun 13 17:50:37 siafu kernel: [4295221.650000] current_SC:
> > Jun 13 17:50:37 siafu kernel: [4295221.650000] BUG: unable to handle kernel paging request at
> > virtual address 00020016
> 
> Something is going very wrong here.  At time .637 it says it is
> adapter number 13 (aha152x13.)  Then at .650 it thinks it's
> adapter nr. 22856 (!)  Looks like some kind of pointer to the
> hostdata is corrupted.
> 
> Can you rmmod the driver after removing the card and see if that
> helps?
> 
It turns out I was trying to remove the driver before doing 'pccardctl eject'.

It seems that removing the driver after ejecting make the problem go away:
I ejected and re-inserted the card six times with no crash.

I'll continue testing just to make sure.

I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
