Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130326AbRAIObs>; Tue, 9 Jan 2001 09:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130076AbRAIObi>; Tue, 9 Jan 2001 09:31:38 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:29427 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129415AbRAIObZ>; Tue, 9 Jan 2001 09:31:25 -0500
Date: Tue, 9 Jan 2001 10:24:04 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Joshua M.Thompson" <funaho@jurai.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] via-macii.c: restore_flags on failure
Message-ID: <20010109102404.I21057@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Joshua M. Thompson <funaho@jurai.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010108201103.E17087@conectiva.com.br> <20010108202533.F17087@conectiva.com.br> <20010108203002.H17087@conectiva.com.br> <20010109001443.A20786@conectiva.com.br> <20010109091808.G21057@conectiva.com.br> <20010109100037.H21057@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010109100037.H21057@conectiva.com.br>; from acme@conectiva.com.br on Tue, Jan 09, 2001 at 10:00:38AM -0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please consider applying.

- Arnaldo

--- linux-2.4.0-ac4/drivers/macintosh/via-macii.c	Tue Dec 19 11:25:39 2000
+++ linux-2.4.0-ac4.acme/drivers/macintosh/via-macii.c	Tue Jan  9 10:18:17 2001
@@ -9,6 +9,9 @@
  *
  * Rewrite for Unified ADB by Joshua M. Thompson (funaho@jurai.org)
  *
+ * Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+ * - restore_flags on failure in macii_init - 09/01/2001
+ *
  * 1999-08-02 (jmt) - Initial rewrite for Unified ADB.
  */
  
@@ -147,15 +150,16 @@
 	cli();
 	
 	err = macii_init_via();
-	if (err) return err;
+	if (err) goto out;
 
 	err = request_irq(IRQ_MAC_ADB, macii_interrupt, IRQ_FLG_LOCK, "ADB",
 		    macii_interrupt);
-	if (err) return err;
+	if (err) goto out;
 
 	macii_state = idle;
-	restore_flags(flags);	
-	return 0;
+	err = 0;
+out:	restore_flags(flags);	
+	return err;
 }
 
 /* initialize the hardware */	
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
