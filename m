Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131481AbRDSRbJ>; Thu, 19 Apr 2001 13:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131508AbRDSRbC>; Thu, 19 Apr 2001 13:31:02 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:28169 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131481AbRDSRao>; Thu, 19 Apr 2001 13:30:44 -0400
Message-ID: <3ADF20F4.2FBBE8DF@t-online.de>
Date: Thu, 19 Apr 2001 19:31:32 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Roskin <proski@gnu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: PNP BIOS and parport_pc - dma found but not used
In-Reply-To: <Pine.LNX.4.33.0104190203320.10275-100000@portland>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin wrote:
> 
> Hello!
> 
> I've compiled 2.4.3-ac9 with support for PNP BIOS. I understand that this
> is a new feature experimental and the feedback is requested.
> 
> The setting is BIOS is to use irq 7 and dma 3. I normally use "options
> parport_pc io=0x378 irq=7 dma=3" in /etc/modules.conf, but this time I
> commented them out hoping that the driver will ask BIOS.
> 
> Although the kernel can see those settings, the dma is not used by the
> driver. This is the output from dmesg.
> 
> PnPBIOS: Parport found PNPBIOS PNP0401 at io=0378,0778 irq=7 dma=-1
                                                               ^^^^^^ culprit !

Send me the raw PNP resource data so I can look into this:

1) Search for the right two-digit PNP handle for device "0104d041":
   cat /proc/bus/pnb/devices
   01      0104d041        07:01:00        0080
   02      0105d041        07:00:02        0180
   03      1005d041        07:00:02        0180
   04      0007d041        01:02:00        0003
   ...

   The number in the first column (here: 01) is the handle
   to be used in step 2.

2) Send cat /proc/bus/pnp/01 | od -tx1
