Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130746AbQLTBNC>; Tue, 19 Dec 2000 20:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130688AbQLTBMw>; Tue, 19 Dec 2000 20:12:52 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:11005 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S130380AbQLTBMk>; Tue, 19 Dec 2000 20:12:40 -0500
Date: Tue, 19 Dec 2000 20:50:59 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David B.Gentzel" <gentzel@nova.enet.dec.com>, cae@jpmorgan.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.2 - ultrastor: spurious restore_flags
Message-ID: <20001219205059.N764@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	David B. Gentzel <gentzel@nova.enet.dec.com>, cae@jpmorgan.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please consider applying

                        - Arnaldo

--- linux-2.2.19-2/drivers/scsi/ultrastor.c	Sat Apr 11 15:13:25 1998
+++ linux-2.2.19-2.acme/drivers/scsi/ultrastor.c	Tue Dec 19 20:45:55 2000
@@ -882,9 +882,8 @@
 	(inb(SYS_DOORBELL_INTR(config.doorbell_address)) & 1))
       {
 	int flags;
-	save_flags(flags);
 	printk("Ux4F: abort while completed command pending\n");
-	restore_flags(flags);
+	save_flags(flags);
 	cli();
 	ultrastor_interrupt(0, NULL, NULL);
 	restore_flags(flags);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
