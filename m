Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262816AbVCDAbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbVCDAbb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbVCDA1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:27:42 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:35968 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262724AbVCDAZm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:25:42 -0500
Date: Thu, 3 Mar 2005 16:25:39 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [UPDATE PATCH] cdrom/mcdx: fix wait-queue compile-time breakage
Message-ID: <20050304002539.GE16078@us.ibm.com>
References: <20050302095710.GA3745@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302095710.GA3745@nd47.coderock.org>
X-Operating-System: Linux 2.6.11-rc4 (i686)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 10:57:10AM +0100, Domen Puncer wrote:
> A new release from kernel janitors (http://janitor.kernelnewbies.org/).
> 
> Apologies to janitors that this took so long.
> This time we have a new record: 354 patches!
> I'll start sending/resending what's not already in -mm soon.
> 
> Patchset is at http://coderock.org/kj/2.6.11-kj/

<snip>

> int_sleep_on-drivers_cdrom_mcdx.patch
>   From: Nishanth Aravamudan <nacc@us.ibm.com>
>   Subject: [KJ] [PATCH 16/20] cdrom/mcdx: remove 	interruptible_sleep_on_timeout() usage

Description: The original patch leads to compile-warnings from older
version of GCC and violates CodingStyle. Moving the declaration to the
head of the function fixes it.

--- 2.6.11-kj-v/drivers/cdrom/mcdx.c	2005-03-02 11:21:41.000000000 -0800
+++ 2.6.11-kj/drivers/cdrom/mcdx.c	2005-03-03 10:30:32.000000000 -0800
@@ -838,10 +838,10 @@ static void mcdx_delay(struct s_drive_st
  *	May be we could use a simple count loop w/ jumps to itself, but
  *	I wanna make this independent of cpu speed. [1 jiffy is 1/HZ] sec */
 {
+	DEFINE_WAIT(wait);
 	if (jifs < 0)
 		return;
 
-	DEFINE_WAIT(wait);
 	xtrace(SLEEP, "*** delay: sleepq\n");
 	prepare_to_wait(&stuff->sleepq, &wait, TASK_INTERRUPTIBLE);
 	schedule_timeout(jifs);
