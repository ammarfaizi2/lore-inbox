Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132025AbQLNKxP>; Thu, 14 Dec 2000 05:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132475AbQLNKxF>; Thu, 14 Dec 2000 05:53:05 -0500
Received: from jalon.able.es ([212.97.163.2]:34692 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132025AbQLNKwu>;
	Thu, 14 Dec 2000 05:52:50 -0500
Date: Thu, 14 Dec 2000 11:22:17 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: "Justin T . Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released
Message-ID: <20001214112217.A9662@werewolf.able.es>
In-Reply-To: <200012132215.eBDMFas35908@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200012132215.eBDMFas35908@aslan.scsiguy.com>; from gibbs@scsiguy.com on Wed, Dec 13, 2000 at 23:15:36 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Dec 2000 23:15:36 Justin T. Gibbs wrote:
> daptec SCSI HBA device driver for the Linux Operating System
> To: linux-scsi@vger.kernel.org
> cc:
> Fcc: +outbox
> Subject: Adaptec AIC7XXX v6.0.6 BETA Released
> -------
> After several months of testing and refinement, the Adaptec 
> sponsored aic7xxx driver is now entering Beta testing.  Although
> still missing domain validation and the last bits of cardbus
> support, there are no known issues with the driver.  I would
> encourage all users of card supported by this driver to try the
> new code and submit feedback.  Patches for late 2.2.X, 2.3.99
> and 2.4.0 are provided in the driver distribution.  For those
> of you building the driver as a module, take note that the module
> name is now "aic7xxx_mod" rather than "aic7xxx".
> 
> As always, the most recent distribution is available here:
> 

I tried it against clean 2.2.18 and patches did not work.
Some drawbacks:
- the patch adds config info for AIX7XXX in the top level Makefile, instead
of in the Makefile in the scsi dir.
- The subdir for aic7xxx has not a Makefile, or at least it is not created
with the patches for 2.2.18.
- The structure of the driver (all files inside a subdir) has changed, so
you get the old files still there.

I am going to try to clean up the thigs to make the driver easily updated:
- First thing is to move all files in the actual 5.1.31 to INSIDE the dir
  and change the scsi/Makefile to build it as a SUB_DIR.
- Change names of files: aic7xxx.o has to be built from many *.c, so you
  should rename the aic7xxx.c to something like aic7xxx_main.c.
- Then you have the aic7xxx subdir and you can add a similar aic7xxx-6 subdir
and even add an exclusive option to build one or the other, the second
marked EXPERIMENTAL.

Couple o' questions:
- Is there any easy way to move/rename files with a diff, or just diff
from /dev/null or empty files .org and patch with -E ?
- Is there any keywork for Config.in files to do exclusion between
drivers or just if's ? Have to look for similar drivers. Any hint ?

Thanks.

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

Linux werewolf 2.2.18-aa1 #1 SMP Mon Dec 11 21:26:28 CET 2000 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
