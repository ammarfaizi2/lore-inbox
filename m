Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272433AbRIXVXG>; Mon, 24 Sep 2001 17:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272441AbRIXVW4>; Mon, 24 Sep 2001 17:22:56 -0400
Received: from ns.suse.de ([213.95.15.193]:20230 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S272433AbRIXVWl>;
	Mon, 24 Sep 2001 17:22:41 -0400
Date: Mon, 24 Sep 2001 23:23:07 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: <vmabraham@hotmail.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] iph5526.c namespace fix.
Message-ID: <Pine.LNX.4.30.0109242321580.18173-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The iph5526 driver uses a 'FRAME_SIZE' define, which redefines the
definition in asm-i386/ptrace.h The patch below changes it to
something less generic sounding.

regards,

Dave.

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/fc/iph5526.c linux-dj/drivers/net/fc/iph5526.c
--- linux/drivers/net/fc/iph5526.c	Fri Sep 14 00:04:43 2001
+++ linux-dj/drivers/net/fc/iph5526.c	Mon Sep 24 21:35:09 2001
@@ -1932,7 +1932,7 @@
 		fi->g.name_server = FALSE;
 		fi->g.alpa_list_index = 0;
 		fi->g.ox_id = NOT_SCSI_XID;
-		fi->g.my_mtu = FRAME_SIZE;
+		fi->g.my_mtu = TACH_FRAME_SIZE;

 		/* Implicitly LOGO with all logged-in nodes.
 		 */
@@ -2811,7 +2811,7 @@
 	else
 	if (logi == ELS_FLOGI)
 		fi->g.login.common_features = htons(FLOGI_C_F);
-	fi->g.login.recv_data_field_size = htons(FRAME_SIZE);
+	fi->g.login.recv_data_field_size = htons(TACH_FRAME_SIZE);
 	fi->g.login.n_port_total_conc_seq = htons(CONCURRENT_SEQUENCES);
 	fi->g.login.rel_off_by_info_cat = htons(RO_INFO_CATEGORY);
 	fi->g.login.ED_TOV = htonl(E_D_TOV);
@@ -2847,7 +2847,7 @@
 		fi->g.login.c_of_s[2].service_options  = htons(SERVICE_VALID);
 	fi->g.login.c_of_s[2].initiator_ctl = htons(0);
 	fi->g.login.c_of_s[2].recipient_ctl = htons(0);
-	fi->g.login.c_of_s[2].recv_data_field_size = htons(FRAME_SIZE);
+	fi->g.login.c_of_s[2].recv_data_field_size = htons(TACH_FRAME_SIZE);
 	fi->g.login.c_of_s[2].concurrent_sequences = htons(CLASS3_CONCURRENT_SEQUENCE);
 	fi->g.login.c_of_s[2].n_port_end_to_end_credit = htons(0);
 	fi->g.login.c_of_s[2].open_seq_per_exchange = htons(CLASS3_OPEN_SEQUENCE);
diff -urN --exclude-from=/home/davej/.exclude linux/drivers/net/fc/tach.h linux-dj/drivers/net/fc/tach.h
--- linux/drivers/net/fc/tach.h	Mon Aug 23 18:12:38 1999
+++ linux-dj/drivers/net/fc/tach.h	Mon Sep 24 21:34:28 2001
@@ -94,9 +94,9 @@

 /* Size of the various buffers.
  */
-#define FRAME_SIZE              2048
-#define MFS_BUFFER_SIZE         FRAME_SIZE
-#define SFS_BUFFER_SIZE         (FRAME_SIZE + TACHYON_HEADER_LEN)
+#define TACH_FRAME_SIZE         2048
+#define MFS_BUFFER_SIZE         TACH_FRAME_SIZE
+#define SFS_BUFFER_SIZE         (TACH_FRAME_SIZE + TACHYON_HEADER_LEN)
 #define SEST_BUFFER_SIZE        512
 #define TACH_HEADER_SIZE        64
 #define NO_OF_TACH_HEADERS      ((MY_PAGE_SIZE)/TACH_HEADER_SIZE)


-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

