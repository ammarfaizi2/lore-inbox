Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVCLKJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVCLKJz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 05:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVCLKJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 05:09:55 -0500
Received: from mx3.informatik.uni-stuttgart.de ([129.69.211.42]:8186 "EHLO
	mx3.informatik.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id S261176AbVCLKJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 05:09:49 -0500
Date: Sat, 12 Mar 2005 11:09:47 +0100
From: Nils Radtke <Nils.Radtke@Think-Future.de>
To: omer ayfer <tmp25@ayfer.net>
Cc: Linux Kernel-Liste <linux-kernel@vger.kernel.org>
Subject: Re: ethX interface rx errors
Message-ID: <20050312110947.A31862@marvin.informatik.uni-stuttgart.de>
Reply-To: Nils Radtke <Nils.Radtke@Think-Future.de>
Mail-Followup-To: Nils Radtke <Nils.Radtke@Think-Future.de>,
	omer ayfer <tmp25@ayfer.net>,
	Linux Kernel-Liste <linux-kernel@vger.kernel.org>
References: <1110606664.42328348c38aa@omer.ayfer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1110606664.42328348c38aa@omer.ayfer.net>; from tmp25@ayfer.net on Fri, Mar 11, 2005 at 09:51:04PM -0800
X-Url: http://www.Think-Future.de
X-Editor: Vi it! http://www.vim.org
X-Bkp: p2mi
X-GnuPG-Key: gpg --keyserver search.keyserver.net --recv-keys 06232116
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Hi Omer, hi others,


# i'm wondering if you ever found a solution to the problem you
# have described here: http://lkml.org/lkml/2004/12/5/81
I'll send a small update today with this email.

# i'm having the exact same issue with one of my linux machines,
# and i would really appreciate any advice you can give.

Only symptomatical cure: reboot. 
But: Make sure you power off and boot up, consecutively!! 

Just reboot will not work (at least for me). Make your box having a complete
power cycle.

uptime: 10:55:35 up 6 days, 19:06,  1 user,  load average: 1.11, 0.89, 0.85
So far, now rx errors. Yet.
Linux service 2.6.10service #1 Thu Jan 6 21:53:31 CET 2005 i686 GNU/Linux
and
Linux service 2.6.11tf #1 Thu Jan 6 21:53:31 CET 2005 i686 GNU/Linux

root@service:~# ifconfig eth0     
eth0      RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

root@service:~# ifconfig eth1 
eth1      RX packets:27521716 errors:0 dropped:0 overruns:0 frame:0
          TX packets:43011137 errors:0 dropped:0 overruns:10 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:2384780308 (2.2 GiB)  TX bytes:2096012953 (1.9 GiB)

Using bridge:
br0       RX packets:27490318 errors:0 dropped:0 overruns:0 frame:0
          TX packets:43026044 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:2009612925 (1.8 GiB)  TX bytes:2082138120 (1.9 GiB)

BTW (OT): Would be great having vpn/racoon being capable getting attached to
network devices. This way you could implement transparent vpn. VPN:
WLAN <--> LAN, all same (sub)net but encrypted on the wireless half.
(vrf?, hm did not chk that, so far)

Use latest (vanilla) kernels. I do not have any experiences with other
kernels, be it -ac, -mm, rh, suse, debian. Honestly, I do not want to
use them any longer. (Yes, ok, there _is_ experience, but, you know..;-)

2.6.10 had some serious trouble. I. e. (OT) suspend/resume on notebooks:
did not restore hw clock time. 2.6.11 does. 2.6.10: problem with ati
driver, but 2.6.11 does not.

There seems to be a serious relation with USB. Having whatever usb
device connected (it is _not_ important whether this device got its
modules loaded!) it accelerates the rx error count increase. 

I first suspected the binary webcam module for the philips webcams
responsible. But now, I tend to say that was rather hasardous. That
binary module is responsible for kernel Oopses in the USB context.
This might be the connection between these premisses.
Don't think too much about that module beeing responsible for the rx
errors, any more. 
And I do not use the webcam any longer.. Pity, quality is quite good.

It renders also more possible the first rx error. If w/o usb device the
first occurrence is under havy (net or not?) load after an hour, it will
quite sure be after 2 minutes with usb device attached..

There might be a correlation with samba! smbd/nmbd seems prone to cause
similar effects. 

What is no problem is to recognise remotely that you _have_ the problem "rx
errors": just try to transfer a at leas 10mb file to the problematic box 
running the samba server. Let's have a coffee or sex or read a book or whatever
meanwhile. If you come back to your so long ago started upload: Do not
be stunned, it will not have finished yet. In fact, it never will..
 
# thanks very much.
You're welcome. At least we're not alone ;-)
Actually, there are about 4 to 5 known people out there having this problem.
Not too much, it seems. But it also seems an (slowly) increasing number.

AND: they are all using rtl chipset cards. But: Know that the rx error
problem occurred with 3com 3c905 also!

One more detail: in circumstances without any rx errors the maximum
throughput (using samba) reached on site is about 4-5MB per second.

Hope could help somehow..


        Nils


-- 
A+
* N.Radtke@                 * University of Stuttgart *    icq / lc   *
*      www.Think-Future.de  *    dep.comp.science     * 9336272/92045 *
:x                            UTM 32 0515651 5394088                 :)
   Overdrawn?  But I still have checks left! 
   
   
