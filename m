Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWBCRAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWBCRAH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 12:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWBCRAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 12:00:06 -0500
Received: from mail-gw3.adaptec.com ([216.52.22.36]:4557 "EHLO
	mail-gw3.adaptec.com") by vger.kernel.org with ESMTP
	id S1751230AbWBCRAE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 12:00:04 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FYI: RAID5 unusably unstable through 2.6.14
Date: Fri, 3 Feb 2006 12:00:02 -0500
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F0217F765@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FYI: RAID5 unusably unstable through 2.6.14
Thread-Index: AcYo3Mq7Yg/yWtRaTs2fqcN0OV+08gAA21TA
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Martin Drab" <drab@kepler.fjfi.cvut.cz>,
       "Phillip Susi" <psusi@cfl.rr.com>
Cc: "Bill Davidsen" <davidsen@tmr.com>, "Cynbe ru Taren" <cynbe@muq.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Drab [mailto:drab@kepler.fjfi.cvut.cz] sez:
> That may very well be true. I do not know what the Adaptec 
> BIOS does under the "Low-Level Format" option. Maybe someone from
Adaptec 
> would know that.

The drive is low level formatted. This resolved the problem you were
having.

> No, I don't think this was the case of a physically bad 
> sectors. I think it was just an inconsistency of the RAID controllers
metadata (or 
> something simillar) related to that particular array.

It was a case of a set of physically bad sectors in a non-redundant
formation resulting in a non-recoverable situation, from what I could
tell. Read failures do not take the array offline, write failures do.
Instead the adapter responds with a hardware failure to the read
responses. Writing the data would have re-assigned the bad blocks. (RAID
controllers do reassign media bad blocks automatically, but sets them as
inconsistent under some scenarios, requiring a write to mark them
consistent again. This is no different to how single drive media reacts
to faulty or corruption issues).

The bad sectors were localized only affecting the Linux partition, the
accesses were to directory or superblock nodes if memory serves. Another
system partition was unaffected because the errors were not localized to
it's area.

Besides low level formatting, there is not much anyone can do about this
issue except ask for a less catastrophic response from the Linux File
system drivers. I make no offer or suggestion regarding the changes that
would be necessary to support the system limping along when file system
data has been corrupted; UNIX policy in general is to walk away as
quickly as possible and do the least continuing damage.

Except this question: If a superblock can not be read in, what about the
backup copies? Could an fsck play games with backup copies to result in
a write to close inconsistencies?

-- Mark Salyzyn
