Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVCCAXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVCCAXQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 19:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVCCAUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 19:20:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45756 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261407AbVCCASO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 19:18:14 -0500
Message-ID: <422657B5.7030702@pobox.com>
Date: Wed, 02 Mar 2005 19:17:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: workflow (was Re: RFD: Kernel release numbering)
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Other ideas <thinking out loud>...

I maintain my netdev-2.6 queue by creating a ton of "subject-specific" 
repositories locally,

> 8139cp/     bonding/  ieee80211/    mips/     sis900/    typhoon/
> 8139too/    e1000/    ixgb/         misc/     skge/      viro-iomap/
> 8139too-2/  ham/      janitor/      mv643xx/  sk_mca/    viro-iomap-orinoco/
> ALL/        ibmlana/  kill-iphase/  pcnet32/  smc91x/    viro-isa-ectomy/
> atmel/      ibmtr/    mii/          s2io/     sundance/  wifi/

and I pull all of these into a master repository netdev-2.6 (locally 
'ALL').  netdev-2.6, in turn, gets pulled into -mm when Andrew makes a 
new release.  When I am ready to push something upstream, I pull one or 
more repositories into my net-drivers-2.6 queue, which is essentially my 
"push to upstream" queue.

This scheme allows me to cherry-pick fixes and features.  If a critical 
fix comes along, it doesn't have to wait for the other less-critical 309 
changesets to go.


We could have a linus-pending-2.6 queue, managed by Linus, that 
functions in a similar manner to my netdev-2.6:

a) Have a monthly or weekly official release.  Could be automated, but 
probably not.

b) snapshots of linus-pending-2.6 function as a development tree, taking 
over some of the current -mm purpose...  -mm is just too massive and 
multi-purpose at this point

c) locally [or publicly?], Linus sorts patches and 'bk pulls' into 
specific repositories, as I do with netdev-2.6.  "sata", "sata-fixes", 
"net drivers", "net drivers - janitorial", etc. could be potential pull 
queues from me to Linus.

d) When features/fixes are ready to move from linus-pending-2.6 to 
linux-2.6 repository, Linus just does a pull+push locally.  Fixes would 
likely go immediately into linux-2.6, unless it needs staging in 
linus-pending-2.6 first.  Potentially destabilizing stuff stays longer 
in linus-pending-2.6.

Thus, Linus controls the patch flow (and stability/features) simply by 
choosing when to pull stuff from the on-going dev tree that he manages.

e) Andrew continues doing what he's been doing:  merging tons of 
patches, staging big features, etc.


So what does this accomplish, besides increasing the complexity of 
Linus's work?  What's the point?

1) Creates a structure to enable linux-2.6 to be the on-going stable 
tree, by creating an official on-going dev tree.

2) Release early, release often.  The proposal that started this thread 
does the opposite: it slows things down.

3) Makes it easier to manage the flow of changesets.

4) Takes pressure off -mm to be "everything under the sun."  Users are 
far more likely to test a tree that is blessed with Holy Penguin Pee, 
and builds on all architectures.  And this in turn gives -mm more freedom.

	Jeff, trying to think outside the box



