Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWBZJ4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWBZJ4T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 04:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWBZJ4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 04:56:19 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:9601 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1751298AbWBZJ4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 04:56:18 -0500
Message-ID: <44017B4B.3030900@dgreaves.com>
Date: Sun, 26 Feb 2006 09:56:27 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, htejun@gmail.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca>
In-Reply-To: <4401122A.3010908@rtr.ca>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:

>> sdb: Current: sense key: Medium Error
>>     Additional sense: Unrecovered read error - auto reallocate failed
>> end_request: I/O error, dev sdb, sector 398283329
>> raid1: Disk failure on sdb2, disabling device.
>>         Operation continuing on 1 devices
>
>
> Oh good, *now* we've gotten somewhere!!
>
> Albert / Jens / Jeff:
>
> The command failing above is SCSI WRITE_10, which is being
> translated into ATA_CMD_WRITE_FUA_EXT by libata.
>
> This command fails -- unrecognized by the drive in question.
> But libata reports it (most incorrectly) as a "medium error",
> and the drive is taken out of service from its RAID.
>
> Bad, bad, and worse.
>
> Libata should really recover from this, by recognizing that
> the command was rejected, and replacing it with a simple
> WRITE_EXT instead.  Possibly followed by FLUSH_CACHE.
>
> So.. I've forgotten who put FUA into libata, but hopefully
> it's one of the folks on the CC: list, and that nice person
> can now generate a patch to fix this bug somehow.

Thanks Mark

I'm glad it's a bug and not bad hardware.

I am quite concerned that the basic effect of just booting a practically
vanilla 2.6.16-rc4 like this was to fry my raid array.

Luckily it dropped 2 (of  3) disks so quickly that the event counter was
the same allowing an easy rebuild.

2.6.15 has similar issues but they seem to happen *very* infrequently by
comparison - this hit me several times during a single boot.

Should Linus (cc'ed) hold off on 2.6.16 because of this or not?

David

