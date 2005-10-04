Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbVJDHhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbVJDHhj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 03:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbVJDHhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 03:37:39 -0400
Received: from wnx-5a.seeweb.it ([212.25.170.113]:20658 "EHLO wnx-5a.seeweb.it")
	by vger.kernel.org with ESMTP id S932468AbVJDHhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 03:37:39 -0400
From: Giulio Orsero <giulioo@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x: big problems with md over sata 
Date: Tue, 04 Oct 2005 09:37:30 +0200
Reply-To: giulioo@pobox.com
X-Mailer: Forte Agent 3.1/32.783
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20051004073730.3C4D0128BC@mail.golden.dom>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm writing here since I didn't receive any answer when I posted the very
same questions to linux-ide (2.4 MAINTAINERS file says to use linux-ide for
sata issues), then to the kernel 2.4 maintainer and then to the sata
maintainer.

I hope that since this list has more readers someone can give me a clue
about what's happening.

===============
I have 2 problems with md over sata in kernel 2.4 (2.4.32rc1) when using
md/raid1 over two 120GB sata disks:
1) sata (both ata_piix and ahci) thinks one of the sata disks has a problem,
but:
- the hd diag utilities both from the hd manufacturer (seagate) and ibm say
that both disks are fine (I've run them in advanced/complete mode many times
over).
- If I boot from floppy and do not load raid1.o and do
cat /dev/sda > /dev/null
cat /dev/sdb > /dev/null
both commands complete without any error
2) Even if we assume that one disk is bad, which I don't think it's the
case, the machine hangs when sata starts spewing messages about hd problems
(with ide the disk/partition would be kicked out and operations would
continue on the remaining disk/partition). Machine is pingable but you
cannot login and open terminal sessions hang.


Here are the posts I made to linux-ide with detailed info about hardware and
dmesg: 
	 "ata_piix: "abnormal status 0xD0", but disks are OK"
	http://marc.theaimsgroup.com/?l=linux-ide&m=112783255913496&w=2

	"ata1: BUG: timeout without command"
	http://marc.theaimsgroup.com/?l=linux-ide&m=112790056405309&w=2
The problems occurs both with and w/o apic.


While searching for possible hints I found this redhat bugzilla entry which
describes a similar issues
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=127813
they say they think they have it fixed in an errata, so I tried the latest
rhel3 kernel september2005 errata and I get the same 2 problems above (I
tried that kernel since I know the main sata developer is from redhat and so
I thought the rhel3 kernel should be the best avail 2.4 kernel as far as
sata goes).


So, the questions are:
1) Are there any known problems with sata in 2.4.x?
2) Do you know whether md over sata is a big no-no in 2.4.x? If this is a
known fact, then we can buy an hardware raid controller.
3) Do you know where to find new sata patches for 2.4?

We intentionally stay with 2.4 because we value stability above
all (ie: above performance), we understand you, as developers, would
probably just say "upgrade to latest 2.6.x", but this is not an option for
us right now.

Thanks
-- 
giulioo@pobox.com
