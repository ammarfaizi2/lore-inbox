Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947276AbWKKQk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947276AbWKKQk1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 11:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947277AbWKKQk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 11:40:27 -0500
Received: from ns2.g-housing.de ([81.169.133.75]:13232 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1947276AbWKKQkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 11:40:24 -0500
Date: Sat, 11 Nov 2006 16:40:17 +0000 (GMT)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: evil@sheep.housecafe.de
To: linux-kernel@vger.kernel.org
Subject: OOM in 2.6.19-rc*
Message-ID: <Pine.LNX.4.64.0611111318230.1247@sheep.housecafe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

a few days ago I upgraded my desktop machine (x86_64) to ubuntu/edgy 
thus completely changing the userland. Since I'm using kernel.org 
kernels I upgraded to a current kernel as well (2.6.19-rc4-git from Nov 
4 and 2.6.19-rc4-mm2). Now, while working under X11, probably reading 
email, all of a sudden the machine was not responsible any more and the 
disk was spinning like wild. The desktop applet showed all swap being 
used up then the display froze too and ~5 min later the machine came 
back with the gnome-login screen: it had not rebooted but ran OOM and 
several apps got killed.

OK, must be some application leaking memory, I thought, that's what 
happens to new userland version. Looking at the syslog, "nautilus" 
(gnome filemanager) invoked the oom killer. OK, but the scenario 
repeated the next day, early in the morning when I was not even on the
box, saying it was nautilus again.
In the last days other applications seem to invoke the OOM killer as
well and I wonder if each one of them is really to blame for leaking 
memory or something else would be responsible for the killings. Here's 
log output, each listing the first appliction triggering the OOM killer:

# for i in /var/log/messages*; do (zgrep "invoked" "$i" | head -1 ); done
Nov 11 08:04:16 prinz64 kernel: [104237.902269] firefox-bin invoked oom-killer: gfp_mask=0x201d2, order=0, oomkilladj=0
Nov 10 07:59:34 prinz64 kernel: [64627.382818] Xorg invoked oom-killer: gfp_mask=0x201d2, order=0, oomkilladj=0
Nov  9 07:59:22 prinz64 kernel: [25047.487534] rpc.idmapd invoked oom-killer: gfp_mask=0x201d2, order=0, oomkilladj=-17
Nov  8 17:33:59 prinz64 kernel: [  919.954547] beep-media-play invoked oom-killer: gfp_mask=0x201d2, order=0, oomkilladj=0
Nov  7 18:55:23 prinz64 kernel: [  842.590646] firefox-bin invoked oom-killer: gfp_mask=0x201d2, order=0, oomkilladj=0
Nov  5 07:55:34 prinz64 kernel: [18128.545690] nautilus invoked oom-killer: gfp_mask=0x201d2, order=0, oomkilladj=0
Nov  4 17:31:23 prinz64 kernel: [  688.904652] nautilus invoked oom-killer: gfp_mask=0x201d2, order=0, oomkilladj=0

The kernels running when these were happening:
Nov  4 - 2.6.19-rc2
Nov  5 - 2.6.19-rc2
Nov  7 - 2.6.19-rc4-mm2
Nov  8 - 2.6.19-rc4
Nov  9 - 2.6.19-rc4
Nov 10 - 2.6.19-rc4
Nov 11 - 2.6.19-rc4

Because killing these application does not seem to free up memory, 
plenty of other applications got killed shortly after this. Full logs
and .config can be found here: http://nerdbynature.de/bits/2.6.19-rc4/

I do notice anacron running just before the killings - but: even *if* 
anacron runs a mem-leaking program: should the OOM killer just kill that 
app and not the (probably) innocent ones in the first place?

Thanks for your thoughts,
Christian.
-- 
BOFH excuse #194:

We only support a 1200 bps connection.
