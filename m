Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263985AbUDNIoe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 04:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263988AbUDNIoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 04:44:34 -0400
Received: from math.ut.ee ([193.40.5.125]:35819 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S263985AbUDNIo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 04:44:28 -0400
Date: Wed, 14 Apr 2004 11:31:28 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Adrian Bunk <bunk@fs.tum.de>, <linux-kernel@vger.kernel.org>,
       <linux-ide@vger.kernel.org>
Subject: Re: [2.4 IDE PATCH] SanDisk is flash (fwd)
In-Reply-To: <200404132212.11481.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.GSO.4.44.0404141115010.28974-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some time ago I sent mail to Meelis asking if this patch is really necessary.

Oops, it must have been our university's mail server havein breakfast of
my mail again :(

> Does this mean that CF test fail or that SunDisk is SanDisk now?

Just that SunDisk is now SanDisk. The patch was developed in 2.4 to
quieten flash disk detection messages. The important part was about host
protected area detection that is already different in 2.6 (*). In
addition, the name change was noticed and fixed. It resulted in
different display (not ATA but CFA) and told the ide layer that the disk
does not have door locking but I don't know whether it actually changes
some important behaviour.

> id->config == 0x848a test was introduced in kernel 2.3.27 _after_
> SunDisk model name test and if id->config == 0x848a test fails
> comment to drive_is_flashcard() needs fixing.

I don't have the hardware currently at hand but I can let people who
have test it. I only know for sure that it changes the display of "ATA"
to "CFA" in 2.4.22 where the patch was developed. This was before the
patch:
hda: SanDisk SDP3B-64, ATA DISK drive

(*) The host protected area fix for 2.4 was to do
idedisk_read_native_max_address(drive) only when
idedisk_supports_host_protected_area(drive) was true. By my quick look
it seemed that 2.6 already does this check in init_idedisk_capacity()
and 2.6 does not need the other patch - am I right here?

-- 
Meelis Roos (mroos@linux.ee)

