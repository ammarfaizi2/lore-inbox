Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129853AbRBIUIs>; Fri, 9 Feb 2001 15:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130533AbRBIUI3>; Fri, 9 Feb 2001 15:08:29 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:2052 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S129853AbRBIUIY>;
	Fri, 9 Feb 2001 15:08:24 -0500
Date: Fri, 9 Feb 2001 21:08:06 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Dimitromanolakis Apostolos <apdim@ovelix.softnet.tuc.gr>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/media/radio/radio-maxiradio.c - 2.4.1-ac8
Message-ID: <20010209210806.A1001@se1.cogenit.fr>
In-Reply-To: <20010206224451.A24412@ensta.fr> <Pine.LNX.4.10.10102072245460.17074-300000@kythira.softlab.tuc.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.4.10.10102072245460.17074-300000@kythira.softlab.tuc.gr>
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitromanolakis Apostolos <apdim@ovelix.softnet.tuc.gr> écrit :
[...]
> Your patch had some problem in the maxiradio_radio_init function as
> pci_register_driver returns the number of devices found and not 0 when
> succesful. I fixed it and here is my patch against the original driver.

Patch-o-the-month candidate follows:

--- linux-2.4.1-ac8.orig/drivers/media/radio/radio-maxiradio.c	Fri Feb  9 15:55:03 2001
+++ linux-2.4.1-ac8/drivers/media/radio/radio-maxiradio.c	Fri Feb  9 15:56:55 2001
@@ -376,9 +376,7 @@
 
 int __init maxiradio_radio_init(void)
 {
-	int count = pci_register_driver(&maxiradio_driver);
-	
-	if(count > 0) return 0; else return -ENODEV;
+	return pci_module_init(&maxiradio_driver);
 }
 
 void __exit maxiradio_radio_exit(void)

-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
