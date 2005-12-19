Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbVLSUo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbVLSUo5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 15:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbVLSUo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 15:44:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:31078 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964961AbVLSUo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 15:44:56 -0500
Date: Mon, 19 Dec 2005 21:46:24 +0100
From: Jens Axboe <axboe@suse.de>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Ben Collins <bcollins@ubuntu.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15-rc6] block: Make CDROMEJECT more robust
Message-ID: <20051219204624.GR3734@suse.de>
References: <20051219153236.GA10905@swissdisk.com> <20051219193508.GL3734@suse.de> <1135021497.2029.3.camel@localhost.localdomain> <20051219195630.GO3734@suse.de> <1135024069.4541.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135024069.4541.6.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19 2005, Ben Collins wrote:
> > - Read request: direction bit not set, non-zero data length
> > - Write request: direction bit set, non-zero data length
> > 
> > How can you read or write anything, when there's nothing to read or
> > write?
> 
> Exactly, but the block layer (and I'd have to trace back through the
> code to find the exact failure point) has a check somewhere in there
> that checks the direction, and if it's a WRITE, checks data_len, and
> fails if it is 0.

I'd like to see that, if it's true it wants fixing of course.

> Note, my patch does not fix the case for the bug if I leave it as WRITE.
> It only works when it is READ.

We need to get that fixed as well, it should not make a difference.

> > So the medium removal command does require write permission on the
> > deviec, but it doesn't require root. If they need to rw to the device
> > fs, surely they need write permissions on the device in the first place?
> 
> bcollins@colorless:~$ id -a
> uid=1000(bcollins) gid=1000(bcollins)
> groups=4(adm),20(dialout),24(cdrom),25(floppy),29(audio),30(dip),44(video),46(plugdev),104(lpadmin),105(scanner),106(admin),1000(bcollins)
> bcollins@colorless:~$ ls -l /dev/hdc
> brw-rw---- 1 root plugdev 22, 0 Dec 19  2005 /dev/hdc
> bcollins@colorless:~$ eject -s /dev/hdc
> eject: unable to eject, last error: Operation not permitted
> bcollins@colorless:~$ eject -r /dev/hdc

Does eject open the device O_RDWR?

-- 
Jens Axboe

