Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129655AbRADSKk>; Thu, 4 Jan 2001 13:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129834AbRADSKa>; Thu, 4 Jan 2001 13:10:30 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45071 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129655AbRADSKS>; Thu, 4 Jan 2001 13:10:18 -0500
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
To: david.lang@digitalinsight.com (David Lang)
Date: Thu, 4 Jan 2001 18:11:11 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse),
        phillips@innominate.de (Daniel Phillips),
        helgehaf@idb.hist.no (Helge Hafting), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0101040954040.10387-100000@dlang.diginsite.com> from "David Lang" at Jan 04, 2001 10:00:01 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14EEr4-000697-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> in an enbedded device you can
> 1. setup the power switch so it doesn't actually turn things off (it
> issues the shutdown command instead)

Costs too much money

> 2.  run from read-only media almost exclusivly so that power event's don't
> bother you much

Depends on the device

> 3. you can add extra power inside the device so that if someone does pull
> the plug, you have a few seconds of power to do the clean shutdown

Incredibly expensive

> 4. you can run out of ram and force the user to do an extra step to save
> any changes to non-volitile storage (and if they power off during the save
> the results are undefined)

Frowned upon because you keep getting dead units back

> an improved filesystem that tolorates bad shutdowns reasonably well will
> be welcomed for other reasons, but should not be viewed as a fix for
> people pulling the plug on you. 

If it doesnt fix the pulling the plug case (at least as far as 'after fsync
returned this data is safe') then its not working. A journalling file system
is always consistent. fsync/sync/msync define write barrier operations.

Applications do have to deal with more things (partial dbase write for example)
but competently written databases and transaction managers handle this.

Ext3 has been tested on the random live switchoffs on a real box because 
ftp.linux.org.uk kept crashing during backups and it took us a while to figure
out that the network backup tool was backing up in /proc/bus/pci and stopping
the box dead when it backed up the pci config space of the ACPI controller.

Alan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
