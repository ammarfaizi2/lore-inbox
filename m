Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280917AbRKTGGs>; Tue, 20 Nov 2001 01:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280932AbRKTGGi>; Tue, 20 Nov 2001 01:06:38 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:55050 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S280917AbRKTGGX>;
	Tue, 20 Nov 2001 01:06:23 -0500
Date: Tue, 20 Nov 2001 17:02:20 +1100
From: Anton Blanchard <anton@samba.org>
To: G?rard Roudier <groudier@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] small sym-2 fix
Message-ID: <20011120170219.A10454@krispykreme>
In-Reply-To: <20011115172204.B1589-100000@gerard> <20011115203852.M2136-100000@gerard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011115203852.M2136-100000@gerard>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> Could you revert your change and give my patch below a try. Btw, you will
> be in sync with my current sources. Booting with sym53c8xx=debug:1 will
> let the driver print all memory allocations to the syslog. You may send me
> the drivers messages related to these allocations for information.

Thanks, it boots OK now. Do you still want a debug log?

BTW on ppc64 we can have io port addresses > 32 bits so this change is
required.

Anton

diff -urN linuxppc_2_4_devel/drivers/scsi/sym53c8xx_2/sym_glue.h linuxppc_2_4_devel_work/drivers/scsi/sym53c8xx_2/sym_glue.h
--- linuxppc_2_4_devel/drivers/scsi/sym53c8xx_2/sym_glue.h	Mon Nov 12 11:46:42 2001
+++ linuxppc_2_4_devel_work/drivers/scsi/sym53c8xx_2/sym_glue.h	Tue Nov 20 16:35:14 2001
@@ -463,7 +462,7 @@
 
 	vm_offset_t	mmio_va;	/* MMIO kernel virtual address	*/
 	vm_offset_t	ram_va;		/* RAM  kernel virtual address	*/
-	u32		io_port;	/* IO port address		*/
+	u_long		io_port;	/* IO port address		*/
 	u_short		io_ws;		/* IO window size		*/
 	int		irq;		/* IRQ number			*/
 
