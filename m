Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279617AbRJXWH7>; Wed, 24 Oct 2001 18:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279615AbRJXWHu>; Wed, 24 Oct 2001 18:07:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34689 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S279614AbRJXWHj>;
	Wed, 24 Oct 2001 18:07:39 -0400
Date: Wed, 24 Oct 2001 15:08:04 -0700 (PDT)
Message-Id: <20011024.150804.15268320.davem@redhat.com>
To: toon@vdpas.hobby.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.13 high SWAP
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011024234826.A19967@vdpas.hobby.nl>
In-Reply-To: <200110241936.RAA04632@inter.lojasrenner.com.br>
	<9r73pv$8h1$1@penguin.transmeta.com>
	<20011024234826.A19967@vdpas.hobby.nl>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: toon@vdpas.hobby.nl
   Date: Wed, 24 Oct 2001 23:48:26 +0200

   The command `make modules_install' results in the following output:
   
   if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.13; fi
   depmod: *** Unresolved symbols in /lib/modules/2.4.13/kernel/fs/ramfs/ramfs.o
   depmod: 	activate_page
   
   Maybe an #include of some header file is missing somewhere?

No, the fix is even simpler:

--- ../vanilla/linux/kernel/ksyms.c	Wed Oct 17 14:32:50 2001
+++ kernel/ksyms.c	Wed Oct 24 14:45:31 2001
@@ -116,6 +116,7 @@
 EXPORT_SYMBOL(get_unmapped_area);
 EXPORT_SYMBOL(init_mm);
 EXPORT_SYMBOL(deactivate_page);
+EXPORT_SYMBOL(activate_page);
 #ifdef CONFIG_HIGHMEM
 EXPORT_SYMBOL(kmap_high);
 EXPORT_SYMBOL(kunmap_high);
