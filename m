Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbUKEKD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUKEKD1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 05:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbUKEKCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 05:02:54 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:23475 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261563AbUKEKCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 05:02:39 -0500
Date: Fri, 5 Nov 2004 11:02:37 +0100
From: Michael Gernoth <simigern@stud.uni-erlangen.de>
To: linux-kernel@vger.kernel.org
Subject: Hanging NFS umounts with 2.4.27
Message-ID: <20041105100237.GA27689@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
we have 2 SMP machines running Linux 2.4.27 with autofs which have a high
rate of mounting/umounting. When they are heavily used, it happens that
about once a day a umount-process gets stuck and the only solution is
to reboot the machine.
We can also see this happen (much less often) on our UP workstations,
where in the average only one student is working on a single machine at
a time.

Searching through the Changesets I found 1.1402.1.19:
http://linux.bkbits.net:8080/linux-2.4/cset@1.1402.1.19
After reverting this one, we have a stable umount-behaviour again.

Grepping through the log of the serial console finds the following
hanging umounts (the nfs-servers were up at these moments):
19969 ?        S      9:32 /bin/umount //local/perl-5.004/.arch.os
23437 ?        S      0:00 /bin/umount //local/maple/.arch.os
19969 ?        S      9:40 /bin/umount //local/perl-5.004/.arch.os
23437 ?        S      0:00 /bin/umount //local/maple/.arch.os
19969 ?        S      9:59 /bin/umount //local/perl-5.004/.arch.os
23437 ?        S      0:00 /bin/umount //local/maple/.arch.os
19969 ?        S     10:13 /bin/umount //local/perl-5.004/.arch.os
23437 ?        S      0:00 /bin/umount //local/maple/.arch.os
22491 ?        S      0:00 /bin/umount //local/gnu-utils-1.0/.arch.os
23560 ?        S      0:00 /bin/umount //proj/cipadm

The file-systems are mounted from a Solaris 9 machine with the following
options on the client-side:
rw,nosuid,nodev,retry=5,intr,rsize=8192,noquota,wsize=8192,hard,tcp,addr=...

We are running Debian/Testing with autofs version 4.1.3.

Our current Kernel-config is at:
http://wwwcip.informatik.uni-erlangen.de/~simigern/cip-generic-config
(This Kernel is patched with ACLs and the current autofs-patch, but the
 behaviour can be reproduced with a vanilla kernel.org kernel)

Regards,
  Michael

Please CC me on replies, as I am not subscribed to linux-kernel. Thanks.

-- 
Michael Gernoth                            Department of Computer Science IV 
Martensstrasse 1  D-91058 Erlangen Germany  University of Erlangen-Nuremberg
	         http://wwwcip.informatik.uni-erlangen.de/
