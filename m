Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129539AbQLTAcH>; Tue, 19 Dec 2000 19:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129703AbQLTAb5>; Tue, 19 Dec 2000 19:31:57 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:36090 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129539AbQLTAbp>; Tue, 19 Dec 2000 19:31:45 -0500
Date: Tue, 19 Dec 2000 20:10:02 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.2 - wanxl unchecked copy_to_user
Message-ID: <20001219201001.L764@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Please consider applying, there must well be other things to do on
this failure, please check.

                        - Arnaldo

--- linux-2.2.19-2/drivers/net/wanxl.c	Wed Jun  7 18:26:43 2000
+++ linux-2.2.19-2.acme/drivers/net/wanxl.c	Tue Dec 19 20:05:53 2000
@@ -1088,7 +1088,10 @@
 
 	writel(1, &card->config->valid);
   
-	copy_to_user(data, card->config, sizeof(board_cfg));
+	if (copy_to_user(data, card->config, sizeof(board_cfg))) {
+		wanxl_destroy_card(card, 0);
+		return -EFAULT;
+	}
 	*length=sizeof(board_cfg);
 	card->running=1;
 	return 0;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
