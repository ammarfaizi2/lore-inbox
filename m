Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263010AbVALCNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263010AbVALCNA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 21:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbVALCMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 21:12:37 -0500
Received: from main.gmane.org ([80.91.229.2]:63661 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263004AbVALCL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 21:11:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jim Zajkowski <jamesez@umich.edu>
Subject: Re: Sparse LUN scanning - 2.4.x
Date: Tue, 11 Jan 2005 21:11:40 -0500
Message-ID: <cs210t$l8m$1@sea.gmane.org>
References: <41E46A59.2010205@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dsl093-002-011.det1.dsl.speakeasy.net
User-Agent: Unison/1.5.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-01-11 19:07:53 -0500, Michael Clark <michael@metaparadigm.com> said:

>> The problem is this: since LUN 0 does not show up -- specifically, it 
>> can't read the vendor or model informaton -- the kernel SCSI scan does 
>> not match with the table to tell the kernel to do sparse LUN 
>> scanning... so the RAID does not appear.

> Add the Xserve with the BLIST_SPARSELUN flag into the blacklist/quirks 
> table in drivers/scsi/scsi_scan.c

It already is in the quirks list.

The problem is that LUN 0 does not show up on this machine, so the 
quirks table doesn't work.  Looking at /proc/scsi/scsi shows the device 
but only sorta:

> Host: scsi1 Channel: 00 Id: 00 Lun: 00
>   Vendor:          Model:                  Rev:
>   Type:   Processor                        ANSI SCSI revision: ffffffff

whereas the LUN that is mapped shows up like this:

> Host: scsi1 Channel: 00 Id: 00 Lun: 01
>   Vendor: APPLE    Model: Xserve RAID      Rev: 1.20
>   Type:   Direct-Access                    ANSI SCSI revision: 02

So since the information doesn't show up, the quirks table magic 
doesn't work since it doesn't know that it needs to do a sparse lun 
scan.

--Jim

-- 
Jim Zajkowski          OpenPGP 0x21135C3    http://www.jimz.net/pgp.asc
System Administrator  8A9E 1DDF 944D 83C3 AEAB  8F74 8697 A823 2113 5C53
UM Life Sciences Institute


