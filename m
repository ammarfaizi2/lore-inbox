Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbSLZSvJ>; Thu, 26 Dec 2002 13:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSLZSvJ>; Thu, 26 Dec 2002 13:51:09 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2308 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262449AbSLZSvH>;
	Thu, 26 Dec 2002 13:51:07 -0500
Date: Mon, 23 Dec 2002 19:17:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: acpi_os_queue_for_execution()
Message-ID: <20021223181747.GA10363@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Acpi seems to create short-lived kernel threads, and I don't quite
understand why. 

In thermal.c


                        tz->timer.data = (unsigned long) tz;
                        tz->timer.function = acpi_thermal_run;
                        tz->timer.expires = jiffies + (HZ * sleep_time) / 1000;
                        add_timer(&(tz->timer));

and acpi_thermal_run creates kernel therad that runs
acpi_thermal_check. Why is not acpi_thermal_check called directly? I
don't like idea of thread being created every time thermal zone needs
to be polled...
								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
