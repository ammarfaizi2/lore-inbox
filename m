Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288149AbSACChR>; Wed, 2 Jan 2002 21:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288145AbSACCg6>; Wed, 2 Jan 2002 21:36:58 -0500
Received: from hera.cwi.nl ([192.16.191.8]:20397 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S288144AbSACCgv>;
	Wed, 2 Jan 2002 21:36:51 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 3 Jan 2002 02:36:26 GMT
Message-Id: <UTC200201030236.CAA194545.aeb@cwi.nl>
To: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: PATCH 2.5.2.6: fix up serial, sysrq
Cc: viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Jeff Garzik <jgarzik@mandrakesoft.com>

    The kdev_none change might not be correct, please check.

Indeed, I would say it is not.

    -        if (!is_local_disk(sb->s_dev) && MAJOR(sb->s_dev))
    +        if (!is_local_disk(sb->s_dev) && !kdev_none(sb->s_dev))
                 go_sync(sb, remount_flag);

Without studying the surrounding code, I conjecture that
the test MAJOR(sb->s_dev) was meant to exclude anonymous
devices (with major 0), not only NODEV.

Andries
