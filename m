Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVAWWMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVAWWMk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 17:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVAWWMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 17:12:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:48547 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261365AbVAWWMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 17:12:38 -0500
From: Andrew Tridgell <tridge@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16884.8352.76012.779869@samba.org>
Date: Mon, 24 Jan 2005 09:09:36 +1100
To: Andreas Gruenbacher <agruen@suse.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Andreas Dilger <adilger@clusterfs.com>, Alex Tomas <alex@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ea-in-inode 0/5] Further fixes
In-Reply-To: <1106351172.19651.102.camel@winden.suse.de>
References: <20050120020124.110155000@suse.de>
	<1106348336.1989.484.camel@sisko.sctweedie.blueyonder.co.uk>
	<1106351172.19651.102.camel@winden.suse.de>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas,

 > Tridge, can you beat the code some more?
 > 
 > Andrew has the five fixes in 2.6.11-rc1-mm2.

It seemed to pass dbench runs OK, but then I started simultaneously
running dbench and nbench on two different disks (I have a new test
machine with more disks available). I am getting failures like this:

Jan 23 06:54:38 dev4-003 kernel: journal_bmap: journal block not found at offset 1036 on sdc1
Jan 23 06:54:38 dev4-003 kernel: Aborting journal on device sdc1.


Jan 23 13:19:43 dev4-003 kernel: journal_bmap: journal block not found at offset 1036 on sdd1
Jan 23 13:19:43 dev4-003 kernel: Aborting journal on device sdd1.
Jan 23 13:19:43 dev4-003 kernel: EXT3-fs error (device sdd1) in start_transaction: Readonly filesystem


The first failure was on the disk I am using for nbench (sdc). The
second is during a later run on the disk I am using the dbench
(sdd). I rebooted between the runs. It's interesting that its failing
at exactly the same offset both times. Is there anything magic about
offset 1036?

The new test machine is a 4 way PIII, with 4G ram, and 4 36G SCSI
disks. The test machine I have been using previously was a 2 way
(+hyperthreaded) Xeon.

I'll see if I can reproduce the problem with just dbench or just
nbench.

Cheers, Tridge
