Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267178AbTBIIhh>; Sun, 9 Feb 2003 03:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267131AbTBIIhh>; Sun, 9 Feb 2003 03:37:37 -0500
Received: from web11106.mail.yahoo.com ([216.136.131.153]:8593 "HELO
	web11106.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267178AbTBIIhg>; Sun, 9 Feb 2003 03:37:36 -0500
Message-ID: <20030209084718.74815.qmail@web11106.mail.yahoo.com>
Date: Sun, 9 Feb 2003 00:47:18 -0800 (PST)
From: Paul Gortmaker <p_gortmaker@yahoo.com>
Subject: Re: [PATCH][Trvial 2.5.59] rtc.c is requesting more ioports then it really uses
To: "Randy.Dunlap" <rddunlap@osdl.org>, Rusty Lynch <rusty@linux.co.intel.com>
Cc: p_gortmaker@yahoo.com, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0302071512350.13440-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems fine with me.  If memory serves correctly the 0x10 came
from kernels prior to the rtc driver where the range was 
requested as part of the generic i386 specific i/o space that
was off limits.

Paul.

--- "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> On 7 Feb 2003, Rusty Lynch wrote:
> 
> | I need to enable a device that talks to port 0x79h, but for some
> | reason the rtc is requesting move bytes then it really uses.  Here
> | is a patch that makes the rtc only request what it uses.
> |
> |     --rustyl
> |
> | --- drivers/char/rtc.c.orig	2003-02-07 14:35:31.000000000 -0800
> | +++ drivers/char/rtc.c	2003-02-07 13:25:45.000000000 -0800
> | @@ -47,7 +47,7 @@
> |
> |  #define RTC_VERSION		"1.11"
> |
> | -#define RTC_IO_EXTENT	0x10	/* Only really two ports, but...	*/
> | +#define RTC_IO_EXTENT	0x2
> |
> |  /*
> |   *	Note that *all* calls to CMOS_READ and CMOS_WRITE are done with
> | -
> 
> Some Intel chipset specs list RTC as using 0x70 - 0x77, probably with
> some aliasing in there, so it looks to me like an EXTENT of 8 would be
> safer and still allow you access to 0x79.
> 
> I'm looking at 82801BA-ICH2, 82801-ICH3, and 82801AA-ICH0 specs.
> 
> -- 
> ~Randy
> 


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
