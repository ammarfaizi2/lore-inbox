Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbVLSVYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbVLSVYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 16:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbVLSVYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 16:24:16 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:63842 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S964996AbVLSVYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 16:24:16 -0500
Date: Mon, 19 Dec 2005 16:24:00 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 2.6.15-rc6] block: Make CDROMEJECT more robust
In-reply-to: <20051219204624.GR3734@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Ben Collins <bcollins@ubuntu.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Message-id: <1135027440.4541.12.camel@localhost.localdomain>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20051219153236.GA10905@swissdisk.com>
 <20051219193508.GL3734@suse.de>
 <1135021497.2029.3.camel@localhost.localdomain>
 <20051219195630.GO3734@suse.de>
 <1135024069.4541.6.camel@localhost.localdomain> <20051219204624.GR3734@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 21:46 +0100, Jens Axboe wrote:
> On Mon, Dec 19 2005, Ben Collins wrote:
> > > So the medium removal command does require write permission on the
> > > deviec, but it doesn't require root. If they need to rw to the device
> > > fs, surely they need write permissions on the device in the first place?
> > 
> > bcollins@colorless:~$ id -a
> > uid=1000(bcollins) gid=1000(bcollins)
> > groups=4(adm),20(dialout),24(cdrom),25(floppy),29(audio),30(dip),44(video),46(plugdev),104(lpadmin),105(scanner),106(admin),1000(bcollins)
> > bcollins@colorless:~$ ls -l /dev/hdc
> > brw-rw---- 1 root plugdev 22, 0 Dec 19  2005 /dev/hdc
> > bcollins@colorless:~$ eject -s /dev/hdc
> > eject: unable to eject, last error: Operation not permitted
> > bcollins@colorless:~$ eject -r /dev/hdc
> 
> Does eject open the device O_RDWR?

No, it was opening it RDONLY. I changed it to RDWR, and it allowed the
SG_IO commands to work without root. I'll send a patch to eject for
that.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

