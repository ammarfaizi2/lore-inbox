Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271367AbRICHwg>; Mon, 3 Sep 2001 03:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271321AbRICHw0>; Mon, 3 Sep 2001 03:52:26 -0400
Received: from virtualro.ic.ro ([194.102.78.138]:527 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S271320AbRICHwO>;
	Mon, 3 Sep 2001 03:52:14 -0400
Date: Mon, 3 Sep 2001 10:52:44 +0300 (EEST)
From: Jani Monoses <jani@astechnix.ro>
To: linux-kernel@vger.kernel.org
Subject: ide_delay_50ms question
Message-ID: <Pine.LNX.4.10.10109031045530.12103-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi
could anybody tell me why is the mdelay(50) solution better than the
schedule_timeout(HZ/20) in ide_delay_50ms.I suppose because it is bootime
and there is nothing to schedule.
But then the condition should also extend to CONFIG_BLK_DEV_IDECS_MODULE
as well, because when I insert an IDE compactflash card things stop for a
second or so nad I use a modular driver.
And I don't know about removable harddrives but isn't the schedule_timeout
solution better for them as well?


void ide_delay_50ms (void)
{
#ifndef CONFIG_BLK_DEV_IDECS
        mdelay(50);
#else
        __set_current_state(TASK_UNINTERRUPTIBLE);
        schedule_timeout(HZ/20);
#endif /* CONFIG_BLK_DEV_IDECS */
}


