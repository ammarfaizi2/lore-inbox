Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751927AbWCRF4G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbWCRF4G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 00:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWCRF4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 00:56:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57560 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751908AbWCRF4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 00:56:04 -0500
Date: Fri, 17 Mar 2006 21:53:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/14] RTC: Remove some duplicate BCD definitions
Message-Id: <20060317215313.6df007f9.akpm@osdl.org>
In-Reply-To: <15.132654658@selenic.com>
References: <2.132654658@selenic.com>
	<15.132654658@selenic.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> Remove some duplicate BCD definitions

Needed fixups in arch/m68k/bvme6000/rtc.c due to overlapping changes in
m68k-rtc-driver-cleanup.patch.  Please check the result.

***************
*** 18,23 ****
  #include <linux/module.h>
  #include <linux/mc146818rtc.h>	/* For struct rtc_time and ioctls, etc */
  #include <linux/smp_lock.h>
  #include <asm/bvme6000hw.h>
  
  #include <asm/io.h>
--- 18,24 ----
  #include <linux/module.h>
  #include <linux/mc146818rtc.h>	/* For struct rtc_time and ioctls, etc */
  #include <linux/smp_lock.h>
+ #include <linux/bcd.h>
  #include <asm/bvme6000hw.h>
  
  #include <asm/io.h>
***************
*** 32,40 ****
   *	ioctls.
   */
  
- #define BCD2BIN(val) (((val)&15) + ((val)>>4)*10)
- #define BIN2BCD(val) ((((val)/10)<<4) + (val)%10)
- 
  static unsigned char days_in_mo[] =
  {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
  
--- 33,38 ----
   *	ioctls.
   */
  
  static unsigned char days_in_mo[] =
  {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
  

