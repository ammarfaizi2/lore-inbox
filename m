Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264220AbTKKCYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 21:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264221AbTKKCYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 21:24:55 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:39948 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264220AbTKKCYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 21:24:53 -0500
Date: Tue, 11 Nov 2003 00:06:08 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Dag Brattli <dag@brattli.net>, Jean Tourrilhes <jt@hpl.hp.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: [PATCH] irda: fix type of struct irda_ias_set.attribute.irda_attrib_string.len
Message-ID: <20031111020608.GA1208@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Dag Brattli <dag@brattli.net>, Jean Tourrilhes <jt@hpl.hp.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	irda-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC [M]  net/irda/af_irda.o
net/irda/af_irda.c: In function `irda_setsockopt':
net/irda/af_irda.c:1894: warning: comparison is always false due to limited range of data type

in irda_setsockopt:

                        /* Should check charset & co */
                        /* Check length */
                        if(ias_opt->attribute.irda_attrib_string.len >
                           IAS_MAX_STRING) {
                                kfree(ias_opt);
                                return -EINVAL;
                        }

Ok, ias_opt->attribute.irda_attrib_string.len is __u8, but
IAS_MAX_STRING = 256... so attribute.irda_attrib_string.len has to be at least
__u18, this patch fix this, please see if it is appropriate and if it is so,
apply.

Best Regards,

- Arnaldo

===== include/linux/irda.h 1.7 vs edited =====
--- 1.7/include/linux/irda.h	Wed Jun  4 11:16:33 2003
+++ edited/include/linux/irda.h	Mon Nov 10 23:56:33 2003
@@ -151,7 +151,7 @@
 			__u8 octet_seq[IAS_MAX_OCTET_STRING];
 		} irda_attrib_octet_seq;
 		struct {
-			__u8 len;
+			__u16 len;
 			__u8 charset;
 			__u8 string[IAS_MAX_STRING];
 		} irda_attrib_string;
