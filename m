Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132137AbRDJUZe>; Tue, 10 Apr 2001 16:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132140AbRDJUZY>; Tue, 10 Apr 2001 16:25:24 -0400
Received: from adsl-63-199-104-197.dsl.lsan03.pacbell.net ([63.199.104.197]:8711
	"HELO ns1.theoesters.com") by vger.kernel.org with SMTP
	id <S132137AbRDJUZH>; Tue, 10 Apr 2001 16:25:07 -0400
From: "Phil Oester" <phil@theoesters.com>
To: "Jeff Lessem" <Jeff.Lessem@Colorado.EDU>, <linux-kernel@vger.kernel.org>
Subject: RE: kswapd, kupdated, and bdflush at 99% under intense IO
Date: Tue, 10 Apr 2001 13:25:06 -0700
Message-ID: <LAEOJKHJGOLOPJFMBEFEKEOBDDAA.phil@theoesters.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <200104102001.OAA209123@ibg.colorado.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen similar 'unresponsiveness' running 2.4.3-ac2 on a Qmail server.
The hardware is dual-processor PIII 650 w/1GB of RAM.  SCSI is sym53c895
with dual Quantum 9gb drives.

Any time I start injecting lots of mail into the qmail queue, *one* of the
two processors gets pegged at 99%, and it takes forever for anything typed
at the console to actually appear (just as you describe).  But I don't see
any particular user process in top using a great deal of cpu - just the
system itself.  In my case, however, I usually have to powercycle the box to
get it back - it totally dies.

I've started the kernel with profile=2, and had a cron job running every
minute to capture a readprofile -r; sleep 10; readprofile, but when the
processor pegs, the cron jobs just stop without catching any useful
information before the freeze.  The interesting thing is, the box still
responds to pings at this time, even though it goes hours without any
profile captures.

Upon powercycling, the qmail partition is loaded with thousands of errors -
which could be caused by the power cycling, or by something kernel related.

In the meantime, I've had to revert to 2.2.19 any time I do intense
mailings.

-Phil Oester

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Jeff Lessem
Sent: Tuesday, April 10, 2001 1:01 PM
To: linux-kernel@vger.kernel.org
Subject: kswapd, kupdated, and bdflush at 99% under intense IO


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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


