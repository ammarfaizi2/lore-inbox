Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318160AbSGWQ7G>; Tue, 23 Jul 2002 12:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318161AbSGWQ7G>; Tue, 23 Jul 2002 12:59:06 -0400
Received: from [216.167.57.166] ([216.167.57.166]:35082 "EHLO
	liveglobalbid.com") by vger.kernel.org with ESMTP
	id <S318160AbSGWQ7C>; Tue, 23 Jul 2002 12:59:02 -0400
Message-ID: <3D3D8C13.964BF50D@liveglobalbid.com>
Date: Tue, 23 Jul 2002 11:02:12 -0600
From: Roe Peterson <roe@liveglobalbid.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac24 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RAID1 on 2.5.27 - bug in close_sync?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Running on a linux 7.3 full distro, installed the 2.5.27 kernel.

It seems that, if the root filesystem is running on /dev/md0,
and a resync happens, there is a bug in drivers/md/raid1.c at
line 648:

    if (waitqueue_active(&conf->wait_resume)) BUG();

Needless to say, the BUG happens.  As a result, the md0
raid1 array is never marked clean.

Any ideas?

