Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261635AbSJNNlT>; Mon, 14 Oct 2002 09:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbSJNNlT>; Mon, 14 Oct 2002 09:41:19 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:59285
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S261635AbSJNNlS>; Mon, 14 Oct 2002 09:41:18 -0400
Date: Mon, 14 Oct 2002 09:56:47 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Theewara Vorakosit <g4465018@pirun.ku.ac.th>, linux-kernel@vger.kernel.org
Subject: Re: NFS root on 2.4.18-14
Message-ID: <20021014095647.A6453@animx.eu.org>
References: <Pine.GSO.4.44.0210142012520.5993-100000@pirun.ku.ac.th> <3DAAC457.3040402@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3DAAC457.3040402@domdv.de>; from Andreas Steinmetz on Mon, Oct 14, 2002 at 03:19:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >     I use Red Hat 8.0 and kernel 2.4.18-14, which come from redhat
> > distribution. I want create a NFS-root kernel to build a diskless linux
> > using NFS root. I select "IP kernel level configuration-> BOOTP, DHCP",
> > NFS root support. I boot client using my kernel, it does not requrest for
> > an IP address. It try to mount NFS root immediately. Do I forget
> > something?
> If you try to boot from a floppy that was created like "dd if=vmlinuz 
> of=/dev/fd0" you will need the attached patch. Alan Cox however told me 
> that the ability to boot without boot manager (e.g. lilo) will 
> eventually go away.

I hope it doesn't.  I use it quite frequently at work.  It's jsut so much
easier to use than installing a bootloader onto a floppy, mounting, copying
the kernel and so forth.

I did this patch which works for me, but only if root=/dev/nfs  It was done
against 2.4.13 or something around there, but it applies with offset to all
newer 2.4 kernels and I believe all 2.5 kernels.

--- net/ipv4/ipconfig-orig.c	2001-11-19 20:48:35.000000000 -0500
+++ net/ipv4/ipconfig.c	2001-11-19 20:56:21.000000000 -0500
@@ -1105,7 +1105,11 @@
 	proc_net_create("pnp", 0, pnp_get_info);
 #endif /* CONFIG_PROC_FS */
 
-	if (!ic_enable)
+	if (!ic_enable
+#if defined(IPCONFIG_DYNAMIC) && defined(CONFIG_ROOT_NFS)
+	    && ROOT_DEV != MKDEV(UNNAMED_MAJOR, 255)
+#endif
+	   )
 		return 0;
 
 	DBG(("IP-Config: Entered.\n"));


-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
