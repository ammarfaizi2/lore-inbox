Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbTGRN1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 09:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbTGRN1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 09:27:05 -0400
Received: from [200.230.190.107] ([200.230.190.107]:43022 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S261249AbTGRN1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:27:00 -0400
Subject: Re: confusing ACPI, APM menu dependencies
From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>, alan@redhat.com
In-Reply-To: <Pine.LNX.4.53.0307180839400.4641@localhost.localdomain>
References: <Pine.LNX.4.53.0307180839400.4641@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-V4w/mzQAdehxmHneYtyv"
Organization: Governo Eletronico - SP
Message-Id: <1058535941.444.15.camel@lorien>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 18 Jul 2003 10:45:41 -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-V4w/mzQAdehxmHneYtyv
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Em Sex, 2003-07-18 =E0s 09:42, Robert P. J. Day escreveu:
>   in "make xconfig" for 2.6.0-test1-ac2, the menu entries for
> power management are a little confusing.

 I'm not sure if this is right (the software suspend help says
that it does not depends on PM, so I removed it).

 Look if you like it.

--=20
Luiz Fernando N. Capitulino

<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

--=-V4w/mzQAdehxmHneYtyv
Content-Disposition: attachment; filename=2.6-ac2_kconfig.diff
Content-Type: text/x-patch; name=2.6-ac2_kconfig.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Nru linux-2.6.0-test1-ac2/arch/i386/Kconfig linux-2.6.0-test1-ac2~/arch/i386/Kconfig
--- linux-2.6.0-test1-ac2/arch/i386/Kconfig	2003-07-14 13:23:54.000000000 -0300
+++ linux-2.6.0-test1-ac2~/arch/i386/Kconfig	2003-07-18 10:21:47.000000000 -0300
@@ -820,37 +820,6 @@
 	  will issue the hlt instruction if nothing is to be done, thereby
 	  sending the processor to sleep and saving power.
 
-config SOFTWARE_SUSPEND
-	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM && SWAP
-	---help---
-	  Enable the possibilty of suspendig machine. It doesn't need APM.
-	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
-	  (patch for sysvinit needed). 
-
-	  It creates an image which is saved in your active swaps. By the next
-	  booting the, pass 'resume=/path/to/your/swap/file' and kernel will 
-	  detect the saved image, restore the memory from
-	  it and then it continues to run as before you've suspended.
-	  If you don't want the previous state to continue use the 'noresume'
-	  kernel option. However note that your partitions will be fsck'd and
-	  you must re-mkswap your swap partitions/files.
-
-	  Right now you may boot without resuming and then later resume but
-	  in meantime you cannot use those swap partitions/files which were
-	  involved in suspending. Also in this case there is a risk that buffers
-	  on disk won't match with saved ones.
-
-	  SMP is supported ``as-is''. There's a code for it but doesn't work.
-	  There have been problems reported relating SCSI.
-
-	  This option is about getting stable. However there is still some
-	  absence of features.
-
-	  For more information take a look at Documentation/swsusp.txt.
-
-source "drivers/acpi/Kconfig"
-
 config APM
 	tristate "Advanced Power Management BIOS support"
 	depends on PM
@@ -996,6 +965,37 @@
 	  a work-around for a number of buggy BIOSes. Switch this option on if
 	  your computer crashes instead of powering off properly.
 
+config SOFTWARE_SUSPEND
+	bool "Software Suspend (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && SWAP
+	---help---
+	  Enable the possibilty of suspendig machine. It doesn't need APM.
+	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
+	  (patch for sysvinit needed). 
+
+	  It creates an image which is saved in your active swaps. By the next
+	  booting the, pass 'resume=/path/to/your/swap/file' and kernel will 
+	  detect the saved image, restore the memory from
+	  it and then it continues to run as before you've suspended.
+	  If you don't want the previous state to continue use the 'noresume'
+	  kernel option. However note that your partitions will be fsck'd and
+	  you must re-mkswap your swap partitions/files.
+
+	  Right now you may boot without resuming and then later resume but
+	  in meantime you cannot use those swap partitions/files which were
+	  involved in suspending. Also in this case there is a risk that buffers
+	  on disk won't match with saved ones.
+
+	  SMP is supported ``as-is''. There's a code for it but doesn't work.
+	  There have been problems reported relating SCSI.
+
+	  This option is about getting stable. However there is still some
+	  absence of features.
+
+	  For more information take a look at Documentation/swsusp.txt.
+
+source "drivers/acpi/Kconfig"
+
 source "arch/i386/kernel/cpu/cpufreq/Kconfig"
 
 endmenu

--=-V4w/mzQAdehxmHneYtyv--

