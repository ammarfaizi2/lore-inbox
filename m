Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130231AbRAIT46>; Tue, 9 Jan 2001 14:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131876AbRAIT4m>; Tue, 9 Jan 2001 14:56:42 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:23286 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S131848AbRAIT4U>; Tue, 9 Jan 2001 14:56:20 -0500
Date: Tue, 9 Jan 2001 16:05:24 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] ide-features.c: unchecked kmalloc
Message-ID: <20010109160524.B24523@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Andre Hedrick <andre@linux-ide.org>,
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

--- linux-2.4.0-ac4/drivers/ide/ide-features.c	Mon Jan  8 20:39:17 2001
+++ linux-2.4.0-ac4.acme/drivers/ide/ide-features.c	Tue Jan  9 16:02:11 2001
@@ -189,6 +189,10 @@
 	__cli();		/* local CPU only; some systems need this */
 	SELECT_MASK(HWIF(drive), drive, 0);
 	id = kmalloc(SECTOR_WORDS*4, GFP_ATOMIC);
+	if (!id) {
+		__restore_flags(flags);	/* local CPU only */
+		return 0;
+	}
 	ide_input_data(drive, id, SECTOR_WORDS);
 	(void) GET_STAT();	/* clear drive IRQ */
 	ide__sti();		/* local CPU only */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
