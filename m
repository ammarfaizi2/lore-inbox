Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAISHg>; Tue, 9 Jan 2001 13:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131530AbRAISH1>; Tue, 9 Jan 2001 13:07:27 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:13045 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129436AbRAISHQ>; Tue, 9 Jan 2001 13:07:16 -0500
Date: Tue, 9 Jan 2001 14:19:33 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Moxa Technologies <support@moxa.com.tw>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] mxser.c: capable, look at put_user return
Message-ID: <20010109141933.Z21057@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Moxa Technologies <support@moxa.com.tw>,
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

--- linux-2.4.0-ac4/drivers/char/mxser.c	Tue Dec 19 11:25:34 2000
+++ linux-2.4.0-ac4.acme/drivers/char/mxser.c	Tue Jan  9 14:16:21 2001
@@ -1671,7 +1671,7 @@
 	 */
 	if (inb(info->base + UART_LSR) == 0xff) {
 		restore_flags(flags);
-		if (suser()) {
+		if (capable(CAP_SYS_ADMIN)) {
 			if (info->tty)
 				set_bit(TTY_IO_ERROR, &info->tty->flags);
 			return (0);
@@ -2188,8 +2188,7 @@
 	status = inb(info->base + UART_LSR);
 	restore_flags(flags);
 	result = ((status & UART_LSR_TEMT) ? TIOCSER_TEMT : 0);
-	put_user(result, value);
-	return (0);
+	return put_user(result, value);
 }
 
 /*
@@ -2229,8 +2228,7 @@
 	    ((status & UART_MSR_RI) ? TIOCM_RNG : 0) |
 	    ((status & UART_MSR_DSR) ? TIOCM_DSR : 0) |
 	    ((status & UART_MSR_CTS) ? TIOCM_CTS : 0);
-	put_user(result, value);
-	return (0);
+	return put_user(result, value);
 }
 
 static int mxser_set_modem_info(struct mxser_struct *info, unsigned int cmd,
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
