Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129763AbRAINsy>; Tue, 9 Jan 2001 08:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbRAINso>; Tue, 9 Jan 2001 08:48:44 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:254 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S130032AbRAINs0>; Tue, 9 Jan 2001 08:48:26 -0500
Date: Tue, 9 Jan 2001 10:00:38 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sscape.c: include missing restore_flags
Message-ID: <20010109100037.H21057@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010108201103.E17087@conectiva.com.br> <20010108202533.F17087@conectiva.com.br> <20010108203002.H17087@conectiva.com.br> <20010109001443.A20786@conectiva.com.br> <20010109091808.G21057@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010109091808.G21057@conectiva.com.br>; from acme@conectiva.com.br on Tue, Jan 09, 2001 at 09:18:08AM -0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

	Please apply.

- Arnaldo

--- linux-2.4.0-ac4/drivers/sound/sscape.c	Mon Jan  8 20:39:30 2001
+++ linux-2.4.0-ac4.acme/drivers/sound/sscape.c	Tue Jan  9 09:16:39 2001
@@ -16,6 +16,7 @@
  * Christoph Hellwig	: adapted to module_init/module_exit
  * Bartlomiej Zolnierkiewicz : added __init to attach_sscape()
  * Chris Rankin		: Specify that this module owns the coprocessor
+ * Arnaldo C. de Melo	: added missing restore_flags in sscape_pnp_upload_file
  */
 
 #include <linux/init.h>
@@ -969,7 +970,10 @@
 		memcpy(devc->raw_buf, dt, l); dt += l;
 		sscape_start_dma(devc->dma, devc->raw_buf_phys, l, 0x48);
 		sscape_pnp_start_dma ( devc, 0 );
-		if (sscape_pnp_wait_dma ( devc, 0 ) == 0) return 0;
+		if (sscape_pnp_wait_dma ( devc, 0 ) == 0) {
+			restore_flags(flags);	    
+			return 0;
+		}
 	}
 	
 	restore_flags(flags);	    
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
