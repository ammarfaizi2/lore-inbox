Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290855AbSARWcu>; Fri, 18 Jan 2002 17:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290857AbSARWci>; Fri, 18 Jan 2002 17:32:38 -0500
Received: from e23.nc.us.ibm.com ([32.97.136.229]:33951 "EHLO
	e23.esmtp.ibm.com") by vger.kernel.org with ESMTP
	id <S290855AbSARWce>; Fri, 18 Jan 2002 17:32:34 -0500
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFA503EFC2.D11026CD-ON85256B45.007B6E25@raleigh.ibm.com>
From: "Kent E Yoder" <yoder1@us.ibm.com>
Date: Fri, 18 Jan 2002 16:32:31 -0600
X-MIMETrack: Serialize by Router on D04NM109/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 01/18/2002 05:32:33 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Sorry, this mail was sent acidentally...  but since its out here...

> 5 & 11) Nope, I had not read Doc/networking/netdevices.txt, so I have a
question.  What does being inside rtnl_lock() imply other than the sleep
> issues?
>
>   The calls to cli() and save_flags() were wrong from the beginning.
They were imported by the last maintainer since this driver is a modified
version  > of the olympic token ring driver.  The current spin_lock() and
spin_unlock() calls protect the srb_queued variable.  If we were to set it
to one and then  > get interrupted before we actually write() to the srb,
the interrupt function will try to service whatever junk happens to be in
the srb.  If going into the
> interrupt function is covered by rtnl_lock(), this would be covered, but
I guess its not (?)....

  actually I should be using spin_lock_irqsave() in open() and close()
since the lock is taken inside the interrupt function, no?

Kent

