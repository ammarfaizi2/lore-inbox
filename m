Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261691AbSIXP4V>; Tue, 24 Sep 2002 11:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261696AbSIXP4V>; Tue, 24 Sep 2002 11:56:21 -0400
Received: from 62-190-216-177.pdu.pipex.net ([62.190.216.177]:9732 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261691AbSIXP4T>; Tue, 24 Sep 2002 11:56:19 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209241609.g8OG9deO000280@darkstar.example.net>
Subject: Re: scsi error.
To: alex14641@yahoo.com (Alex Davis)
Date: Tue, 24 Sep 2002 17:09:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020924153549.84703.qmail@web40510.mail.yahoo.com> from "Alex Davis" at Sep 24, 2002 08:35:49 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > You apparently have a Data Parity Error on your SCSI bus.  Probably your
> > > external SCSI drive has a cable or terminator problem.  You can confirm this
> > > by disconnecting the external SCSI cable to see if the other drives come up
> > > ok.  

> > > You may be missing some termination, either via an external terminator or by
> > > turning on the drive's TERMPWR jumper on the external drive (depending on
> > > the type of disk cabinet you have).  Or, the external SCSI cable may be
> > > faulty (usually bent pins).

> > Also, it could be that you are using a cable designed for a Mac - those cables often don't have
> > all of the GND lines individually connected, and can cause seemingly random problems.

> Problem solved. I didn't enable term power on the last drive in my SCSI chain.
> Errors gone now. Thanks.

Hmmm, that is a bit strange - you don't specifically need to enable term power on the last device on the chain - both ends have to be terminated, but any device can supply the termination power to the bus, and only one device needs to do that.  Usually all devices are configured to do that, but it is usually considered to be the host adaptor that can be relied on to provide term power.  The exceptions are usually parallel port SCSI adaptors, which cannot supply enough power.

In any case, there is no harm in all devices supplying term power, as they, (should), be protected with diodes to prevent wrong voltages reaching the devices.

Having said all that, if it's fixed the problem, great.  I would double check the following, though:

* Term power enabled on at least one device, (already done)
* Both ends terminated with ACTIVE terminators, (never EVER use passive terminators, they do NOT work reliably, they might work, but it really is worth paying the extra for active terminators.  Even the original SCSI spec suggested active terminators.  I think that passive terminators were a dinosaur from the days of SASI, (Shugart Associates System Interface), which is way, way, WAY back in time :-) ).
* Cable length does not exceed the recommended maximum, (1.5 metres for Ultra-SCSI).
* The cables are good quality
* Parity is enabled.

John.
