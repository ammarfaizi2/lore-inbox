Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbUEGAgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbUEGAgd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 20:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUEGAgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 20:36:32 -0400
Received: from www.amthinking.net ([65.104.119.37]:34358 "EHLO
	ex0.amthinking.net") by vger.kernel.org with ESMTP id S261817AbUEGAg3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 20:36:29 -0400
Message-ID: <409AD9F8.5080400@appliedminds.com>
Date: Thu, 06 May 2004 17:36:08 -0700
From: James Lamanna <jamesl@appliedminds.com>
User-Agent: Mozilla Thunderbird 0.6+ (X11/20040421)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Getting i815 Framebuffer working?!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 May 2004 00:36:28.0701 (UTC) FILETIME=[55F984D0:01C433CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some more info I just dug out.
The following call chain fails:

i810fb_init_pci()
   i810fb_check_var()
     i810_check_params()
       fb_get_mode()

fb_get_mode returns -EINVAL from the if statement at line 1079:
if (!(flags & FB_IGNOREMON) &&
      (timings.vfreq < vfmin || timings.vfreq > vfmax ||
       timings.hfreq < hfmin || timings.hfreq > hfmax ||
       timings.dclk < dclkmin || timings.dclk > dclkmax))

values:
flags: 0x00000000
timings.vfreq 38 vfmin 60 vfmax 60
timings.hfreq 30000 hfmin 30000 hfmax 30000
timings.dclk 38400000 dclkmin 15000000 dclkmax 234000000


-------- Original Message --------
Subject: Getting i815 Framebuffer working?!
Date: Thu, 06 May 2004 16:57:22 -0700
From: James Lamanna <jamesl@appliedminds.com>
To: linux-kernel@vger.kernel.org
CC: adaplas@pol.net

Using stock 2.6.5, I'm trying to get the Intel i810/5 framebuffer driver
to work. So far I have had no success.


-- James Lamanna

