Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbRFFKsm>; Wed, 6 Jun 2001 06:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261617AbRFFKsc>; Wed, 6 Jun 2001 06:48:32 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:23956 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261616AbRFFKsY> convert rfc822-to-8bit; Wed, 6 Jun 2001 06:48:24 -0400
From: COTTE@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: linux-kernel@vger.kernel.org
Message-ID: <C1256A63.003B564D.00@d12mta11.de.ibm.com>
Date: Wed, 6 Jun 2001 12:45:41 +0200
Subject: [question] why does grok_partitions clear blk_size[major]?
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi kernel-list-readers!

We just had a problem when running some formatting-utils on
a large amount of disks synchronously: We got a NULL-pointer
violation when accessig blk_size[major] for our major number.
Further research showed, that grok_partitions was running at
that time, which has been called by register_disk, which our
device driver issues after a disk has been formatted.
Grok_partitions first initializes blk_size[major] with a NULL
pointer, detects the partitions and then assigns the original
value to blk_size[major] again.
Can anyone explain to me, why grok_partitions has to clear
this pointer? Why is this all done without any lock which causes
race conditions all over the block-device layer (for example
generic_make_request() in ll_rw_blk.c first checks if the pointer
is set and afterwards accesses the array behind the pointer)?

mit freundlichem Gruﬂ / with kind regards
Carsten Otte

IBM Deutschland Entwicklung GmbH
Linux for 390/zSeries Development - Device Driver Team
Phone: +49/07031/16-4076
IBM internal phone: *120-4076
--
We are Linux.
Resistance indicates that you're missing the point!


