Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293646AbSCPJA4>; Sat, 16 Mar 2002 04:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310178AbSCPJAr>; Sat, 16 Mar 2002 04:00:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46098 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293646AbSCPJAp>;
	Sat, 16 Mar 2002 04:00:45 -0500
Message-ID: <3C930993.1020909@mandrakesoft.com>
Date: Sat, 16 Mar 2002 04:00:03 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
        mochel@osdl.org
Subject: Re: [PATCH] devexit fixes in i82092.c
In-Reply-To: <Pine.LNX.4.33.0203160010510.2448-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>We could make one of the methods be "startup", of course, and move the
>actual device initialization there (and leave just the "find driver" in
>the initcall logic), but that would not get rid of the initcalls, it would
>just split them into two parts.
>
doing this has been mentioned independently a couple times, in fact...

And this may be a tangent, or maybe not:  like I was trying to explain 
to Gerard about regarding SCSI devices, it is often valuable to separate 
the two steps.  Gerard complained about the new PCI API not being able 
to register devices (_register_, not probe) in the order he wished.  And 
my response was... sure you can.  Just break it up into two steps, find 
devices, and register devices.  The ordering of the register calls in 
the second step are entirely up the driver and/or subsystem.  Similarly, 
the IDE subsystem could handle the mapping of the BIOS-ordered 
/dev/hd[a-d] completely independently of probing and registering hosts 
and devices.  [which, in turn, is useful in moving to a more dynamic 
/dev among other things]  Right now the IDE probe order is a bit 
delicate, and full of hueristics that could be cleaned up with such a 
separation.

    Jeff, in a rambling mood




