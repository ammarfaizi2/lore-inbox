Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131192AbQLKAaI>; Sun, 10 Dec 2000 19:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132277AbQLKA36>; Sun, 10 Dec 2000 19:29:58 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:46137 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S131192AbQLKA3r>;
	Sun, 10 Dec 2000 19:29:47 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
cc: Alan.Cox@linux.org, linux-kernel@vger.kernel.org, davem@redhat.com,
        rusty@linuxcare.com
Subject: Re: Checking for incorrect MODULE_PARM 
In-Reply-To: Your message of "Sun, 10 Dec 2000 13:38:56 -0300."
             <200012101638.eBAGcuJ16062@sleipnir.valparaiso.cl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Dec 2000 10:58:24 +1100
Message-ID: <1311.976492704@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2000 13:38:56 -0300, 
Horst von Brand <vonbrand@sleipnir.valparaiso.cl> wrote:
>With 2.2.18pre27 on i686 I get:
>
> /lib/modules/2.2.18/ipv4/ip_masq_user.o
>warning: symbol for parameter ports not found
>ports int array (min = 1, max = 12)
>debug int

ports is not used in ip_masq_user, dead code.  Trivial patch.

Index: 18-pre27.1/net/ipv4/ip_masq_user.c
--- 18-pre27.1/net/ipv4/ip_masq_user.c Sun, 01 Oct 2000 19:35:12 +1100 kaos (linux-2.2/e/11_ip_masq_us 1.2.3.1.1.2 644)
+++ 18-pre27.1(w)/net/ipv4/ip_masq_user.c Mon, 11 Dec 2000 10:55:38 +1100 kaos (linux-2.2/e/11_ip_masq_us 1.2.3.1.1.2 644)
@@ -35,7 +35,6 @@
  */
 static int debug=0;
 
-MODULE_PARM(ports, "1-" __MODULE_STRING(MAX_MASQ_APP_PORTS) "i");
 MODULE_PARM(debug, "i");
 
 /*

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
