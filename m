Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290074AbSAQRPE>; Thu, 17 Jan 2002 12:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290075AbSAQROz>; Thu, 17 Jan 2002 12:14:55 -0500
Received: from boden.synopsys.com ([204.176.20.19]:58327 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S290074AbSAQROo>; Thu, 17 Jan 2002 12:14:44 -0500
Date: Thu, 17 Jan 2002 18:14:34 +0100
From: Alex Riesen <riesen@synopsys.COM>
To: linux-kernel@vger.kernel.org
Subject: 2.5.2: swapon failing with errno=0 (sys_swapon) (repost)
Message-ID: <20020117181434.A13576@riesen-pc.gr05.synopsys.com>
Reply-To: riesen@synopsys.COM
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not cc'ing someone personally (because i don't know
whom to address), so i just repost the patch, in case
noone have seen it. The thing really disabled swap,
although maybe noone is really need it for 2.5.2 ;)

repost:
Tried to use 2.5.2. And got the message from swapon:
swapon: /dev/hda6: Success

strace showed some strange return value from swapon(2),
looking like a pointer.

The patch will cure the problem, though i'm not sure
about the reasons setting the error to pointer.
Are the kernel pointers handled specially in errors?
-alex

--- linux/mm/swapfile.c Mon Jan 14 18:38:36 2002
+++ linux/mm/swapfile.c-        Thu Jan 17 08:50:28 2002
@@ -904,7 +904,7 @@
        swap_file = filp_open(name, O_RDWR, 0);
        putname(name);
        error = PTR_ERR(swap_file);
-       if (error)
+       if (IS_ERR(swap_file))
                goto bad_swap_2;
 
        p->swap_file = swap_file;

