Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293138AbSCEBRK>; Mon, 4 Mar 2002 20:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293139AbSCEBRC>; Mon, 4 Mar 2002 20:17:02 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:32522 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293138AbSCEBQn>;
	Mon, 4 Mar 2002 20:16:43 -0500
Date: Mon, 4 Mar 2002 17:09:11 -0800
From: Greg KH <greg@kroah.com>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] removal of mp_bus_id_to_node array in 2.5.6-pre2
Message-ID: <20020305010910.GA6139@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 04 Feb 2002 22:57:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a patch against 2.5.6-pre2 that removes the mp_bus_id_to_node
array from arch/i386/kernel/mpparse.c as it isn't needed anymore.  This
saves us a small amount of kernel memory, which is always a good thing :)

thanks,

greg k-h


diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	Mon Mar  4 16:59:01 2002
+++ b/arch/i386/kernel/mpparse.c	Mon Mar  4 16:59:01 2002
@@ -36,7 +36,6 @@
  */
 int apic_version [MAX_APICS];
 int mp_bus_id_to_type [MAX_MP_BUSSES];
-int mp_bus_id_to_node [MAX_MP_BUSSES];
 int mp_bus_id_to_pci_bus [MAX_MP_BUSSES] = { [0 ... MAX_MP_BUSSES-1] = -1 };
 int mp_current_pci_id;
 
@@ -246,8 +245,7 @@
 	str[6] = 0;
 	
 	if (clustered_apic_mode) {
-		mp_bus_id_to_node[m->mpc_busid] = translation_table[mpc_record]->trans_quad;
-		printk("Bus #%d is %s (node %d)\n", m->mpc_busid, str, mp_bus_id_to_node[m->mpc_busid]);
+		printk("Bus #%d is %s (node %d)\n", m->mpc_busid, str, translation_table[mpc_record]->trans_quad);
 	} else {
 		Dprintk("Bus #%d is %s\n", m->mpc_busid, str);
 	}
