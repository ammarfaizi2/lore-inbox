Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310540AbSCXQ5f>; Sun, 24 Mar 2002 11:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310549AbSCXQ5Z>; Sun, 24 Mar 2002 11:57:25 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:16688 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S310540AbSCXQ5L> convert rfc822-to-8bit; Sun, 24 Mar 2002 11:57:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Christian Asam <Christian.Asam@chasam.de>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with serial.c introduced in 2.4.15
Date: Sun, 24 Mar 2002 17:57:08 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16pBIs-00024N-00@mrvdom03.kundenserver.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After having found that my VM-Problem (USB/MOD) was due to an old 
kernel I upgraded to 2.4.18 and found that I couldn't use my digitizer 
board (Genius) with gpm(genitizer) anymoure.
I tracked it down to a change made from 2.4.14 to 2.4.15:

drivers/char/serial.c:
#if 0   /*
         * !!! ignore all characters if CREAD is not set
         */
        if ((cflag & CREAD) == 0)
                info->ignore_status_mask |= UART_LSR_DR;
#endif

The #if 0 and #endif was removed in 2.4.15 and somehow that breaks 
gpm/genitizer. Having added the "commenting out through $if 0" the 
tablet works fine again and deactivating the appropriate line in 2.4.18 
also works.

cu
