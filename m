Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315355AbSDWWJB>; Tue, 23 Apr 2002 18:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315356AbSDWWJA>; Tue, 23 Apr 2002 18:09:00 -0400
Received: from 54-193-ADSL.red.retevision.es ([80.224.193.54]:12635 "EHLO
	quakers.net") by vger.kernel.org with ESMTP id <S315355AbSDWWI6>;
	Tue, 23 Apr 2002 18:08:58 -0400
Message-ID: <3CC5DB3D.6050807@jazzfree.com>
Date: Wed, 24 Apr 2002 00:07:57 +0200
From: Manuel Clos <llanero@jazzfree.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en, es-es
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.17 with Tulip driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using kernel 2.4.17 from kernel.org, patched to use the preemptive + 
low latency features. I have never had I problem until I have started to 
use the eth0 which is detected as:

kernel: eth0: Lite-On 82c168 PNIC rev 32 at 0xa800, 00:C0:F0:56:CE:74, 
IRQ 10.

I think it is called LNE 100tx under windows, at least these are the 
drivers I use for it.

After using it for 3-4 hours it locks my machine, but this is random, 
sometimes it happens soon. I have seen various messages in 
/var/log/messages:

Apr 22 18:53:26 quakers kernel: ethereal uses obsolete (PF_INET,SOCK_PACKET)
Apr 22 18:54:02 quakers kernel: eth0: Promiscuous mode enabled.
Apr 22 18:54:02 quakers kernel: device eth0 entered promiscuous mode
Apr 22 18:59:53 quakers kernel: eth0: Promiscuous mode enabled.
Apr 22 18:59:53 quakers kernel: device eth0 left promiscuous mode
<more last 2 lines messages>
<CRASH>

After the reboot, with no X and no programs other than a shell:

Apr 22 19:28:49 quakers kernel: NETDEV WATCHDOG: eth0: transmit timed out
Apr 22 19:29:25 quakers last message repeated 3 times
< CRASH>

And here is the Oops I received:
Apr 22 19:40:47 quakers kernel: ethereal uses obsolete (PF_INET,SOCK_PACKET)
Apr 22 19:40:58 quakers kernel: eth0: Promiscuous mode enabled.
Apr 22 19:40:58 quakers kernel: device eth0 entered promiscuous mode
Apr 22 19:52:36 quakers -- MARK --
Apr 22 20:12:36 quakers -- MARK --
Apr 22 20:32:36 quakers -- MARK --
Apr 22 20:52:36 quakers -- MARK --
Apr 22 21:12:36 quakers -- MARK --
Apr 22 21:32:36 quakers -- MARK --
Apr 22 21:52:36 quakers -- MARK --
Apr 22 22:12:36 quakers -- MARK --
Apr 22 22:32:36 quakers -- MARK --
Apr 22 22:52:36 quakers -- MARK --
Apr 22 22:59:51 quakers kernel: eth0: Promiscuous mode enabled.
Apr 22 23:00:06 quakers kernel: eth1: Setting promiscuous mode.
Apr 22 23:00:06 quakers kernel: device eth1 entered promiscuous mode
Apr 22 23:12:36 quakers -- MARK --
Apr 22 23:32:36 quakers -- MARK --
Apr 22 23:33:45 quakers kernel:  printing eip:
Apr 22 23:33:45 quakers kernel: d48869ec
Apr 22 23:33:45 quakers kernel: Oops: 0000
Apr 22 23:33:45 quakers kernel: CPU:    0
Apr 22 23:42:47 quakers exiting on signal 15

This time only the keyboard was blocked, so I could use the mouse to 
close XWindows.

This happened also a long time ago with kernel 2.4.4, and I have'nt used 
the card since then. Here is the old log:

May 12 19:56:51 quakers kernel: eth0: Setting half-duplex based on MII#1 
link partner capability of 00a1.
May 12 20:02:21 quakers kernel: eth0: Setting half-duplex based on MII#1 
link partner capability of 00a1.
May 12 20:16:12 quakers -- MARK --
May 12 20:19:02 quakers kernel: NETDEV WATCHDOG: eth0: transmit timed out
May 12 20:19:34 quakers last message repeated 4 times
May 12 20:20:26 quakers last message repeated 6 times
May 12 20:20:43 quakers kernel: spurious 8259A interrupt: IRQ7.
May 12 20:22:30 quakers kernel: NETDEV WATCHDOG: eth0: transmit timed out
May 12 20:22:54 quakers last message repeated 3 times
May 12 20:23:26 quakers kernel: SysRq: SAK
May 12 20:23:26 quakers kernel: smb_get_length: recv error = 512
May 12 20:23:26 quakers kernel: smb_request: result -512, setting invalid
May 12 20:23:29 quakers kernel: SysRq: SAK
May 12 20:23:37 quakers kernel: NETDEV WATCHDOG: eth0: transmit timed out
May 12 20:23:45 quakers kernel: NETDEV WATCHDOG: eth0: transmit timed out
May 12 20:26:07 quakers kernel: NETDEV WATCHDOG: eth0: transmit timed out
May 12 20:26:08 quakers kernel: SysRq: Emergency Sync
May 12 20:26:08 quakers kernel: Syncing device 03:02 ... OK
May 12 20:26:08 quakers kernel: Syncing device 03:01 ... OK
May 12 20:26:08 quakers kernel: Syncing device 03:04 ... OK
May 12 20:26:08 quakers kernel: Done.


The current machine is:
Linux llanero 2.4.17 #9 Mon Apr 15 22:02:35 CEST 2002 i686 unknown

Hope this helps you enhance the tulip driver.

If you need any other info please tell me.

I suppose that this is not a hardware problem since I use it under 
windows with no problems for more than 6 hours. Also, searching google, 
this seems to be a problem solved in some tulip driver available for 2.2 
but not for 2.4. I can search google again if needed.

Please CC me as I'm not subscribed.

Thanks.

-- 
Manuel Clos
llanero@jazzfree.com

* Si no puedes hacerlo bien, hazlo bonito (Bill Gates)
* If you can't do it well, do it nice (Bill Gates)

