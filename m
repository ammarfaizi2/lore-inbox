Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVGaJEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVGaJEW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 05:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVGaJEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 05:04:22 -0400
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:30222 "EHLO
	roarinelk.homelinux.net") by vger.kernel.org with ESMTP
	id S261574AbVGaJEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 05:04:20 -0400
Message-ID: <42EC9410.8080107@roarinelk.homelinux.net>
Date: Sun, 31 Jul 2005 11:04:16 +0200
From: Manuel Lauss <mano@roarinelk.homelinux.net>
User-Agent: Thunderbird/1.0 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
References: <20050728025840.0596b9cb.akpm@osdl.org>
In-Reply-To: <20050728025840.0596b9cb.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

something broke the sonypi driver a bit after -mm2:
I can no longer set bluetooth-power for instance, and it logs these
messages:

sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 605)
sonypi command failed at drivers/char/sonypi.c : sonypi_call2 (line 607)
sonypi command failed at drivers/char/sonypi.c : sonypi_call1 (line 594)

setting/getting brightness, getting battery/ac status still work.


The ioports assignments have changed a bit between -mm2 and -mm3:

/proc/ioports on -mm2:
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03f6-03f6 : ide0
0400-047f : 0000:00:1f.0
   0400-0403 : PM1a_EVT_BLK
   0404-0405 : PM1a_CNT_BLK
   0408-040b : PM_TMR
   0410-0415 : ACPI CPU throttle
   0420-0420 : PM2_CNT_BLK
   0428-042f : GPE0_BLK
0500-053f : 0000:00:1f.0
   0500-053f : pnp 00:08
0540-055f : 0000:00:1f.3
   0540-054f : i801-smbus
0cf8-0cff : PCI conf1
1080-109f : Sony Programable I/O Device
c000-cfff : PCI Bus #01
   c800-c8ff : 0000:01:00.0
     c800-c8ff : radeonfb
d000-dfff : PCI Bus #02
   d000-d1ff : PCI CardBus #03
   d400-d5ff : PCI CardBus #03
   dc00-dc3f : 0000:02:03.0
     dc00-dc3f : e1000
e000-e03f : 0000:00:1f.5
   e000-e03f : Intel 82801DB-ICH4
e080-e0ff : 0000:00:1f.6
e400-e4ff : 0000:00:1f.6
e800-e81f : 0000:00:1d.0
   e800-e81f : uhci_hcd
e880-e89f : 0000:00:1d.1
   e880-e89f : uhci_hcd
ec00-ec1f : 0000:00:1d.2
   ec00-ec1f : uhci_hcd
ee00-eeff : 0000:00:1f.5
   ee00-eeff : Intel 82801DB-ICH4
fe00-fe01 : motherboard
ffa0-ffaf : 0000:00:1f.1
   ffa0-ffa7 : ide0
   ffa8-ffaf : ide1


/proc/ioports on -mm3:
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03f6-03f6 : ide0
0400-047f : 0000:00:1f.0
   0400-0403 : PM1a_EVT_BLK
   0404-0405 : PM1a_CNT_BLK
   0408-040b : PM_TMR
   0410-0415 : ACPI CPU throttle
   0420-0420 : PM2_CNT_BLK
   0428-042f : GPE0_BLK
0500-053f : 0000:00:1f.0
   0500-053f : pnp 00:08
0540-055f : 0000:00:1f.3
   0540-054f : i801-smbus
0cf8-0cff : PCI conf1
1000-1fff : PCI CardBus #03
   1080-109f : Sony Programable I/O Device
2000-2fff : PCI CardBus #03
c000-cfff : PCI Bus #01
   c800-c8ff : 0000:01:00.0
     c800-c8ff : radeonfb
d000-dfff : PCI Bus #02
   dc00-dc3f : 0000:02:03.0
     dc00-dc3f : e1000
e000-e03f : 0000:00:1f.5
   e000-e03f : Intel 82801DB-ICH4
e080-e0ff : 0000:00:1f.6
e400-e4ff : 0000:00:1f.6
e800-e81f : 0000:00:1d.0
   e800-e81f : uhci_hcd
e880-e89f : 0000:00:1d.1
   e880-e89f : uhci_hcd
ec00-ec1f : 0000:00:1d.2
   ec00-ec1f : uhci_hcd
ee00-eeff : 0000:00:1f.5
   ee00-eeff : Intel 82801DB-ICH4
fe00-fe01 : motherboard
ffa0-ffaf : 0000:00:1f.1
   ffa0-ffa7 : ide0
   ffa8-ffaf : ide1


I'd appreciate any hints

Thanks,

-- 
  Manuel Lauss
