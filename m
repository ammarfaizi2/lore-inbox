Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268297AbRGZQXZ>; Thu, 26 Jul 2001 12:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268265AbRGZQXP>; Thu, 26 Jul 2001 12:23:15 -0400
Received: from congress199.linuxsymposium.org ([209.151.18.199]:6661 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S268231AbRGZQXG>;
	Thu, 26 Jul 2001 12:23:06 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107261622.f6QGMqU17740@lynx.adilger.int>
Subject: Re: Weird ext2fs immortal directory bug
To: sentry21@cdslash.net
Date: Thu, 26 Jul 2001 10:22:52 -0600 (MDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0107261028000.18300-100000@spring.webconquest.com> from "sentry21@cdslash.net" at Jul 26, 2001 10:37:21 AM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Dan writes:
> sentry21@Petra:1:/lost+found$ sudo rm -rf \#3147/
> rm: cannot unlink `#3147': Operation not permitted
> 
> Weird, ne? I -did- manage to make it -not rwxrwxrwx, suid, sgid, sticky,
> and every other bloody FS flag you can stick on a directory (and lots you
> can't), but it's still impervious to my sk|llz. It's not hurting anything,
> but cron whines about it every day.

Run "debugfs -w /dev/hdX", and then:

debugfs> mi <3147>
# set Mode to 0
# set Deletion time to something other than 0
# set Link count to 0
# set Block count to 0
# set File flags to 0
debugfs> freei <3147>
debugfs> q

e2fsck -f /dev/hdX

Cheers, Andreas
-- 
Andreas Dilger                               Turbolinux filesystem development
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/
