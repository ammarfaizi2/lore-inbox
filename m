Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbTL2RIJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 12:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTL2RIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 12:08:09 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:50061 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S263618AbTL2RIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 12:08:05 -0500
Subject: Re: ataraid in 2.6.?
From: Christophe Saout <christophe@saout.de>
To: arjanv@redhat.com
Cc: Nicklas Bondesson <nicke@nicke.nu>, linux-kernel@vger.kernel.org
In-Reply-To: <1072691350.5223.7.camel@laptop.fenrus.com>
References: <S262196AbTL2AJ1/20031229000927Z+17179@vger.kernel.org>
	 <1072691350.5223.7.camel@laptop.fenrus.com>
Content-Type: text/plain
Message-Id: <1072717701.5152.123.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Dec 2003 18:08:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 29.12.2003 schrieb Arjan van de Ven um 10:49:
>
> the plan is to have a userspace device mapper app take it's place.
> As for the timeframe; I'm looking at it but the userspace device mapper
> code is still a bit of a mystory to me right now.

It is? I think it's kind of simple (probably, if you know what's going
on ;)). Which interface are you looking it?

I'm just looking at the ataraid code. Is my assumption correct, that it
simply interleaves sectors between two harddisks? Even sector number ->
hd1, odd number -> hd2?

Using the simple dmsetup tool one could try something like:

echo 0 $(expr $(blockdev --getsize /dev/<HD1>) \* 2) stripe 2 1
/dev/<HD1> 0 /dev/<HD2> 0 | dmsetup create ataraid

Where <HD1> and <HD2> should of course be replaced by the raw disks.

If everything is correct a device /dev/mapper/ataraid should be created.

Using libdevmapper something like:
dm_task_create(DM_DEVICE_CREATE)
dm_task_task_set_name (required)
dm_task_set_uuid (optional)
dm_task_add_target (only once in this case, contains the stripe target)
dm_task_set_ro (if readonly)
dm_task_set_major / _minor (if you don't want a dynamically allocated)
dm_task_run

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

