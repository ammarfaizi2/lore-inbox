Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWHDDpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWHDDpq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 23:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWHDDpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 23:45:45 -0400
Received: from mms1.broadcom.com ([216.31.210.17]:37642 "EHLO
	mms1.broadcom.com") by vger.kernel.org with ESMTP id S1030240AbWHDDpo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 23:45:44 -0400
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
Date: Thu, 3 Aug 2006 20:45:31 -0700
Message-ID: <1551EAE59135BE47B544934E30FC4FC093FA11@NT-IRVA-0751.brcm.ad.broadcom.com>
In-Reply-To: <20060804032348.GA16313@thunk.org>
Thread-Topic: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
thread-index: Aca3dX8GoMaN7wr9QW29OUTK9hjPCAAAbyVQ
From: "Michael Chan" <mchan@broadcom.com>
To: "Theodore Tso" <tytso@mit.edu>
cc: "David Miller" <davem@davemloft.net>, herbert@gondor.apana.org.au,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006080401; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413031303230332E34344432433236362E303031382D422D2F342B574C684A754433704B705975633943514C71513D3D;
 ENG=IBF; TS=20060804034536; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006080401_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 68CC1D540HW63185381-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:

> Parden me for asking a dumb question, but what's being accomplished by
> resetting the chip if the system has crashed?  Why not reset the chip
> when the system reboots and it sees the PCI bus reset?  I guess I'm
> missing the purpose of the ASF heartbeat; why does the networking chip
> need a chip-specific watchdog?
> 

ASF is firmware that monitors the system and sends out alerts whenever
certain events happen.  So it needs to run before the OS boots or after
it has crashed.  When the driver is up and running, the driver and ASF
run independently sending and receiving traffic on the same wire.  Of
course, the bandwidth that is used by ASF is a very tiny fraction of the
host traffic.  If the system crashes, the FIFO and other resources on
the NIC will be backed up and ASF can no longer function without
resetting
the chip.

As David explained, ASF is only used on servers.

