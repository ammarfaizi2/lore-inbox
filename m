Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273455AbRIUMCP>; Fri, 21 Sep 2001 08:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273463AbRIUMCF>; Fri, 21 Sep 2001 08:02:05 -0400
Received: from mailg.telia.com ([194.22.194.26]:8660 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S273455AbRIUMBw>;
	Fri, 21 Sep 2001 08:01:52 -0400
Date: Fri, 21 Sep 2001 14:06:13 +0200
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: via82cxxx_audio locking problems
Message-ID: <20010921140613.A7758@telia.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3BA9AB43.C26366BF@scs.ch> <01092004333500.00182@c779218-a> <3BA9DBED.9020401@humboldt.co.uk> <01092005243800.01369@c779218-a> <20010920154049.A4282@telia.com> <3BAB080A.56DC7775@scs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3BAB080A.56DC7775@scs.ch>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Sailer <sailer@scs.ch> wrote:

> This is the patch I've tested yesterday. It worked so far.

This seams to be against version 1.15 of the VIA driver. -pre13 only seams
to have 1.14 so I got rejects when I tried to apply it:

Hunk #1 FAILED at 12.
Hunk #2 succeeded at 458 (offset -8 lines).
Hunk #3 succeeded at 1973 (offset -15 lines).
Hunk #4 succeeded at 2005 (offset -15 lines).
Hunk #5 succeeded at 2046 (offset -15 lines).
Hunk #6 succeeded at 2098 (offset -15 lines).
Hunk #7 succeeded at 2149 (offset -15 lines).
Hunk #8 succeeded at 2179 (offset -15 lines).
Hunk #9 succeeded at 2219 (offset -15 lines).
Hunk #10 succeeded at 2384 (offset -15 lines).
Hunk #11 succeeded at 2397 (offset -15 lines).
Hunk #12 succeeded at 2435 (offset -15 lines).
Hunk #13 succeeded at 2481 (offset -15 lines).
1 out of 13 hunks FAILED -- saving rejects to file via82cxxx_audio.c.rej

The rejects are these harmless ones:

***************
*** 12,21 ****
   * the driver's Website at
   * http://gtf.org/garzik/drivers/via82cxxx/
   *
   */
  
  
- #define VIA_VERSION	"1.1.15"
  
  
  #include <linux/config.h>
--- 12,28 ----
   * the driver's Website at
   * http://gtf.org/garzik/drivers/via82cxxx/
   *
+  * Thomas Sailer, 2001-09-20:
+  *   - unlock syscall_sem during sleeping in read/write
+  *   - return byte count in case of partial transfer instead of
+  *     error in read/write syscalls
+  *   - avoid loosing wake_up event
+  *   - nonblocking semaphore down disabled
+  *
   */
  
  
+ #define VIA_VERSION	"1.1.15tsa"
  
  
  #include <linux/config.h>
-- 

André Dahlqvist <andre.dahlqvist@telia.com>
