Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbULZPuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbULZPuJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 10:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbULZPtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 10:49:02 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:945 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261681AbULZPrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 10:47:14 -0500
Subject: Re: kblockd/1: page allocation failure in 2.6.9
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Jens Axboe <axboe@suse.de>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <41CDEE8A.80407@bio.ifi.lmu.de>
References: <41C7D32D.2010809@bio.ifi.lmu.de>
	 <41CAAB61.3030704@bio.ifi.lmu.de>
	 <200412231551.15767.vda@port.imtp.ilyichevsk.odessa.ua>
	 <41CAEA62.4060903@bio.ifi.lmu.de>  <20041224132006.GC2528@suse.de>
	 <1103916492.5448.27.camel@mulgrave>  <41CDEE8A.80407@bio.ifi.lmu.de>
Content-Type: text/plain
Date: Sun, 26 Dec 2004 09:46:40 -0600
Message-Id: <1104076000.5268.18.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-25 at 23:49 +0100, Frank Steiner wrote:
> - If you suspect the gdth driver causing the error, it must be some very
>    special situation on this host causing it. We have 2 other hosts
>    with the same icp vortex GDT8514RZ controller like the host
>    where the kblockd message occured. They all have internal raid1 disks
>    (73gb or 146gb). One is our main NFS server (it has two raid1 with 146g
>    each) and it has a lot of I/O, sometimes 50GB or more a day with peaks
>    up to 200MB per second (reading), and we never saw any kblockd message
>    in the logs (I just checked them all).

The kblockd message is just a symptom of the machine running low on
memory and starting to fail normal kernel memory allocations.  There's
always a potential for hangs when something can't allocate memory:
usually it's in the middle of a transaction and just forgets about it;
what should happen (as we just verified SCSI does) is that the
transaction should be rolled back and retried.

> - there were no messages "around" the kblockd messages in /var/log/messages
>    but the usual ones about remote ssh login, cron jobs etc., but the messages
>    were all more than 10 minutes "away" before and after the kblockd happened.

That's unfortunate.  It means that whatever caused this left no trace.
The best working theory is still a memory allocation failure somewhere.
If it occurs again, could you get a full system process trace (<alt>-
<sysrq>-t) and send that?  That might give a better clue as to what went
on.

James


