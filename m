Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbRBNUyg>; Wed, 14 Feb 2001 15:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131175AbRBNUy1>; Wed, 14 Feb 2001 15:54:27 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59153 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129136AbRBNUyU>; Wed, 14 Feb 2001 15:54:20 -0500
Subject: Re: IDE DMA Problems...system hangs
To: jsidhu@arraycomm.com (Jasmeet Sidhu)
Date: Wed, 14 Feb 2001 20:54:26 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jsidhu@arraycomm.com (Jasmeet Sidhu),
        linux-kernel@vger.kernel.org
In-Reply-To: <5.0.2.1.2.20010214123238.023ea9c0@pop.arraycomm.com> from "Jasmeet Sidhu" at Feb 14, 2001 12:40:01 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14T8wg-00061Z-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >You will get horribly bad performance off raid5 if you have stripes on both
> >hda/hdb  or hdc/hdd etc.
> 
> If I am reading this correctly, then by striping on both hda/hdb and 
> /hdc/hdd you mean that I have two drives per ide channel.  In other words, 
> you think I have a Master and a Slave type of a setup?  This is 
> incorrect.  Each drive on the system is a master.  I have 5 promise cards 

Ok then your performance should be fine (at least reasonably so, the lack
of tagged queueing does hurt)

> ide chanel, the penalty should not be much in terms of performance.  Maybe 
> its just that the hdparam utility is not a good tool for benchamarking a 
> raid set?

Its not a good raid benchmark tool but its a good indication of general problems.
Bonnie is a good tool for accurate assessment.

> disable DMA if its giving it a lot of problems, but it should not hang.  I 
> have been experiencing this for quite a while with the newer 
> kernels.  Should I try the latest ac13 patch?  I glanced of the changes and 
> didnt seem like anything had changed regarding the ide subsystem.

I've not changed anything related to DMA handling specifically. The current
-ac does have a fix for a couple of cases where an IDE reset on the promise
could hang the box dead. That may be the problem.

> Is there anyway I can force the kernel to output more messages...maybe that 
> could help narrow down the problem?

Ask andre@linux-ide.org. He may know the status of the promise support
