Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbVINF4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbVINF4l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 01:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbVINF4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 01:56:41 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:44784 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965022AbVINF4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 01:56:40 -0400
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
	(end devices)
From: Sergey Panov <sipan@sipan.org>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Luben Tuikov <luben_tuikov@adaptec.com>, Matthew Wilcox <matthew@wil.cx>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Douglas Gilbert <dougg@torque.net>,
       Christoph Hellwig <hch@infradead.org>, Luben Tuikov <ltuikov@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050913222519.GA1308@us.ibm.com>
References: <20050911094656.GC5429@infradead.org>
	 <43251D8C.7020409@torque.net> <1126537041.4825.28.camel@mulgrave>
	 <20050912164548.GB11455@us.ibm.com> <1126545680.4825.40.camel@mulgrave>
	 <20050912184629.GA13489@us.ibm.com> <1126639342.4809.53.camel@mulgrave>
	 <4327354E.7090409@adaptec.com> <20050913203611.GH32395@parisc-linux.org>
	 <43273E6C.9050807@adaptec.com>  <20050913222519.GA1308@us.ibm.com>
Content-Type: text/plain
Organization: Home
Date: Wed, 14 Sep 2005 01:22:46 -0400
Message-Id: <1126675366.26050.41.camel@sipan.sipan.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-13 at 15:25 -0700, Patrick Mansfield wrote:
> On Tue, Sep 13, 2005 at 05:02:36PM -0400, Luben Tuikov wrote:
> > On 09/13/05 16:36, Matthew Wilcox wrote:
> > > On Tue, Sep 13, 2005 at 04:23:42PM -0400, Luben Tuikov wrote:
> > > 
> > >>A SCSI LUN is not "u64 lun", it has never been and it will
> > >>never be.
> > >>
> > >>A SCSI LUN is "u8 LUN[8]" -- it is this from the Application
> > >>Layer down to the _transport layer_ (if you cared to look at
> > >>_any_ LL transport).
> 
> Not all HBA drivers implement a mapping to a SCSI transport, we have
> raid drivers and even an FC driver that has its own lun definition that
> does not fit any SAM or SCSI spec.

May I ask you to name those drivers/HBAs, it would be interesting to
look at how REPORT_LUN results are interpreted there. Actually, the data
from the  REPORT_LUN response is always treated as proper  8 byte LUN
and it is converted to int by scsilun_to_int(). What is interesting is
how those derivers/HBA treat integer "lun" in queuecommand or EH calls.

> I think the only HBA's today that can handle an 8 byte lun are lpfc and
> iscsi (plus new SAS ones).

I am not aware of any SCSI/FC/SAS/etc hardware which uses more then just
first two bytes, but all drivers I looked at to proper bytes
rearrangement for those two bytes, and, as a result they do support 00b
and 01b addressing modes.  

> So, we can't have one "LUN" that fits all, and it makes no sense to call
> it a LUN when it is really a wtf.

IMHO one 8 byte LUN is better then wtf. I's kinda obvious :)

Sergey Panov

========================================================================
Any opinions are personal and not necessarily those of my former,
present, or future employers.





