Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292284AbSCDJJM>; Mon, 4 Mar 2002 04:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292289AbSCDJJC>; Mon, 4 Mar 2002 04:09:02 -0500
Received: from fairchild-196.adsl.newnet.co.uk ([213.131.187.196]:22502 "HELO
	pinus") by vger.kernel.org with SMTP id <S292284AbSCDJIt>;
	Mon, 4 Mar 2002 04:08:49 -0500
Date: Mon, 4 Mar 2002 08:59:26 +0000 (GMT)
From: Steve Hill <steve@navaho.co.uk>
X-X-Sender: <steve@sorbus.navaho>
To: Tim Hockin <thockin@hockin.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] ALi M7101 watchdog
In-Reply-To: <200203011741.g21Hf4b30628@www.hockin.org>
Message-ID: <Pine.LNX.4.33.0203040851550.12437-100000@sorbus.navaho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2002, Tim Hockin wrote:

> The WDT in the 7101 is almost USELESS from user-space.  It has a MAXIMUM 1
> second timeout, and is tied straight to RESET.  If you miss ONE feeding,
> you reboot.  In our kernel we have a 1/4 second timer to feed the watchdog,

If you look at the code you will see that I am refreshing the watchdog as 
1/4 second intervals - the userspace watchdog is handled in software so 
that if it does not get a heartbeat every 30 seconds then the driver stops 
sending the automated 1/4 second heartbeats to the hardware.

We've been using a similar (very hacked about) watchdog for about a year 
without any problems but I have only just gotten around to neatening it 
up.

> random reboots.  If I was allowed to, I would have used the WDT for reboot
> ONLY, and had it off otherwise - it is WAAAAY finicky.

Under this patch, if you don't open /dev/watchdog then the watchdog is 
only ever activated for reboots.

-- 

- Steve Hill
System Administrator         Email: steve@navaho.co.uk
Navaho Technologies Ltd.       Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...



