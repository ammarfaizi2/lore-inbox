Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129060AbQKMPvK>; Mon, 13 Nov 2000 10:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129069AbQKMPvA>; Mon, 13 Nov 2000 10:51:00 -0500
Received: from london.rubylane.com ([208.184.113.40]:54120 "HELO
	london.rubylane.com") by vger.kernel.org with SMTP
	id <S129060AbQKMPun>; Mon, 13 Nov 2000 10:50:43 -0500
Message-ID: <20001113155041.23544.qmail@london.rubylane.com>
From: jim@rubylane.com
Subject: Re: IDE tape problem in 2.2.17 on Intel SMP
To: camm@enhanced.com (Camm Maguire)
Date: Mon, 13 Nov 2000 07:50:41 -0800 (PST)
Cc: jim@rubylane.com, gadio@netvision.net.il, Alan.Cox@linux.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <54k8a7ub7g.fsf@intech19.enhanced.com> from "Camm Maguire" at Nov 13, 2000 10:46:11 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the info.  We're running 2.2.17 from www.kernel.org w/o
any patches.

Jim

> 
> Greetings!  You're not running the ide patches, are you?  We're
> running 2.2.17 with the patches, and have found that we must use the
> ide-scsi interface to get verifiable backups.  We still get apparently
> harmless error messages in the logs though.
> 
> Here are our modules.conf entries:
> 
> pre-install ide-scsi echo ide_scsi:1 > /proc/ide/hdc/settings 
> post-install ide-scsi echo using_dma:0 > /proc/ide/hdc/settings
> pre-install ide-tape echo ide_scsi:0 > /proc/ide/hdc/settings
> pre-install st /sbin/modprobe -k ide-scsi
> 
> We then use /dev/nst0.
> 
> I believe these sysctrl parameters are only available with the ide
> patches.  You might be able to replicate the functionality with module
> options if you're not using the patches.
> 
> Take care,
> 
> jim@rubylane.com writes:
> 
> > I wrote on Nov 2nd about IDE tapes no longer working in 2.2.17.  The
> > write seems to work fine, but the verify pass causes read errors and
> > a tar abort.
> > 
> > I tried changing the priority of the tar process to higher than all
> > others (it was running as a very low priority job and I thought that
> > might be a contributing factor), but the higher priority did not help.
> > 
> > I tried restoring the last file from the tape.  One day it failed with
> > an "unexpected EOF" error, the next day it restored the file correctly
> > (even though we got the 12 read errors on the verify pass and tar
> > aborted).
> > 
> > My conclusion is that the tape write is working.  The drive has
> > hardware read after write verification, so I kinda thought this was
> > the case.  But IDE tape reads appear to be flakey on an active SMP
> > setup (Intel).  This problem started the day we switched from 2.2.16
> > to 2.2.17, without any other software or hardware changes.
> > 
> > If I can be of any further help, let me know.
> > 
> > Thanks,
> > Jim Wilcoxson
> > Owner, www.rubylane.com
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> > 
> > 
> 
> -- 
> Camm Maguire			     			camm@enhanced.com
> ==========================================================================
> "The earth is but one country, and mankind its citizens."  --  Baha'u'llah
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
