Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbTDCVXq 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 16:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263557AbTDCVXq 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 16:23:46 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:9229 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261413AbTDCVXp convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 16:23:45 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] reduce stack in cpqarray.c::ida_ioctl()
Date: Thu, 3 Apr 2003 15:35:07 -0600
Message-ID: <45B36A38D959B44CB032DA427A6E10640451339D@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] reduce stack in cpqarray.c::ida_ioctl()
Thread-Index: AcL6JwBHguRA/DmjTN6Ar+zm2r7FzQAAEKnQ
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "Arrays" <arrays@hp.com>
X-OriginalArrivalTime: 03 Apr 2003 21:35:08.0335 (UTC) FILETIME=[E5F32BF0:01C2FA28]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well, my questions were along those lines, like:
> . allocate a buffer per hba or per disk?

I don't think the number of concurrent ioctls 
apps might try to send is governed by number of
hba's or number of disks (which are virtualized)
or number of physical disks (which the driver doesn't
know.)  It's whatever the apps want to try to send
down.

> . how much is ida_ioctl() [passthru] used?

Not much by most people, I expect. It's not in
the main i/o path, definitely.

it's used by things like our online Array Config Utility
(for configuring new volumes after adding new hardware
such as hot plugging some disks into a storage box...)

Also used by Compaq Insight Manager agents for 
monitoring.

Flashing HBA firmware...

> . it's not on a normal(!?!) read path, is it?

no.

>  if so, using kmalloc() that could fail would be a bad idea.

--
~Randy
