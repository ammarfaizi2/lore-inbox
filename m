Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273565AbRIUOjx>; Fri, 21 Sep 2001 10:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273564AbRIUOjd>; Fri, 21 Sep 2001 10:39:33 -0400
Received: from t2.redhat.com ([199.183.24.243]:49652 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S273565AbRIUOjW>; Fri, 21 Sep 2001 10:39:22 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.3.96.1010921101144.28645B-100000@gatekeeper.tmr.com> 
In-Reply-To: <Pine.LNX.3.96.1010921101144.28645B-100000@gatekeeper.tmr.com> 
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lockup with 2.4.9-ac10 on Athlon 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 21 Sep 2001 15:39:44 +0100
Message-ID: <32748.1001083184@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davidsen@tmr.com said:
> > Strange - mine works. Either with APM and 'apm=power-off' on the
> > command line, or with ACPI and a hack to work around the incompetence of
> > Abit's BIOS engineers.

> Is this something Linux could recognize and patch, like the Athlon
> problem with the VIA chipset? 

'Could', yes. 'Should', probably not. It's bad enough that we have to run 
binary-only code from people with this little clue, without having to apply 
patches to it as well.

This is the patch I was using at the time. It won't apply now.

Index: drivers/acpi/namespace/nsalloc.c
===================================================================
RCS file: /inst/cvs/linux/drivers/acpi/namespace/Attic/nsalloc.c,v
retrieving revision 1.1.2.5
diff -u -r1.1.2.5 nsalloc.c
--- drivers/acpi/namespace/nsalloc.c    2001/06/21 09:40:16     1.1.2.5
+++ drivers/acpi/namespace/nsalloc.c    2001/08/11 15:58:51
@@ -60,6 +60,10 @@
        INCREMENT_NAME_TABLE_METRICS (sizeof (ACPI_NAMESPACE_NODE));
 
        node->data_type      = ACPI_DESC_TYPE_NAMED;
+       if (acpi_name == 0x5f555043) {
+               printk("Fixing up object 'CPU_' to name 'CPU0'\n");
+               acpi_name = 0x30555043;
+       }
        node->name           = acpi_name;
        node->reference_count = 1;
 


--
dwmw2


