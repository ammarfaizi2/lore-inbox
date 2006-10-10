Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbWJJGwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWJJGwg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 02:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWJJGwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 02:52:36 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.143]:54342 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S965042AbWJJGwf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 02:52:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC PATCH] nForce4 ADMA with NCQ: It's aliiiive..
Date: Mon, 9 Oct 2006 23:52:34 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B018E8171B@hqemmail02.nvidia.com>
In-Reply-To: <4527C7AB.9080801@garzik.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH] nForce4 ADMA with NCQ: It's aliiiive..
Thread-Index: AcbqJVvqilpedgsaSpWKQsR977Hn+wCEmT5w
From: "Allen Martin" <AMartin@nvidia.com>
To: "Jeff Garzik" <jeff@garzik.org>, "Robert Hancock" <hancockr@shaw.ca>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
       <prakash@punnoor.de>
X-OriginalArrivalTime: 10 Oct 2006 06:52:23.0593 (UTC) FILETIME=[A3BB6990:01C6EC38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > -Jeff will probably cringe at how I implemented the 
> > bmdma_stop/start/status/setup functions. This kludge of toggling 
> > ATA_FLAG_MMIO off for the call into libata was needed since this 
> > controller is almost what libata calls ATA_FLAG_MMIO, but not quite 
> > (the ATA taskfile registers are MMIO but the BMDMA 
> registers are PIO). 
> > This is also why I needed the patch to libata-sff.c to use the 
> > adapter's bmdma_status function rather than hardcoded 
> ata_bmdma_status.
> 
> *shrug*  I don't cringe if that's the most expedient way to 
> do something.
> 
> But I really don't think that is necessary.  I will take a 
> look at docs and see how things match up, when I am much more 
> awake.  Most likely you need to be using another set of 
> registers, and be all MMIO, all the time.

You shouldn't be touching BM registers when ADMA is enabled, it can
cause bad things to happen.

You should be using BM registers when doing ATAPI protocol though, as it
doesn't work through ADMA.  So I wouldn't say you should be using MMIO
all the time.

-Allen
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
