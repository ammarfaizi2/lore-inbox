Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbUB0OWR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 09:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbUB0OWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 09:22:17 -0500
Received: from gizmo12ps.bigpond.com ([144.140.71.22]:33954 "HELO
	gizmo12ps.bigpond.com") by vger.kernel.org with SMTP
	id S261687AbUB0OWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 09:22:14 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: linux-kernel@vger.kernel.org
Subject: Busy system needs shutdown if nonzero e2fsck result, otherwise Oops, was 2.4.24 Paging Fault...
Date: Sat, 28 Feb 2004 00:23:13 +1000
User-Agent: KMail/1.5.1
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402280023.13854.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I have a puzzling fault occuring on a system 2.4.24 or 2.4.26-pre1 
patched with lowlat, preempt, vhz jiffies, and my nforce2 lockups patches.

My previous postings on topic
http://www.ussg.iu.edu/hypermail/linux/kernel/0402.1/1573.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0402.2/0042.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0402.2/0070.html

Debugging efforts have been on two systems with same
type of hardware. Fault is reproducable.

I have not included all config info with this email as my kernel is not
standard, limited value? but this still may be of some benefit.

I have not tried a standard 2.4 kernel with this system due to expected
latency issues. Whilst a standard 2.6 series kern has all the latency features
I need, the drivers I use have yet to be ported.

Currently system is now stable with scripted reboot after a non zero return code
from e2fsck.

As such it has to go back out on the road imaging things. Unfortunately I do
not have an complete duplicate system for immediate further testing on.

Findings.

If the e2fsck program exits with non zero i.e. drive was not clean then
Oops guaranteed if I am grabbing from 3 cameras. If I switch off 2 cameras
then no Oops (system less busy). 

If I reboot after e2fsck nonzero result then no Oops occurs and system
functions fine. Storage drives are not mounted at all prior to e2fsck.

I have tried e2fsck 1.28 and 1.34 (static link) both with same result.
Docs say reboot reqd on exit code of 2. This system needs reboot also with
exit code of 1?

More testing revealed when conditions for Oops are met the process listed in 
Oops varies but Oops always occurred at roughly the same quantity of data
written to drive or drives (estimated from distance, not measured).

System is vehicle mounted so simulated travel distance in daytime is around
8km to Oops with 1 storage drive. With 2 drives (not raid) writing duplicate of
data then distance is around 4km. At night with basically black images
(storage is mpeg compressed) then Oops is around 24km simulated distance
for single drive.

Varying distance indicates to me that Oops is not sensitive to drive transfer
rate. Time to fault also varies.

System is busy wrt dma from both a bt878 card (1 camera) and a meteor II
mc card( 2 cameras). Raw image transfer is fairly constant for a constant speed
(3 images per 4m to 6m up to 110kph) with raw 614K images on bt878 and 2.4M
images on mc card. (30Mb per second at 80kph) Travelling slower lowers the
average transfer rate from the meteor II mc card but Oops occurs at roughly
the same distance for same image content.

There is also serial, network and lpt activity as well. Problem still
occurs without serial activity - seems somewhat insensitive to interrupts.

I get same results with mount program from either suse 8.2 or busybox mount.

The only daemons other than usual kernel ones are smbd and nmbd.

Ramdrive swap does not help 2.4.26-pre1, no longer certain if it helps 2.4.24.

My Questions if you please.

Are there some further fixups going on in the Kernel ext2fs driver when the
filesystem has been fixed on boot by e2fsck that don't occur with a clean
boot? 

And if so do these only occur after a certain amount of data has passed out
of the kernel to drive?

Does the e2fsck fixups without reboot alter the way the drive data is laid down?
Resulting in a timing issue with interleave or something that isn't handled
neatly with the PCI being busy?

Any thoughts on nforce2 IDE? hypertransport? errors occuring that are not
being handled by the existing driver?

Thanks in advance,
Ross Dickson




