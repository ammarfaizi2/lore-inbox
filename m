Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135246AbRARMSX>; Thu, 18 Jan 2001 07:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135255AbRARMSN>; Thu, 18 Jan 2001 07:18:13 -0500
Received: from saw.sw.com.sg ([203.120.9.98]:8068 "HELO saw.sw.com.sg")
	by vger.kernel.org with SMTP id <S135246AbRARMR5>;
	Thu, 18 Jan 2001 07:17:57 -0500
Message-ID: <20010118201731.A8492@saw.sw.com.sg>
Date: Thu, 18 Jan 2001 20:17:31 +0800
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: huggie@earth.li
Cc: eepro100@scyld.com, linux-kernel@vger.kernel.org
Subject: Re: eepro cmd_wait
In-Reply-To: <20010118131011.B19784@the.earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <20010118131011.B19784@the.earth.li>; from "Simon Huggins" on Thu, Jan 18, 2001 at 01:10:11PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 18, 2001 at 01:10:11PM +0100, Simon Huggins wrote:
> We have a server running 2.2.18 + RAID which has an eepro100 in it.
> It's connected to a Dlink DFE 816 100 16port 100baseTX hub.
> 
> When the machine boots we get a whole series of timeout errors.
> 
> Jan 18 11:58:09 miguet kernel: eepro100: cmd_wait for(0x70) timedout with(0x70)!
> Jan 18 11:58:09 miguet kernel: eepro100: cmd_wait for(0x10) timedout with(0x10)!
> Jan 18 11:58:09 miguet kernel: eepro100: cmd_wait for(0xffffff90) timedout with(0xffffff90)!
> Jan 18 11:58:38 miguet last message repeated 38 times
> Jan 18 11:58:50 miguet last message repeated 12 times

Could you try to add
	inl(ioaddr + SCBPointer);
	udelay(10);
before
	outb(RxAddrLoad, ioaddr + SCBCmd);
in speedo_resume()?

These two line are a workaround for the RxAddrLoad timing bug, developed by
Donald Becker.  wait_for_cmd_done timeouts may be related to this bug, too.

Best regards
					Andrey V.
					Savochkin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
