Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWHVKkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWHVKkG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 06:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWHVKkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 06:40:06 -0400
Received: from p02c11o146.mxlogic.net ([208.65.145.69]:32979 "EHLO
	p02c11o146.mxlogic.net") by vger.kernel.org with ESMTP
	id S932160AbWHVKkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 06:40:05 -0400
Date: Tue, 22 Aug 2006 13:37:31 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: pavel@suse.cz, linux-pm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: T60 not coming out of suspend to RAM
Message-ID: <20060822103731.GC13782@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 22 Aug 2006 10:43:57.0406 (UTC) FILETIME=[DED947E0:01C6C5D7]
X-Spam: [F=0.0100000000; S=0.010(2006081701)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I'm running Linus' git tree on my thinkpad T60.
It generally seems to work fine after suspend to disk.
However, the system does not come out of suspend to ram,
with screen staying blank. I'm looking for hints for debugging this.

If I set suspend/resume event tracing, I see this in dmesg
after reboot:

dmesg -s 1000000 | grep 'hash matches'
  hash matches drivers/base/power/resume.c:42
  hash matches device serio2

serio2 seems to be the psmouse device:
ls /sys/bus/serio/drivers/psmouse/
bind bind_mode description serio0 serio2 unbind

Does this mean the mouse driver blocks the resume?

I've rebuilt psmouse as a module, unloaded it before suspend, and now
I see the same behaviour but after reboot:
dmesg -s 1000000 | grep 'hash matches'
  hash matches drivers/base/power/resume.c:42
  hash matches device i2c-9191

Which is somewhat weird because
ls /sys/bus/i2c/devices
does not list any i2c devices

I could continue disabling stuff - but I am looking in the
correct place even? How do you debug resume issues?

Thanks,

-- 
MST
