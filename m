Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132044AbRDJUBd>; Tue, 10 Apr 2001 16:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132056AbRDJUBY>; Tue, 10 Apr 2001 16:01:24 -0400
Received: from delta.Colorado.EDU ([128.138.139.9]:30221 "EHLO
	ibg.colorado.edu") by vger.kernel.org with ESMTP id <S132044AbRDJUBL>;
	Tue, 10 Apr 2001 16:01:11 -0400
Message-Id: <200104102001.OAA209123@ibg.colorado.edu>
To: linux-kernel@vger.kernel.org
Subject: kswapd, kupdated, and bdflush at 99% under intense IO
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 0852
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2001 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Tue, 10 Apr 2001 14:01:10 -0600
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My machine is an 8 processor Dell P-III 700Mhz with 8GB of memory.
The disk system I am using is a 12 drawer JBOD with 5 disks in a raid
5 arrangement attached to an AMI Megaraid 438/466/467/471/493
controller with a total of 145GB of space.  The machine has been in
use for about 6 months doing primarily cpu and memory intensive
scientific computing tasks.  It has been very stable in this role and
everybody involved has been pleased with its performance.  Recently a
decision was made to conglomerate people's home directories from
around the network and put them all on this machine (hence the JBOD
and RAID).

These tests are all being done with Linux 2.4.3 + the bigpatch fix for
knfsd and quotas.  The rest of the OS is Debian unstable.

Before moving the storage into production I am performing tests on it
to gauge its stability.  The first test I performed was a single
bonnie++ -s 16096 instance, and the timing results are inline with
what I would expect from fast SCSI disks.

However, multiple instance of bonnie++ completely kill the machine.
Once two or three bonnies are running kswapd, kupdated, and bdflush
each jump to using 99% of a cpu and the machine becomes incredibly
unresponsive.  Even using a root shell at nice -20 it can take several
minutes for "killall bonnie++" to appear after being typed and then
run.  After the bonnies are killed and kswapd, kupdated, and bdflush
are given a minute or two to finish whatever they are doing, the
machine becomes responsive again.

I don't think the machine should be behaving like this.  I certainly
expect some slowdowns with that much IO, but the computer should still
be resonably responsive, particularly because no system or user files
that need to be accessed are on that channel of the SCSI controller.

Any advice on approaching this problem would be appreciated.  I will
try my best to provide any debugging information that would be useful,
but the machine is on another continent from myself, so without a
serial console I have a hard time getting any information that doesn't
make it into a logfile.

--
Thanks,
Jeff Lessem.
