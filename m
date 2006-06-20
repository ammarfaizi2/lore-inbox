Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbWFTKks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbWFTKks (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 06:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWFTKks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 06:40:48 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:29894 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S932566AbWFTKkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 06:40:47 -0400
Message-ID: <4497D014.1050704@s5r6.in-berlin.de>
Date: Tue, 20 Jun 2006 12:38:12 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>,
       linux1394-devel@lists.sourceforge.net,
       Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: [git pull] ieee1394 tree for 2.6.18
References: <44954102.3090901@s5r6.in-berlin.de> <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606191902350.5498@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Sun, 18 Jun 2006, Stefan Richter wrote:
>> 
>> the IEEE 1394 subsystem updates for Linux 2.6.18 are now staged in Ben's
>> revived linux1394 git tree. I guess the URL to pull from is
>> git://git.kernel.org/pub/scm/linux/kernel/git/bcollins/linux1394-2.6.git
> 
> I'm sure that URL works fine, but I want to see what I'm pulling before I 
> pull it, so _please_ use one of the scripts that generates diffstats and 
> shortlogs, or do it by hand..

Here are stat and shortlog; not from the actual git tree but from patches as
they went in. Side notes: The spike in the diffstat is whitespace formatting.
Sem2mutex and kthread conversions as well as suspend/resume fixes are not
complete yet.

 Documentation/feature-removal-schedule.txt |    4
 drivers/ieee1394/Kconfig                   |   13
 drivers/ieee1394/csr1212.c                 |    2
 drivers/ieee1394/csr1212.h                 |    1
 drivers/ieee1394/dma.c                     |   18
 drivers/ieee1394/eth1394.c                 |   51 +-
 drivers/ieee1394/eth1394.h                 |    2
 drivers/ieee1394/highlevel.c               |  445 +++++++++------------
 drivers/ieee1394/hosts.c                   |    7
 drivers/ieee1394/hosts.h                   |   19
 drivers/ieee1394/ieee1394_core.c           |   62 +-
 drivers/ieee1394/ieee1394_transactions.c   |   10
 drivers/ieee1394/nodemgr.c                 |   61 ++
 drivers/ieee1394/ohci1394.c                |   37 +
 drivers/ieee1394/ohci1394.h                |   10
 drivers/ieee1394/raw1394.c                 |   54 +-
 drivers/ieee1394/sbp2.c                    |   85 +---
 drivers/ieee1394/sbp2.h                    |   23 -
 drivers/ieee1394/video1394.c               |   16
 19 files changed, 463 insertions(+), 457 deletions(-)

Alexey Dobriyan:
	eth1394: endian fixes

Arjan van de Ven:
	Semaphore to mutex conversion.

Christoph Hellwig, Andrew Morton:
	ieee1394_core: switch to kthread API

Daniel Drake:
	video1394: be quiet

Jean-Baptiste Mur:
	ieee1394/ohci1394: CycleTooLong interrupt management

Jim Westfall:
	ieee1394: speed up of dma_region_sync_for_cpu

Jody McIntyre:
	Update feature removal of obsolete raw1394 ISO requests.

Robert Hancock:
	Fix broken suspend/resume in ohci1394

Stefan Richter:
	eth1394: replace __constant_htons by htons
	ieee1394: adjust code formatting in highlevel.c
	ieee1394: hl_irqs_lock is taken in hardware interrupt context
	ieee1394: add preprocessor constant for invalid csr address
	ieee1394: extend lowlevel API for address range properties
	ieee1394: save RAM by using a single tlabel for broadcast transactions
	ieee1394: support for slow links or slow 1394b phy ports
	ohci1394: make phys_dma parameter read-only
	ohci1394: set address range properties
	ohci1394: Remove superfluous call to free_dma_rcv_ctx,
	raw1394: fix whitespace after x86_64 compat patch
	sbp2: Kconfig fix
	sbp2: fix deregistration of status fifo address space
	sbp2: use __attribute__((packed)) for on-the-wire structures
	sbp2: provide helptext for CONFIG_IEEE1394_SBP2_PHYS_DMA and mark it experimental
	sbp2: fix S800 transfers if phys_dma is off
	sbp2: remove ohci1394 specific constant
	sbp2: log number of supported concurrent logins
	sbp2: remove manipulation of inquiry response
	sbp2: make TSB42AA9 workaround specific to Momobay CX-1

-- 
Stefan Richter
-=====-=-==- -==- =-=--
http://arcgraph.de/sr/
