Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVC3SDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVC3SDo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVC3SDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:03:43 -0500
Received: from 64-30-195-78.dsl.linkline.com ([64.30.195.78]:61642 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S262373AbVC3SDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:03:38 -0500
Message-ID: <424AE9E0.8040601@jg555.com>
Date: Wed, 30 Mar 2005 10:03:12 -0800
From: Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 64bit build of tulip driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under 32bit the tulip driver works fine, but under 64 bit it gives me a 
lot if problems. I updated the tulip
to what is in the current repository, and the issue still exists. Any 
suggestions.

First off it continually sends data out the network interface and never 
negotiates is speed and duplex.
Second in the log files all I see is an uninformative message 
0000:00:07.0: tulip_stop_rxtx() failed

Here is all the bootup information differences I can find on the driver
64 bit
Dec 31 16:01:29 lfs tulip0: ***WARNING***: No MII transceiver found!
Dec 31 16:01:29 lfs tulip1: ***WARNING***: No MII transceiver found!
32 bit
Dec 31 16:01:16 lfs tulip0:  MII transceiver #1 config 1000 status 7809 
advertising 01e1
Dec 31 16:01:16 lfs tulip1:  MII transceiver #1 config 1000 status 7809 
advertising 01e1.

Complete boot log - yes I know the date and time are off.
Under a 64 bit compile
Dec 31 16:01:29 lfs Linux Tulip driver version 1.1.13 (May 11, 2002)
Dec 31 16:01:29 lfs PCI: Enabling device 0000:00:07.0 (0045 -> 0047)
Dec 31 16:01:29 lfs tulip0: Old format EEPROM on 'Cobalt Microserver' 
board.  Using substitute media control info.
Dec 31 16:01:29 lfs tulip0:  EEPROM default media type Autosense.
Dec 31 16:01:29 lfs tulip0:  Index #0 - Media MII (#11) described by a 
21142 MII PHY (3) block.
Dec 31 16:01:29 lfs tulip0: ***WARNING***: No MII transceiver found!
Dec 31 16:01:29 lfs eth0: Digital DS21143 Tulip rev 65 at 
ffffffffb0001400, 00:10:E0:00:32:DE, IRQ 19.
Dec 31 16:01:29 lfs PCI: Enabling device 0000:00:0c.0 (0005 -> 0007)
Dec 31 16:01:29 lfs tulip1: Old format EEPROM on 'Cobalt Microserver' 
board.  Using substitute media control info.
Dec 31 16:01:29 lfs tulip1:  EEPROM default media type Autosense.
Dec 31 16:01:29 lfs tulip1:  Index #0 - Media MII (#11) described by a 
21142 MII PHY (3) block.
Dec 31 16:01:29 lfs tulip1: ***WARNING***: No MII transceiver found!
Dec 31 16:01:29 lfs eth1: Digital DS21143 Tulip rev 65 at 
ffffffffb0001480, 00:10:E0:00:32:DF, IRQ 20.
Dec 31 16:01:29 lfs bootlog:  Bringing up the eth0 interface...[  OK  ]
Dec 31 16:01:30 lfs bootlog:  Adding IPv4 address 172.16.0.99 to the 
eth0 interface...[  OK  ]
Dec 31 16:01:31 lfs bootlog:  Setting up default gateway...[  OK  ]
Dec 31 16:01:32 lfs 0000:00:07.0: tulip_stop_rxtx() failed
Dec 31 16:01:38 lfs 0000:00:07.0: tulip_stop_rxtx() failed
Dec 31 16:01:44 lfs 0000:00:07.0: tulip_stop_rxtx() failed
Dec 31 16:01:50 lfs 0000:00:07.0: tulip_stop_rxtx() failed
Dec 31 16:01:56 lfs 0000:00:07.0: tulip_stop_rxtx() failed
Dec 31 16:02:02 lfs 0000:00:07.0: tulip_stop_rxtx() failed
Dec 31 16:02:08 lfs 0000:00:07.0: tulip_stop_rxtx() failed

Under 32 bit
Dec 31 16:01:16 lfs Linux Tulip driver version 1.1.13 (May 11, 2002)
Dec 31 16:01:16 lfs PCI: Enabling device 0000:00:07.0 (0045 -> 0047)
Dec 31 16:01:16 lfs tulip0: Old format EEPROM on 'Cobalt Microserver' 
board.  Using substitute media control info.
Dec 31 16:01:16 lfs tulip0:  EEPROM default media type Autosense.
Dec 31 16:01:16 lfs tulip0:  Index #0 - Media MII (#11) described by a 
21142 MII PHY (3) block.
Dec 31 16:01:16 lfs tulip0:  MII transceiver #1 config 1000 status 7809 
advertising 01e1.
Dec 31 16:01:16 lfs eth0: Digital DS21143 Tulip rev 65 at b0001400, 
00:10:E0:00:32:DE, IRQ 19.
Dec 31 16:01:16 lfs tulip1: Old format EEPROM on 'Cobalt Microserver' 
board.  Using substitute media control info.
Dec 31 16:01:16 lfs tulip1:  EEPROM default media type Autosense.
Dec 31 16:01:16 lfs tulip1:  Index #0 - Media MII (#11) described by a 
21142 MII PHY (3) block.
Dec 31 16:01:16 lfs tulip1:  MII transceiver #1 config 1000 status 7809 
advertising 01e1.
Dec 31 16:01:16 lfs eth1: Digital DS21143 Tulip rev 65 at b0001480, 
00:10:E0:00:32:DF, IRQ 20.
Dec 31 16:01:17 lfs bootlog:  Bringing up the eth0 interface...[  OK  ]
Dec 31 16:01:17 lfs bootlog:  Adding IPv4 address 172.16.0.99 to the 
eth0 interface...[  OK  ]
Dec 31 16:01:18 lfs bootlog:  Setting up default gateway...[  OK  ]
Dec 31 16:01:20 lfs eth0: Setting full-duplex based on MII#1 link 
partner capability of 45e1.

-- 
----
Jim Gifford
maillist@jg555.com

