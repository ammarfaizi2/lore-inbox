Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131079AbQLIUUN>; Sat, 9 Dec 2000 15:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131429AbQLIUUD>; Sat, 9 Dec 2000 15:20:03 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:11763 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S131079AbQLIUTu>; Sat, 9 Dec 2000 15:19:50 -0500
Date: Sat, 9 Dec 2000 17:49:18 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Yaroslav Polyakov <xenon@granch.ru>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net/sbni.c irq release on failure
Message-ID: <20001209174918.G859@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Yaroslav Polyakov <xenon@granch.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <20001209151425.E859@conectiva.com.br> <20001209174018.F859@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001209174018.F859@conectiva.com.br>; from acme@conectiva.com.br on Sat, Dec 09, 2000 at 05:40:19PM -0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan/Yaroslav,

	Please consider applying, a similar patch is already in 2.4.

- Arnaldo

--- linux-2.2.18-pre25/drivers/net/sbni.c	Sat Dec  9 15:08:17 2000
+++ linux-2.2.18-pre25.acme/drivers/net/sbni.c	Sat Dec  9 17:44:53 2000
@@ -456,6 +456,7 @@
 	if(dev->priv == NULL)
 	{
 		DP( printk("%s: cannot allocate memory\n", dev->name); )
+		free_irq(dev->irq, dev);
 		return -ENOMEM;
 	}
    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
