Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293010AbSCJKMC>; Sun, 10 Mar 2002 05:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293012AbSCJKLm>; Sun, 10 Mar 2002 05:11:42 -0500
Received: from 1Cust48.tnt6.lax7.da.uu.net ([67.193.244.48]:53230 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S293010AbSCJKLm>; Sun, 10 Mar 2002 05:11:42 -0500
Subject: [PATCH] 2.2.21pre[234] misreports Pentium II model names
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 10 Mar 2002 00:16:54 -0800 (PST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16jWBa-0008Nc-00@the-village.bc.nu> from "Alan Cox" at Mar 09, 2002 02:02:14 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020310081654.1D8C789680@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.2.21-pre2 through -pre4, many Intel CPUs are misreported in
/proc/cpuinfo and dmesg as Mobile Pentium II's, even when they are
Celerons in desktops or whatever.

In init_intel, the correct CPU name is being assigned to p, but p isn't
being copied into c->x86_model_id. As a result, the name from the tables,
"Mobile Pentium II", is always being used.

This patch (backported from 2.4) fixes the problem. Alan, please apply.

-Barry K. Nathan <barryn@pobox.com>

--- linux-2.2.21-pre4/arch/i386/kernel/setup.c	Sat Mar  9 03:58:57 2002
+++ linux-2.2.21-pre4-bknA-2/arch/i386/kernel/setup.c	Sat Mar  9 22:31:34 2002
@@ -1232,6 +1232,9 @@
 				break;
 		}
 	}
+
+	if ( p )
+		strcpy(c->x86_model_id, p);
 }
 
 struct cpu_model_info {
