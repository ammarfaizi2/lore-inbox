Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129424AbRCFUl1>; Tue, 6 Mar 2001 15:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129419AbRCFUlR>; Tue, 6 Mar 2001 15:41:17 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:57092 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S129424AbRCFUlH>; Tue, 6 Mar 2001 15:41:07 -0500
Message-Id: <200103062040.f26KehO07876@aslan.scsiguy.com>
To: Doug Ledford <dledford@redhat.com>
cc: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>,
        LK <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.3 and new aic7xxx 
In-Reply-To: Your message of "Tue, 06 Mar 2001 15:09:47 EST."
             <3AA5440B.8FAAB728@redhat.com> 
Date: Tue, 06 Mar 2001 13:40:43 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Can you provide me with a dmesg from a boot with aic7xxx=verbose?
>> I just tested this on a 3940AUW and the behavior was as expected.
>> Perhaps you have a motherboard based controller that has no seeprom?
>> I don't know how to detect flipped channels in that configuration
>> but I'll see what I can find out.
>
>Your driver uses the new PCI probe code, so there is no gaurantee that you'll
>see channel A before channel B.

Unless he's actually hot-plugging the card, I am guarnateed to see both
the A and the B channel prior to actually registering with the SCSI subsystem
and from looking at the PCI probe code, function 0 is always added to the
pci device list before function 1.  It is true that my adapter sorting
code assumes that function 0 is seen prior to function 1, but I don't see
(yet) how that assumption is violated.  Since getting rid of the assumption
is easy enough, I'll do that.  All of the sorting stuff only works for devices
in the system at driver initialization.  In the hot plug case, you don't know
that more adapters will show up, so there is no way to defer registration like
you can on initial driver startup.

--
Justin
