Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288280AbSAQH7X>; Thu, 17 Jan 2002 02:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288283AbSAQH7O>; Thu, 17 Jan 2002 02:59:14 -0500
Received: from boden.synopsys.com ([204.176.20.19]:52910 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S288280AbSAQH7J>; Thu, 17 Jan 2002 02:59:09 -0500
Date: Thu, 17 Jan 2002 08:55:57 +0100
From: Alex Riesen <riesen@synopsys.COM>
To: linux-kernel@vger.kernel.org
Subject: 2.5.2: swapon failing with errno=0 (sys_swapon)
Message-ID: <20020117085557.A12927@riesen-pc.gr05.synopsys.com>
Reply-To: riesen@synopsys.COM
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

