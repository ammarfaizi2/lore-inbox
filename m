Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263673AbSJGWgD>; Mon, 7 Oct 2002 18:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263674AbSJGWgD>; Mon, 7 Oct 2002 18:36:03 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:28612 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S263673AbSJGWgC>; Mon, 7 Oct 2002 18:36:02 -0400
Message-Id: <5.1.0.14.2.20021007152433.08fac980@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 07 Oct 2002 15:40:40 -0700
To: Marcel Holtmann <marcel@holtmann.org>, torvalds@transmeta.com
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: [PATCH] Make it possible to compile in the Bluetooth
  subsystem
Cc: linux-kernel@vger.kernel.org, marcel@holtmann.org
In-Reply-To: <E17yelj-0005CD-00@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel,

>@@ -345,7 +345,7 @@
>         return 0;
>  }
>
>-static void __exit bluez_cleanup(void)
>+void __exit bluez_cleanup(void)
>  {
>         hci_sock_cleanup();
>         hci_core_cleanup();
>@@ -356,11 +356,9 @@
>         remove_proc_entry("bluetooth", NULL);
>  }
>
>-#ifdef MODULE
>  module_init(bluez_init);
>  module_exit(bluez_cleanup);
>
>  MODULE_AUTHOR("Maxim Krasnyansky <maxk@qualcomm.com>");
>  MODULE_DESCRIPTION("BlueZ Core ver " VERSION);
>  MODULE_LICENSE("GPL");
>-#endif
This is wrong. If Bluetooth is compiled in, bluez_init() is called from
linux/net/socket.c. We have to change that to subsys_initcall.

Linus, please don't apply. We'll send correct patch later.

Thanks
Max





