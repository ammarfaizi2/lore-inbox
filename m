Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263399AbUCXN7h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 08:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263717AbUCXN7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 08:59:37 -0500
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:20109 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP id S263399AbUCXN7c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 08:59:32 -0500
Subject: Re: [RFC 2/6] sysfs backing store v0.3a
To: maneesh@in.ibm.com
Cc: mpm@selenic.com, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, greg@kroah.com,
       Dipankar Sarma - LTC <DIPANKAR@in.ibm.com>,
       Carsten Otte <COTTE@de.ibm.com>,
       Christian Borntraeger <CBORNTRA@de.ibm.com>, mjbligh@us.ibm.com
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OFDABFF19F.E4313677-ONC1256E61.004A3154-C1256E61.004B8611@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Wed, 24 Mar 2004 14:44:55 +0100
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 24/03/2004 14:46:15
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Maneesh Soni wrote:
> Please find the following patch (2/6) for sysfs backing store. This fixes
> a leak observed in case of sysfs_readdir() for _big_ sysfs directories. The
> dentries were not getting released in case of error return from filldir()
> in sysfs_readdir().
>
> Thanks again to Christian Borntraeger (S390 Linux) for spotting this and testing
> the fix.

yes, Christian tested this again and it works great now. For his setup (which we
do not consider to be unusual) this patches saved about 50 MB of main memory. The
particular machine has about 1600 disk devices attached to it. This happens if the
i/o configuration doesn't restrict an lpar to the devices it should use but allows
the lpar to "see" all the device there are. Even a middle sized storage subsystem
can have a lot of disks, the ESS Christian used had 1600 disks. Now you might
argue a system that big should have enough memory for the syfs inodes. Its just
lousy 50 MB but given that there can be LOTS of system images I'd rather have the
50 MB then to waste then on the sysfs entries for unused disks.
I'm definitly much in favor of this patch.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


