Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269666AbUIRXPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269666AbUIRXPc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 19:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269667AbUIRXPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 19:15:32 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:47378 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S269666AbUIRXO7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 19:14:59 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Patch][RFC] conflicting device major numbers in devices.txt
Date: Sat, 18 Sep 2004 18:14:52 -0500
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD108F82153@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch][RFC] conflicting device major numbers in devices.txt
Thread-Index: AcSdy2JC/nYIgIdYQQqeKbuYdELTXAAByqdw
From: "Cagle, John" <john.cagle@hp.com>
To: "Christian Borntraeger" <linux-kernel@borntraeger.net>,
       <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Torben Mathiasen" <device@lanana.org>
Cc: <dwmw2@infradead.org>, <linux-mtd@lists.infradead.org>
X-OriginalArrivalTime: 18 Sep 2004 23:14:54.0418 (UTC) FILETIME=[4E857320:01C49DD5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Christian Borntraeger [mailto:linux-kernel@borntraeger.net] 
> Sent: Saturday, September 18, 2004 5:04 PM
> To: linux-kernel@vger.kernel.org; Andrew Morton; Torben Mathiasen
> Cc: Cagle, John
> Subject: [Patch][RFC] conflicting device major numbers in devices.txt
> 
> Hi all,
> 
> some month ago a change to Documentation/devices.txt was 
> submitted by John 
> Cagle. 
> 
> http://linux.bkbits.net:8080/linux-2.6/cset%4040586a32fpYGPUC8
> ysFeU7GIfmmdUA
> 
> The patch changed the major number of the s/390 dasd devices 
> from 94 to 95. 
> As you can see in include/major.h and 
> drivers/s390/block/dasd.c the change 
> to the documentation was bogus. The dasd device driver was 
> using and will 
> be using major number 94. 
> 
> Unfortunately, the "Inverse NAND Flash Translation Layer", 
> which was added 
> somewhen during 2.5 now uses the same major number.
> 
> I attached a patch to restore the old state but I am not 
> sure, how to deal 
> with the inftla driver. 
> 
> 
> Patch to restore the old state
<snip>

Christian,

Good catch.  The patch that originally corrected this (which is
contained within the bitkeeper patch you can view at
http://tinyurl.com/34zoy ) never made it to LANANA, so the
correction of dasd from 95 to 94 was never in our repository.
The recent update of devices.txt into the 2.5 kernel came from
our repository so it contains the same error.

I'm copying David Woodhouse and the Linux-MTD project who (I
think) are the maintainers of the inftl driver.  Hopefully, they
will be kind enough to accept a new block major for the inftl
driver.  If not, there's probably little chance of device conflict
in real-world use, since intftl is for embedded systems which
probably will not be attached to S/390 storage devices.

Torben -- please correct this in devices.txt and find a new block
major for the Linux-MTD project (if they will accept it).

Thanks,
John Cagle
(former LANANA maintainer)
