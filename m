Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVILTME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVILTME (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 15:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbVILTME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 15:12:04 -0400
Received: from emulex.emulex.com ([138.239.112.1]:39627 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S1750895AbVILTMB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 15:12:01 -0400
From: James.Smart@Emulex.Com
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process (end devices)
Date: Mon, 12 Sep 2005 15:04:03 -0400
Message-ID: <9BB4DECD4CFE6D43AA8EA8D768ED51C20F459D@xbl3.ma.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process (end devices)
Thread-Index: AcW3yx0aSh+ho82oRrKRLQDj84qDBwAAQ6tg
To: <patmans@us.ibm.com>, <James.Bottomley@SteelEye.com>
Cc: <dougg@torque.net>, <hch@infradead.org>, <ltuikov@yahoo.com>,
       <luben_tuikov@adaptec.com>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Though we still have problems with scsi_report_lun_scan code like:
> 
>                 } else if (lun > sdev->host->max_lun) {
> 
> max_lun just has to be large, at least greater than 0xc001 
> (49153), maybe
> even 0xffffffff, correct?

right...

> 
> But then some sequential scanning could take a while. Maybe the above
> check is not needed.
> 
> lpfc has max_luns set to 256, with max limited to 32768, I 
> don't know how
> it could be working OK here. (Has James S or anyone tested this?)

Yes we did test this (actually, we tested out to 64k). Time to perform all
this looping, plus impacts due on sg devices (some configs generate huge
numbers - outside of sg's range), made us pull back to 256 - although it's
tunable.

-- james s 
