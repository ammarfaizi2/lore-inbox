Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261920AbREMVYW>; Sun, 13 May 2001 17:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261919AbREMVYC>; Sun, 13 May 2001 17:24:02 -0400
Received: from fe170.worldonline.dk ([212.54.64.199]:64778 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S261918AbREMVXw>; Sun, 13 May 2001 17:23:52 -0400
Message-ID: <3AFEFD06.9010500@eisenstein.dk>
Date: Sun, 13 May 2001 23:30:46 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4-ac8 i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en, da
MIME-Version: 1.0
To: linux-serial@vger.kernel.org
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] missing return value from pci_xircom_fn() in drivers/char/serial.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm using the 2.4.4-ac8 kernel and found that the pci_xircom_fn() 
function in drivers/char/serial.c does not return a value even though it 
is defined as returning int. I took a look at the other initializer 
functions and they all return 0 (zero) on success, so I assumed that the 
correct return value for the pci_xircom_fn() function would also be 0. I 
don't know anything specific about what goes on in serial.c, so I may be 
wrong on this, but I do know that the function should either return some 
value or be declared as returning void, and since declaring it void 
would mess up the way it is used I guess it should return a value.

I have made a patch against 2.4.4-ac8 that makes the change, it is 
below. I guess someone more knowledgeable than me can probably see if 
this is correct. If this is completely bogus, then please just disregard 
this email.


--- linux-2.4.4-ac8/drivers/char/serial.c.orig  Sun May 13 23:13:02 2001
+++ linux-2.4.4-ac8/drivers/char/serial.c       Sun May 13 23:13:24 2001
@@ -4190,6 +4190,7 @@
  {
         __set_current_state(TASK_UNINTERRUPTIBLE);
         schedule_timeout(HZ/10);
+       return(0);
  }

  /*


Best regards,
Jesper Juhl - juhl@eisenstein.dk

