Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285850AbSBOBH5>; Thu, 14 Feb 2002 20:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285589AbSBOBHu>; Thu, 14 Feb 2002 20:07:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44553 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282902AbSBOBHd>; Thu, 14 Feb 2002 20:07:33 -0500
Subject: Re: [PATCH] write barriers for 2.4.x
To: mason@suse.com (Chris Mason)
Date: Fri, 15 Feb 2002 01:21:20 +0000 (GMT)
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <3728070000.1013734612@tiny> from "Chris Mason" at Feb 14, 2002 07:56:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bX3x-0001nu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sure we only try to use tag commands when they are turned on for the
> target, otherwise we can safely assume the drive won't do
> other writes first.

Is this guaranteed by the SCSI standards or do you need to issue some
kind of cache flush as with IDE ?

> With -o barrier, this is now:
> 
> write X log blocks
> write 1 commit block
> wait.

That will work nicely with the I2O controllers, and possibly (if its
in the firmware as well as the .h file) the aacraid cards. In those
cases I can often commit to battery backed ram rather than physical
media.

Do you have any idea of driving the cache write through rather than write
back is likely to help here by evening out the commit wait for a flush?
