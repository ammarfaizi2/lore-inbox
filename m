Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129059AbRAaVcG>; Wed, 31 Jan 2001 16:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129060AbRAaVbq>; Wed, 31 Jan 2001 16:31:46 -0500
Received: from [194.213.32.137] ([194.213.32.137]:1540 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129028AbRAaVbZ>;
	Wed, 31 Jan 2001 16:31:25 -0500
Message-ID: <20010131223050.B231@bug.ucw.cz>
Date: Wed, 31 Jan 2001 22:30:50 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: [FYI] Power drain on notebook
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I played a bit with acpi on my toshiba, and got following figures
(toshiba satellite 4030cdt):

system powered on, disk spinning, backlight on, low brightness	12.8W
high brigtness							+0.8W
no backlight							-4.8W
while(1) loop							+7.2W
disk spindown							-0.5W
disk activity							+2.1W

Toshiba without backlight, idle cpu and disk spun down is        6.9W
Toshiba doing kernel compile takes				22.3W

That's quite a difference, and CPU (300MHz mobile celeron) seems to
take quite a lot of power (even in while(1) loop), which in turn means
that power managment is very important.

BTW compare these numbers with philips velo handheld: 0.4W idle
system, 0.6W with backlight, 1.3W system computing at max, <0.1W
system with slowed down clocks. In this case, CPU is able to take as
much power as the rest of system.

ACPI seems to be much better at saving heat from CPU: it replaces idle
loop and is able to conserve power pretty well. CPU seems to do 10x as
much instructions with APM -- probably due to kapmd design.

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org


----- End forwarded message -----

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
