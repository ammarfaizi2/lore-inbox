Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVCLTOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVCLTOH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 14:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbVCLTOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 14:14:06 -0500
Received: from zork.zork.net ([64.81.246.102]:15586 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S262013AbVCLTNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 14:13:50 -0500
From: Sean Neakums <sneakums@zork.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org
Subject: DRI breakage, 2.6.11-mm[123]
References: <20050312034222.12a264c4.akpm@osdl.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, Dave Airlie
	<airlied@gmail.com>, linux-kernel@vger.kernel.org
Date: Sat, 12 Mar 2005 19:13:43 +0000
In-Reply-To: <20050312034222.12a264c4.akpm@osdl.org> (Andrew Morton's message
	of "Sat, 12 Mar 2005 03:42:22 -0800")
Message-ID: <6uzmx87k48.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following happens with 2.6.11-mm[123].  (I didn't have time to
investigate earlier; sorry.)  It does not happen with 2.6.11-rc3-mm2
and 2.6.11.  I have tested 2.6.11-mm3 with dri disabled (by not
loading X's dri module) and it also does not happen then.

When I start X, I get a screen full of what looks like random pixels.
Apart from the pointer, X seems generally non-functional.  The X
server (Debian's 4.3.0.dfsg.1-1) is spinning doing the following,
apparently indefinitely (fd 5 is /dev/dri/card0):

  ioctl(5, 0x6444, 0)                     = -1 EBUSY (Device or resource busy)
  ioctl(5, 0x6444, 0)                     = -1 EBUSY (Device or resource busy)
  --- SIGALRM (Alarm clock) @ 0 (0) ---
  sigreturn()                             = ? (mask now [])
  ioctl(5, 0x6444, 0)                     = -1 EBUSY (Device or resource busy)
  --- SIGALRM (Alarm clock) @ 0 (0) ---
  sigreturn()                             = ? (mask now [])
  ioctl(5, 0x6444, 0)                     = -1 EBUSY (Device or resource busy)
  ioctl(5, 0x6444, 0)                     = -1 EBUSY (Device or resource busy)
  --- SIGALRM (Alarm clock) @ 0 (0) ---
  sigreturn()                             = ? (mask now [])
  ioctl(5, 0x6444, 0)                     = -1 EBUSY (Device or resource busy)


Kernel configuration at http://flynn.zork.net/~sneakums/config-2.6.11-mm3

-- 
Dag vijandelijk luchtschip de huismeester is dood
