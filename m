Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281428AbRKTWQQ>; Tue, 20 Nov 2001 17:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281435AbRKTWQG>; Tue, 20 Nov 2001 17:16:06 -0500
Received: from c1473286-a.stcla1.sfba.home.com ([24.176.137.160]:1040 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S281428AbRKTWP4>;
	Tue, 20 Nov 2001 17:15:56 -0500
Date: Tue, 20 Nov 2001 14:15:51 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: "Torvalds; Linus" <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: Don't check NFS root when root= is given
Message-ID: <20011120141551.A1239@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel is configured with NFS root, we should be able to pass
root=/dev/sda1 to kernel. mount_root in fs/super.c checks:

#ifdef CONFIG_ROOT_NFS
        if (MAJOR(ROOT_DEV) != UNNAMED_MAJOR)
                goto skip_nfs;
	....

I think net/ipv4/ipconfig.c should do same.


H.J.
--- linux/net/ipv4/ipconfig.c~	Tue Nov 20 14:11:09 2001
+++ linux/net/ipv4/ipconfig.c	Tue Nov 20 11:10:01 2001
@@ -1144,7 +1144,9 @@ static int __init ip_auto_config(void)
 	 */
 	if (ic_myaddr == INADDR_NONE ||
 #ifdef CONFIG_ROOT_NFS
-	    (root_server_addr == INADDR_NONE && ic_servaddr == INADDR_NONE) ||
+	    (MAJOR(ROOT_DEV) == UNNAMED_MAJOR
+	     && root_server_addr == INADDR_NONE
+	     && ic_servaddr == INADDR_NONE) ||
 #endif
 	    ic_first_dev->next) {
 #ifdef IPCONFIG_DYNAMIC
