Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbSK0M3R>; Wed, 27 Nov 2002 07:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262464AbSK0M3R>; Wed, 27 Nov 2002 07:29:17 -0500
Received: from web21508.mail.yahoo.com ([66.163.169.19]:2899 "HELO
	web21508.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262457AbSK0M3P>; Wed, 27 Nov 2002 07:29:15 -0500
Message-ID: <20021127123634.84689.qmail@web21508.mail.yahoo.com>
Date: Wed, 27 Nov 2002 12:36:34 +0000 (GMT)
From: =?iso-8859-1?q?Neil=20Conway?= <nconway_kernel@yahoo.co.uk>
Subject: Re: FS-corrupting IDE bug still in 2.4.20-rc3
To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Cc: nconway_kernel@yahoo.co.uk
In-Reply-To: <200211271158.13771.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc...

 --- Marc-Christian Petersen <m.c.p@wolk-project.de> wrote:
> You may try that patch with a VIA boxen and I am quite sure you may
> experience 
> a bug that none of your harddisks may be recognized and result in a 
> panic();

Aha...  Actually, if you read the patch, you'll see why that's no
longer the case.  I had in fact forgotten that I'd had to patch the
patch to make my VIA box boot (it was 6 months ago now!).  I now do "if
(hwgroup) ..." in the test-for-busy section.  So, the new patch does
NOT now cause panics on VIA.

> I had the same Fix in WOLK some time ago and many users with VIA
> chipset 
> complained that with the fix their mashine does not recognize any
> harddisks 
> and after trying to recognize they had a panic();

Yes, only some chipsets end up in ide_config_drive_speed() at bootup;
notably the PIIX doesn't and the VIA does.  Mea culpa!  I should have
posted the fixed patch perhaps, but then it was deprecated and I
thought Andre had a better fix in hand.  (BTW, when you say you had
"the same fix", you mean you fixed it independently or you used my
patch from May '02?)

> Maybe it's working for you with some VIA chipsets but I removed that
> fix and 
> after removal all users with VIA were happy. I've never heard of a FS
> corruption of them.

Well, do they have the trigger ingredients?  You MUST have an IDE CDROM
sharing a bus with a HDD.  Also, the perfect recipe for disk corruption
is to reboot, and then log in to your chosen desktop, and while it's
hammering the disk starting everything up, it should fire off
"magicdev", which in turn loads ide-cd: BOOM.  RedHat 7.x with GNOME
does things in this order.  YMMV.

Neil

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
