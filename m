Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129880AbRAPRZz>; Tue, 16 Jan 2001 12:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129523AbRAPRZp>; Tue, 16 Jan 2001 12:25:45 -0500
Received: from host194.steeleye.com ([216.33.1.194]:48136 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S129401AbRAPRZf>; Tue, 16 Jan 2001 12:25:35 -0500
Message-Id: <200101161724.f0GHOnE01880@aslan.sc.steeleye.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Brian Gerst <bgerst@didntduck.org>
cc: Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'David Woodhouse'" <dwmw2@infradead.org>,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux not adhering to BIOS Drive boot order? 
In-Reply-To: Message from Brian Gerst <bgerst@didntduck.org> 
   of "Tue, 16 Jan 2001 12:04:57 EST." <3A647F39.EC62BB81@didntduck.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Jan 2001 12:24:49 -0500
From: Eddie Williams <Eddie.Williams@steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Why does the end-user have to compile the kernel?  Most distributions
> provide a kernel with no SCSI drivers in it, but use an initrd to get
> the root SCSI driver in (man mkinitrd on any Redhat box).  Just
> distribute all SCSI drivers as modules and you won't have any problems.
> 

That is not totally true.  There are two problems here, one is where you have 
different controllers in your system and the other is where you have multiples 
of the same controller.  What you list above solves the different controller 
problem.  By loading the drivers in the right order you will get predictable 
results.  However when having multiples of the same controller you are only 
loading one driver so you are at the mercy of the way that driver was 
developed.  Some drivers give you ways to work around this others do not.

For example the aic7xxx.c (current one at least - I have not played with the 
Beta one enough to know what it does) lets you play with the order by turning 
BIOS off on the cards that you don't want to BOOT from.  So the aic7xxx driver 
sorts the controllers with BIOS enabled first.  This solves the problem where 
you have multiple adaptec controllers in the same box to make sure you have 
the "boot" controller first.  This, however, does not solve a third problem 
where you have multiple disks on that controller.  My recommendation is that 
you always install on ID 0 since that will be the "first" one found.  If you 
install on ID 1 and you add ID 0 then you just broke your boot.  If you 
install on ID 1 where there was an ID 0 (so you install to sdb) then if ID 0 
dies, get pulled, etc then you can boot because ID 1 is now ID 0.

So though I do agree that making all drivers modules usually simplifies 
handling this there are still issues and solving these I do agree today is 
beyond the scope for the unexperienced.

Eddie

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
