Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310233AbSCFWiI>; Wed, 6 Mar 2002 17:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310228AbSCFWh7>; Wed, 6 Mar 2002 17:37:59 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44039 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292752AbSCFWho>; Wed, 6 Mar 2002 17:37:44 -0500
Subject: Re: Support for sectorsizes > 4KB ?
To: R.Oehler@GDAmbH.com (Ralf Oehler)
Date: Wed, 6 Mar 2002 22:53:01 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-scsi@vger.kernel.org (Scsi)
In-Reply-To: <XFMail.20020306084829.R.Oehler@GDAmbH.com> from "Ralf Oehler" at Mar 06, 2002 08:48:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ikHN-0008T9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In the not-so-far future there will occure MO media on the market with
> 40 to 120 Gigabytes of capacity and sectorsizes of 8 KB and maybe more.
> It's called "UDO" technology.
> 
> Is there any way to support block devices with sectors larger than 4KB =
> ?

The scsi layer itself doesn't mind, but the page caches do. Once your
block size exceeds the page size you hit a wall of memory fragmentation
issues. Given that M/O media is relatively slow I'd be inclined to say
write an sd like driver (smo or similar) which does reblocking and also
knows a bit more about other M/O drive properties.

Alan
