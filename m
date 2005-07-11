Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVGKEPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVGKEPe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 00:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVGKEPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 00:15:34 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:40863 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262225AbVGKEPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 00:15:32 -0400
Date: Mon, 11 Jul 2005 06:15:31 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [2.6.12.2] unexpected block device behaviour ...
Message-ID: <20050711041531.GH31399@MAIL.13thfloor.at>
Mail-Followup-To: Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Folks! Andrew!

accidentially stumbled over the following issue:

creating a filesystem (in userspace) requires a period
of quiescence after that (about 5 seconds) until you
can reliably mount the new filesystem ...

this can be observed on 2.6.11 as well as 2.6.12.2
(didn't test older kernels yet) on x86_64 (SMP) with
loopback or dm (lvm2) based block devices (probably
also with other block devices) for different file-
systems (ext2,ext3,xfs,jfs,reiserfs) ...

Rik and I agreed that it is at least unexpected
behaviour, especially as doing an fsync() on the
block device doesn't remedy the deficiency.


so the sequence to 'trigger' this basically is:

  mkfs.* $DEV
  mount $DEV $MNT

and the mount fails sometimes with:
mount: wrong fs type, bad option, bad superblock on /dev/*,
       missing codepage or other error
(but works quite fine if you wait 10 seconds)

here are some scripts (and example output) I used 
for testing this ...

http://vserver.13thfloor.at/Stuff/x.sh
http://vserver.13thfloor.at/Stuff/x.sh.txt

http://vserver.13thfloor.at/Stuff/x2.sh
http://vserver.13thfloor.at/Stuff/x2.sh.txt


best,
Herbert

