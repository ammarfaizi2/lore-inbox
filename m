Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135170AbQL3VPR>; Sat, 30 Dec 2000 16:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135535AbQL3VPI>; Sat, 30 Dec 2000 16:15:08 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:35589 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S135170AbQL3VOv>; Sat, 30 Dec 2000 16:14:51 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200012302043.VAA10260@green.mif.pg.gda.pl>
Subject: Re: Bugs in knfsd -- Problem re-exporting an NFS share
To: Frank.Olsen@stonesoft.com, neilb@cse.unsw.edu.au (Neil Brown)
Date: Sat, 30 Dec 2000 21:43:56 +0100 (CET)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Friday December 29, Frank.Olsen@stonesoft.com wrote:
> > Hi -- could you please CC me if you reply to this mail.
> > 
> > A:     /exports/A                                 - Redhat 7.0
> > B1/B2: mount /exports/A on /export/A from A       - Redhat 6.2
> > C:     mount /exports/A on /mnt/A from B1 or B2   - Redhat 6.2
> > 
> > I use knfsd/nfs-utils on each machine.
> > 
> > bash# ls /mnt/A
> > /mnt/A/A.txt: No such file or directory
> 
> This is not a supported configuration.  You cannot export NFS mounted
> filesystems with NFS. The protocol does not cope, and it
> implementation doesn't even try.
> NFS is for export local filesystems only.

As I understand problem is somewhere else.
If this is intentionally unsupported configuration - OK. So why the error
appears ? The directory should be empty then.

If the configuration is unsupported at the moment and the  A.txt file is
located on A, some code that attempts to read re-exported files/directories
should be turned off (eg. #if 0).

If the A.txt file is local for B1/B2 hosts, it is (IMHO) an obvious bug.
Sucgh a file should be hidden at the act of mounting. For both local and
remote access.

Neil, could you tell us where the A.txt file is *really* located ?

Regards 
   Andrzej

BTW. AFAIR, I observed similar behaviour (files are visible but
     inaccessible) while mounting a local filesystem at a busy directory
     (eg.: mount /dev/fd0 .;ls -l) even in 2.2...

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
