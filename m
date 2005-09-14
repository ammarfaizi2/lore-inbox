Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbVINE5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbVINE5b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 00:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbVINE5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 00:57:31 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:47801 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932624AbVINE5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 00:57:30 -0400
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
	(end devices)
From: Sergey Panov <sipan@sipan.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Luben Tuikov <ltuikov@yahoo.com>, Christoph Hellwig <hch@infradead.org>,
       Douglas Gilbert <dougg@torque.net>,
       Patrick Mansfield <patmans@us.ibm.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>
In-Reply-To: <20050913203611.GH32395@parisc-linux.org>
References: <1126308304.4799.45.camel@mulgrave>
	 <20050910024454.20602.qmail@web51613.mail.yahoo.com>
	 <20050911094656.GC5429@infradead.org> <43251D8C.7020409@torque.net>
	 <1126537041.4825.28.camel@mulgrave> <20050912164548.GB11455@us.ibm.com>
	 <1126545680.4825.40.camel@mulgrave> <20050912184629.GA13489@us.ibm.com>
	 <1126639342.4809.53.camel@mulgrave> <4327354E.7090409@adaptec.com>
	 <20050913203611.GH32395@parisc-linux.org>
Content-Type: text/plain
Organization: Home
Date: Wed, 14 Sep 2005 00:57:24 -0400
Message-Id: <1126673844.26050.24.camel@sipan.sipan.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-13 at 14:36 -0600, Matthew Wilcox wrote: 
> 
> Could you explain the difference please?  Why is it preferable to keep
> the LUN as an array of bytes instead of a single large integer?
> 

Because set of valid LUN id represented by 8 byte combinations is not
isomorphic to the set of unsigned int values from 0 to UINT64_MAX. While
scsilun_to_int() will convert legal LUN id into some integer, the
int_to_scsilun() function will not produce legal  LUN id for any
arbitrary integer lun value. 

For example, sequential LUN scanning should be stopped at int lun = 255
because result of converting value 256 by int_to_scsilun() will be
either illegal(best case) or equivalent to int lun  = 0.

LUN id should be presented to the management layers in a way similar to
MAC addresses or FC/SAS/... WWN . E.g. the usual LUN 4  on some FC
device will be identified by something like (in 00b, or "Peripheral
device addressing"):

WWPN = 22:00:00:0c:50:05:df:6d
LUN  = 00:04:00:00:00:00:00:00


Interestingly enough, the following is also LUN = 4 device, but in a
different addressing mode (01b, AKA "Logical unit addressing"):

WWPN = 22:00:00:0c:50:05:df:6d
LUN  = 40:04:00:00:00:00:00:00


Sergey Panov

======================================================================
Any opinions are personal and not necessarily those of my former,
present, or future employers.






