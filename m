Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310637AbSCXRV5>; Sun, 24 Mar 2002 12:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311314AbSCXRVr>; Sun, 24 Mar 2002 12:21:47 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:10504 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S310606AbSCXRVk> convert rfc822-to-8bit; Sun, 24 Mar 2002 12:21:40 -0500
Content-Type: text/plain; charset=US-ASCII
From: Christian Asam <Christian.Asam@chasam.de>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with serial.c introduced in 2.4.15
Date: Sun, 24 Mar 2002 18:21:38 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16pBgZ-0000v2-00@mrvdom00.kundenserver.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After having found out that a too old kernel caused my problem with 
writing to slow devices I had the problem that my serial digitizer 
(Genius using gpm/genitizer) didn't work with 2.4.18. I tracked it down 
to a change made in 1.4.15:
drivers/char/serial.c:
#if 0   /*
         * !!! ignore all characters if CREAD is not set
         */
        if ((cflag & CREAD) == 0)
                info->ignore_status_mask |= UART_LSR_DR;
#endif

In 2.4.15 the #if 0 and #endif was removed and somehow that manages to 
break gpm/genitizer. I then added the #if 0/#endif to "remove" that 
statement in 2.4.18 and the tablet works with 2.4.18 too.

cu
