Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314475AbSECPBW>; Fri, 3 May 2002 11:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314477AbSECPBV>; Fri, 3 May 2002 11:01:21 -0400
Received: from imladris.infradead.org ([194.205.184.45]:56069 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314475AbSECPBV>; Fri, 3 May 2002 11:01:21 -0400
Date: Fri, 3 May 2002 16:01:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Ivan G." <ivangurdiev@linuxfreemail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre8
Message-ID: <20020503160111.B9729@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Ivan G." <ivangurdiev@linuxfreemail.com>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <02050308321201.07377@cobra.linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 08:32:12AM -0600, Ivan G. wrote:
> Upgrading 2.4.19-pre3 to 2.4.19-pre8
> but problem is probably created by 2.4.19-pre7 where i saw apic changes

I think the following patch should fix it:

diff -uNr -Xdontdiff linux-2.4.19-pre7/arch/i386/kernel/dmi_scan.c linux/arch/i386/kernel/dmi_scan.c
--- linux-2.4.19-pre7/arch/i386/kernel/dmi_scan.c	Tue Apr 16 20:49:06 2002
+++ linux/arch/i386/kernel/dmi_scan.c	Tue Apr 16 20:56:03 2002
@@ -362,7 +362,7 @@
 	printk(KERN_INFO " *** If you see IRQ problems, in paticular SCSI resets and hangs at boot\n");
 	printk(KERN_INFO " *** contact your hardware vendor and ask about updates.\n");
 	printk(KERN_INFO " *** Building an SMP kernel may evade the bug some of the time.\n");
-#ifdef CONFIG_X86_UP_APIC
+#ifdef CONFIG_X86_UP_IOAPIC
 	skip_ioapic_setup = 0;
 #endif
 	return 0;
diff -uNr -Xdontdiff linux-2.4.19-pre7/init/main.c linux/init/main.c
--- linux-2.4.19-pre7/init/main.c	Tue Apr 16 20:47:46 2002
+++ linux/init/main.c	Tue Apr 16 20:59:56 2002
@@ -296,8 +296,7 @@
 extern int skip_ioapic_setup;
 static void __init smp_init(void)
 {
-	if (!skip_ioapic_setup)
-		APIC_init_uniprocessor();
+	APIC_init_uniprocessor();
 }
 #else
 #define smp_init()	do { } while (0)
