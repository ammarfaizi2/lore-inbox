Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVLTURu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVLTURu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVLTURu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:17:50 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:40129 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S932078AbVLTURt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:17:49 -0500
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: [RFC] Let non-root users eject their ipods?
To: Bill Davidsen <davidsen@tmr.com>, sander@humilis.net,
       Willy Tarreau <willy@w.ods.org>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, greg@kroah.com, axboe@suse.de,
       vandrove@vc.cvut.cz, aia21@cam.ac.uk, akpm@osdl.org
Reply-To: 7eggert@gmx.de
Date: Tue, 20 Dec 2005 21:21:33 +0100
References: <5lFTx-7L1-9@gated-at.bofh.it> <5lIeC-3hP-3@gated-at.bofh.it> <5lIRn-4GE-19@gated-at.bofh.it> <5lLw7-1f5-43@gated-at.bofh.it> <5lM8s-2D4-1@gated-at.bofh.it> <5lM8F-2D4-39@gated-at.bofh.it> <5lSQE-87T-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EonzK-0001Ca-3v@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> wrote:

> Using umount still leaves the iPod flashing a "do not disconnect"
> message as I recall, while eject clears it. So while umount may be all
> the o/s needs, and all some external storage media need, it may be
> highly desirable to do the eject for the benefit of the attached device,
> to cue it to finish whatever it's caching internally. Whatever eject
> does clearly is device visible, and in the case of iPod the device
> objects if it isn't given.

There is an auto-eject function causing the media to be ejected on the last
user closing the device. Unfortunately it makes the device open itself
during mounts, and setting this flag will inevitably eject the media.
Additionally, it didn't work with my SCSI cdroms.

With slight changes, it could do the trick.


OTOH, we could also introduce the 'eject' mount option to let umount() eject
the media after the (last if possible) mount is gone. This will behave sane
for audio CDs, too.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
