Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281895AbRKZQLG>; Mon, 26 Nov 2001 11:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281896AbRKZQK5>; Mon, 26 Nov 2001 11:10:57 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:26362 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S281895AbRKZQKk>; Mon, 26 Nov 2001 11:10:40 -0500
Date: Mon, 26 Nov 2001 17:03:49 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ben Greear <greearb@candelatech.com>, Ben Greear <greearb@agcs.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.16: 802.1Q VLAN non-modular
Message-ID: <Pine.GSO.3.96.1011126165647.21598T-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 It appears the 802.1Q VLAN support didn't receive even basic testing,
sigh...  It doesn't compile non-modular, due to vlan_proc_cleanup() being
discarded, yet needed in vlan_proc_init().  Following is a fix. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.14-20011123-vlan-0
diff -up --recursive --new-file linux-mips-2.4.14-20011123.macro/net/8021q/vlanproc.c linux-mips-2.4.14-20011123/net/8021q/vlanproc.c
--- linux-mips-2.4.14-20011123.macro/net/8021q/vlanproc.c	Tue Nov  6 07:56:16 2001
+++ linux-mips-2.4.14-20011123/net/8021q/vlanproc.c	Sun Nov 25 02:28:24 2001
@@ -116,7 +116,7 @@ static char conf_hdr[] = "VLAN Dev name	
  *	Clean up /proc/net/vlan entries
  */
 
-void __exit vlan_proc_cleanup(void)
+void vlan_proc_cleanup(void)
 {
 	if (proc_vlan_conf)
 		remove_proc_entry(name_conf, proc_vlan_dir);
@@ -462,7 +462,7 @@ int __init vlan_proc_init (void)
 	return 0;
 }
 
-void __exit vlan_proc_cleanup(void)
+void vlan_proc_cleanup(void)
 {
 	return;
 }

