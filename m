Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131471AbRAISkV>; Tue, 9 Jan 2001 13:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131474AbRAISkC>; Tue, 9 Jan 2001 13:40:02 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:32506 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S131471AbRAISj6>; Tue, 9 Jan 2001 13:39:58 -0500
Date: Tue, 9 Jan 2001 14:33:29 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] n_r3964: restore_flags on failure
Message-ID: <20010109143328.B21057@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please consider applying.

- Arnaldo

--- linux-2.4.0-ac4/drivers/char/n_r3964.c	Tue Dec 19 11:25:34 2000
+++ linux-2.4.0-ac4.acme/drivers/char/n_r3964.c	Tue Jan  9 14:23:07 2001
@@ -988,8 +988,10 @@
 
       pMsg = kmalloc(sizeof(struct r3964_message), GFP_KERNEL);
       TRACE_M("add_msg - kmalloc %x",(int)pMsg);
-      if(pMsg==NULL)
+      if(pMsg==NULL) {
+      	 restore_flags(flags);
          return;
+      }
 
       pMsg->msg_id = msg_id;
       pMsg->arg    = arg;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
