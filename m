Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbULZS0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbULZS0O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 13:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbULZS0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 13:26:14 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:58326 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261724AbULZSZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 13:25:54 -0500
Subject: Re: [BK] disconnected operation
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041226171900.GA27706@work.bitmover.com>
References: <1104077531.5268.32.camel@mulgrave>
	 <20041226162727.GA27116@work.bitmover.com>
	 <1104079394.5268.34.camel@mulgrave>
	 <20041226171900.GA27706@work.bitmover.com>
Content-Type: text/plain
Date: Sun, 26 Dec 2004 12:25:46 -0600
Message-Id: <1104085546.5268.38.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-26 at 09:19 -0800, Larry McVoy wrote:
> For James, could you do a little debugging please?  Run the following
> when you are plugged in and it works and also when it doesn't:
> 
> 	bk getuser
> 	bk getuser -r
> 	bk gethost
> 	bk gethost -r
> 	bk dotbk
> 
> We'll track it down and fix it if it is a problem on our end.  This stuff
> is supposed to work, we certainly haven't intentionally caused a problem.

OK, I cloned a new repository and started applying patches to it.  The
transcript of what I did is attached.  You can see that after I
disconnect from the network, I get three emails imported before it spits
an error at me.

James

jejb@mulgrave> bk lease renew
jejb@mulgrave> PATH=/home/jejb/BK/BK-kernel-tools:$PATH
jejb@mulgrave> dotest < ~/tmp.mail
bk import -tpatch -CR -yibmvscsi.c: replace schedule_timeout() with msleep() /tmp/patch20138 .
Patching...
Patching file drivers/scsi/ibmvscsi/ibmvscsi.c
Checking for potential renames in /home/jejb/BK/test-2.6 ...
Checking in new or modified files in /home/jejb/BK/test-2.6 ...
bk commit -y[PATCH] ibmvscsi.c: replace schedule_timeout() with msleep()

Description: Use msleep() instead of schedule_timeout()
to guarantee the task delays as expected.  Originally
submitted to linux-scsi by the janitors, and resubmitted
by boutcher (after testing :-)

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Dave Boutcher <boutcher@us.ibm.com>

ChangeSet revision 1.2206: +1 -0 = 38195
Sending ChangeSet log ...
jejb@mulgrave> bk getuser
jejb
jejb@mulgrave> bk getuser -r
jejb
jejb@mulgrave> bk gethost
mulgrave.(none)
jejb@mulgrave> bk gethost -r
mulgrave.(none)
jejb@mulgrave> bk dotbk
/home/jejb/.bk
jejb@mulgrave> dotest < ~/tmp.mail
bk import -tpatch -CR -yibmvscsi.c: limit size of I/O requests /tmp/patch20470 .
Patching...
Patching file drivers/scsi/ibmvscsi/ibmvscsi.c
Checking for potential renames in /home/jejb/BK/test-2.6 ...
Checking in new or modified files in /home/jejb/BK/test-2.6 ...
bk commit -y[PATCH] ibmvscsi.c: limit size of I/O requests

Description: Limit the size of I/O requests sent by the
ibmvscsi adapter.  With better I/O scheduling (and thus larger
requests) we were breaking some servers.

Signed-off-by: Dave Boutcher <boutcher@us.ibm.com>

ChangeSet revision 1.2207: +1 -0 = 38196
Sending ChangeSet log ...

[HERE I FLIP OUT THE WIRELESS CARD TO DISCONNECT]

jejb@mulgrave> dotest < ~/tmp.mail
bk import -tpatch -CR -yscsi/aic7xxx/aic79xx_osm.c: remove an unused function /tmp/patch20653 .
Patching...
Patching file drivers/scsi/aic7xxx/aic79xx_osm.c
Checking for potential renames in /home/jejb/BK/test-2.6 ...
Checking in new or modified files in /home/jejb/BK/test-2.6 ...
bk commit -y[PATCH] scsi/aic7xxx/aic79xx_osm.c: remove an unused function

[ this time without the problems due to a digital signature... ]

The patch below removes an unused function from
drivers/scsi/aic7xxx/aic79xx_osm.c


diffstat output:
 drivers/scsi/aic7xxx/aic79xx_osm.c |   26 --------------------------
 1 files changed, 26 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

ChangeSet revision 1.2208: +1 -0 = 38197
Sending ChangeSet log ...
jejb@mulgrave> dotest < ~/tmp.mail
bk import -tpatch -CR -yscsi/ahci.c: remove an unused function /tmp/patch20760 .
Patching...
Patching file drivers/scsi/ahci.c
Checking for potential renames in /home/jejb/BK/test-2.6 ...
Checking in new or modified files in /home/jejb/BK/test-2.6 ...
bk commit -y[PATCH] scsi/ahci.c: remove an unused function

[ this time without the problems due to a digital signature... ]

The patch below removes an unused function from drivers/scsi/ahci.c


diffstat output:
 drivers/scsi/ahci.c |    9 ---------
 1 files changed, 9 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

ChangeSet revision 1.2209: +1 -0 = 38198
Sending ChangeSet log ...
jejb@mulgrave> dotest < ~/tmp.mail
bk import -tpatch -CR -ygdth: reduce large on-stack locals /tmp/patch20867 .
Patching...
Patching file drivers/scsi/gdth.c
Patching file drivers/scsi/gdth_proc.c
Checking for potential renames in /home/jejb/BK/test-2.6 ...
Checking in new or modified files in /home/jejb/BK/test-2.6 ...
bk commit -y[PATCH] gdth: reduce large on-stack locals

gdth is the fourth-highest stack user (for a single function)
in 2.6.10-rc3-bk-recent (sizes on x86-32).

Reduce stack usage in gdth driver:
reduce ioc_rescan() from 1564 to 52 bytes;
reduce ioc_hdrlist() from 1528 to 24 bytes;
reduce gdth_get_info() from 1076 to 300 bytes;

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/scsi/gdth.c      |  194 ++++++++++++++++++++++++++---------------------
 drivers/scsi/gdth_proc.c |  145 ++++++++++++++++++-----------------
 2 files changed, 189 insertions(+), 150 deletions(-)

[HERE BK POPS UP A DIALOGUE SAYING:

Unable to obtain permission to use this version of BitKeeper (bk-3.2.3) 
from lease.openlogging.org.  That server issues certificates to use BK
for openlogging for 30 days at a time.  The bk binary needs to be able
to make a http connection to lease.openlogging.org at least once a month.

Look at 'bk help url' if you need to tell 'bk' about a proxy.

AND THE COMMIT FAILS WITH THE FOLLOWING:]

You need to figure out why you have two files with the same ID
and correct that situation before this ChangeSet can be created.
jejb@mulgrave> bk getuser
jejb
jejb@mulgrave> bk getuser -r
jejb
jejb@mulgrave> bk gethost
mulgrave.(none)
jejb@mulgrave> bk gethost -r
mulgrave.(none)
jejb@mulgrave> bk dotbk
/home/jejb/.bk





