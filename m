Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291145AbSBLPvL>; Tue, 12 Feb 2002 10:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290276AbSBLPvB>; Tue, 12 Feb 2002 10:51:01 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:37611 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S288511AbSBLPu4>; Tue, 12 Feb 2002 10:50:56 -0500
Message-ID: <3C693BA0.43104E47@nortelnetworks.com>
Date: Tue, 12 Feb 2002 10:58:24 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David L. Parsley" <parsley@roanoke.edu>
Cc: Andi Kleen <ak@suse.de>, Stefan Rompf <srompf@isg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Interface operative status detection
In-Reply-To: <3C498CC9.6FAED2AF@isg.de.suse.lists.linux.kernel> <p73g0525je4.fsf@oldwotan.suse.de> <3C692C1C.7090107@roanoke.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David L. Parsley" wrote:

> Is there a good way for a dhcp daemon to find out whether the laptop is
> connected to the network or not?  It'd be really sweet if dhcpcd could:
> 
> - down the interface and remove routes whenever the network cable was
> unplugged
> - wait for the interface to get link beat again, and send a new request
> 
> This would greatly enhance desktop usability.  I'd be happy to do the
> dhcpcd hacking if the right kernel interfaces were available.

If the network driver supports querying of the MII registers (usually done with
the private ioctl stuff) then you can query the link beat from userspace.

Depending on the driver/chip this may be a very fast query, or it may take
upwards of 100us with interrupts disabled.

I can post example code if you like...

Now what I would *really* like to see would be a way to get asynchronous
notification of userspace processes on link beat change.   Of course, depending
on NIC this would require an interrupt handler or a kernel thread periodically
checking the link state, as well as some way to pass that information to the
user (netlink socket, interrupt...not sure what the best would be).

Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
