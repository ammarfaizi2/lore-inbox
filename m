Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263376AbSJFKte>; Sun, 6 Oct 2002 06:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263377AbSJFKte>; Sun, 6 Oct 2002 06:49:34 -0400
Received: from 62-190-200-32.pdu.pipex.net ([62.190.200.32]:17669 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S263376AbSJFKtd>; Sun, 6 Oct 2002 06:49:33 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210061103.g96B3mlO001484@darkstar.example.net>
Subject: Re: QLogic Linux failover/Load Balancing ER0000000020860
To: masterlee@digitalroadkill.net (GrandMasterLee)
Date: Sun, 6 Oct 2002 12:03:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1033900283.6413.27.camel@localhost> from "GrandMasterLee" at Oct 06, 2002 05:31:54 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Linux is not allowed to address LUNs out of sequence, so searching for
> > > > further LUN numbers stops after 0, since 2 is the next one. 
> > 
> > That's not true:
> > 
> > CONFIG_SCSI_REPORT_LUNS:
> > 
> > If you want to build with SCSI REPORT LUNS support i the kernel, say Y
> > here.
> > The REPORT LUNS command is useful for devices (such as disk arrays) with
> > large numbers of LUNs where the LUN values are not contiguous (sparse LUN).
> > REPORT LUNS scanning is done only for SCSI-3 devices.
> 
> I believe my kernel has that configured. I will look when I wake. It's
> 530 am now, and I've been setting up my volumes for a while now. Just
> about time to go to sleep, then wake up and install oracle. :)

All night hacking sessions, are cool :-).

> > > > Is there a way to resolve this, either at the driver level, IMHO the
> > > > place it *should* happen. At the storage level, the place that it could
> > > > also happen, or in the Kernel?
> > 
> > This is new in 2.5.x
> > 
> 
> 
> I see. ATM I'm using 2.4.19, but would like to get to 2.4.20, because of
> the TG3 fixes. 

You were probably thinking of CONFIG_SCSI_MULTI_LUN above, then.  That causes the kernel to probe all LUNs instead of just LUN 0, which is the default due to a lot of broken devices to respond to all LUNs instead of just LUN 0.  The sparse LUN option is in addition to that in 2.5.x.

If this is for a live server, it might be easiest to hard code the LUNs you need it to probe in to 2.4.x for now, and wait until 2.6.x for proper support.

John.
