Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRAIP0n>; Tue, 9 Jan 2001 10:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130008AbRAIP0d>; Tue, 9 Jan 2001 10:26:33 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:62969 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129742AbRAIP0S>; Tue, 9 Jan 2001 10:26:18 -0500
Date: Tue, 9 Jan 2001 11:38:37 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] dn_keyb.c: restore_flags on failure
Message-ID: <20010109113837.P21057@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010108201103.E17087@conectiva.com.br> <20010108202533.F17087@conectiva.com.br> <20010108203002.H17087@conectiva.com.br> <20010109001443.A20786@conectiva.com.br> <20010109091808.G21057@conectiva.com.br> <20010109100037.H21057@conectiva.com.br> <20010109102404.I21057@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010109102404.I21057@conectiva.com.br>; from acme@conectiva.com.br on Tue, Jan 09, 2001 at 10:24:04AM -0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

	Please consider applying. I don't who is the maintainer, no
references in the driver, CREDITS or MAINTAINERS

- Arnaldo

--- linux-2.4.0-ac4/drivers/char/dn_keyb.c	Fri Jul 28 06:34:40 2000
+++ linux-2.4.0-ac4.acme/drivers/char/dn_keyb.c	Tue Jan  9 10:32:17 2001
@@ -435,15 +435,14 @@
 	for(;length;length--) {
 		keyb_cmds[keyb_cmd_write++]=*(cmd++);
 		if(keyb_cmd_write==keyb_cmd_read)
-			return;
+			goto out;
 		if(keyb_cmd_write==APOLLO_KEYB_CMD_ENTRIES)
 			keyb_cmd_write=0;
 	}
 	if(!keyb_cmd_transmit)  {
  	   sio01.BRGtest_cra=5;
 	}
-	restore_flags(flags);
-
+out:	restore_flags(flags);
 }
 
 static struct busmouse apollo_mouse = {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
