Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264412AbUFEFMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbUFEFMR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 01:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUFEFMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 01:12:16 -0400
Received: from [202.125.86.130] ([202.125.86.130]:32726 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S264412AbUFEFMP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 01:12:15 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: removable media support on 2.6.x
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Sat, 5 Jun 2004 10:38:27 +0530
Message-ID: <1118873EE1755348B4812EA29C55A9722AF023@esnmail.esntechnologies.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: removable media support on 2.6.x
Thread-index: AcRKt9zlgHmSa3RQQS6Zkud5GHTUmAAAw8Vw
From: "Jinu M." <jinum@esntechnologies.co.in>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <kernelnewbies@nl.linux.org>,
       "Surendra I." <surendrai@esntechnologies.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> afaik we don't really support hot unplug like this.
> 
> Changes were made a few months ago (make the VFS use file->f_mapping
> rather
> than file->f_dentry->d_inode->i_mapping) which set some of the
> pieces in
> place but I think there's a way to go yet.
> 
> umm, the general idea is that when the disk vanishes your driver
> should
> then return -EIO for all future I/O requests.  The block_device, the
> queue,
> the inode and all that stuff remains in-core.

What we do with our 2.4 version of the driver is something on this
lines. When the media is removed we invalidate the buffers and then
set the card absent bit. Now on when read/write requests arrive we
return error status to the file system since card is absent. This worked
for 2.4.x.

Is there some existing driver which addresses removable media on 2.6.x
Kernel? I would like to see how it addresses this.. then I will have
a better idea to address it with the kernel support we have now.

-Jinu
