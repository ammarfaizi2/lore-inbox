Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266839AbTBGXKw>; Fri, 7 Feb 2003 18:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266840AbTBGXKw>; Fri, 7 Feb 2003 18:10:52 -0500
Received: from air-2.osdl.org ([65.172.181.6]:36841 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266839AbTBGXKv>;
	Fri, 7 Feb 2003 18:10:51 -0500
Date: Fri, 7 Feb 2003 15:18:25 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: <p_gortmaker@yahoo.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][Trvial 2.5.59] rtc.c is requesting more ioports then it
 really uses
In-Reply-To: <1044657656.1132.19.camel@vmhack>
Message-ID: <Pine.LNX.4.33L2.0302071512350.13440-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Feb 2003, Rusty Lynch wrote:

| I need to enable a device that talks to port 0x79h, but for some
| reason the rtc is requesting move bytes then it really uses.  Here
| is a patch that makes the rtc only request what it uses.
|
|     --rustyl
|
| --- drivers/char/rtc.c.orig	2003-02-07 14:35:31.000000000 -0800
| +++ drivers/char/rtc.c	2003-02-07 13:25:45.000000000 -0800
| @@ -47,7 +47,7 @@
|
|  #define RTC_VERSION		"1.11"
|
| -#define RTC_IO_EXTENT	0x10	/* Only really two ports, but...	*/
| +#define RTC_IO_EXTENT	0x2
|
|  /*
|   *	Note that *all* calls to CMOS_READ and CMOS_WRITE are done with
| -

Some Intel chipset specs list RTC as using 0x70 - 0x77, probably with
some aliasing in there, so it looks to me like an EXTENT of 8 would be
safer and still allow you access to 0x79.

I'm looking at 82801BA-ICH2, 82801-ICH3, and 82801AA-ICH0 specs.

-- 
~Randy

