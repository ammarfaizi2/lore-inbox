Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVE3L6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVE3L6D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 07:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVE3L6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 07:58:03 -0400
Received: from [81.2.110.250] ([81.2.110.250]:8150 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261487AbVE3L57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 07:57:59 -0400
Subject: Re: RAID-5 design bug (or misfeature)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Bernd Eckenfels <ecki@lina.inka.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0505300440550.15088@artax.karlin.mff.cuni.cz>
References: <E1DcXfR-0000zf-00@calista.eckenfels.6bone.ka-ip.net>
	 <Pine.LNX.4.58.0505300440550.15088@artax.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1117454144.2685.174.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 30 May 2005 12:55:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-05-30 at 03:47, Mikulas Patocka wrote:
> > In article <Pine.LNX.4.58.0505300043540.5305@artax.karlin.mff.cuni.cz> you wrote:
> > > I think Linux should stop accessing all disks in RAID-5 array if two disks
> > > fail and not write "this array is dead" in superblocks on remaining disks,
> > > efficiently destroying the whole array.

It discovered the disks had failed because they had outstanding I/O that
failed to complete and errorred. At that point your stripes *are*
inconsistent. If it didn't mark them as failed then you wouldn't know it
was corrupted after a power restore. You can then clean it fsck it,
restore it, use mdadm as appropriate to restore the volume and check it.

> But root disk might fail too... This way, the system can't be taken down
> by any single disk crash.

It only takes on disk in an array to short 12v and 5v due to a component
failure to total the entire disk array, and with both IDE and SCSI a
drive fail can hang the entire bus anyway.

Alan

