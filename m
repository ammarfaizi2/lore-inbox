Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312488AbSCUUuN>; Thu, 21 Mar 2002 15:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312491AbSCUUuD>; Thu, 21 Mar 2002 15:50:03 -0500
Received: from web10103.mail.yahoo.com ([216.136.130.53]:29496 "HELO
	web10103.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312488AbSCUUtv>; Thu, 21 Mar 2002 15:49:51 -0500
Message-ID: <20020321204951.35236.qmail@web10103.mail.yahoo.com>
Date: Thu, 21 Mar 2002 12:49:51 -0800 (PST)
From: Ivan Gurdiev <ivangurdiev@yahoo.com>
Subject: Re: Via-Rhine stalls - transmit errors
To: Andy Carlson <naclos@andyc.dyndns.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if ((intr_status & ~( IntrLinkChange | IntrStatsMax |
 IntrTxAborted ))) {
   if (debug > 1)
   	printk(KERN_ERR "%s: Something Wicked happened!
%4.4x.\n",dev->name, intr_status);
 /* Recovery for other fault sources not known. */
  writew(CmdTxDemand | np->chip_cmd, dev->base_addr +
ChipCmd);
        }

What's classified as "Something Wicked" ?

Mar 20 21:52:00 cobra kernel: eth0: Something Wicked 
happened! 0008. 

This is tx abort isn't it?

Mar 20 21:51:59 cobra kernel: eth0: Something Wicked 
happened! 001a. 

...and this should be : tx underrun, tx abort, tx done

are those supposed to be logged as "Wicked"?
Those interrupts are handled earlier aren't they? 
        if (intr_status & (underflow | IntrTxAbort))
	...
	if (intr_status & IntrTxUnderrun) {
	...


I'm quite ignorant of all this, but I'm trying to
learn. I apologize if this is a stupid question.




__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards®
http://movies.yahoo.com/
