Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbTIKP5U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 11:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbTIKP5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 11:57:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:26588 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261325AbTIKP5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 11:57:18 -0400
Date: Thu, 11 Sep 2003 08:54:31 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Claas Langbehn <claas@rootdir.de>
cc: <linux-kernel@vger.kernel.org>, Andrew de Quincey <adq@lidskialf.net>,
       <acpi-devel@lists.sourceforge.net>
Subject: Re: [2.6.0-test5-mm1] Suspend to RAM problems
In-Reply-To: <20030911124530.GA7695@rootdir.de>
Message-ID: <Pine.LNX.4.33.0309110852020.984-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [...]
>   CC      drivers/acpi/sleep/proc.o
>   drivers/acpi/sleep/proc.c: In function `acpi_system_write_sleep':
>   drivers/acpi/sleep/proc.c:72: error: void value not ignored as it
>   ought to be
>   make[3]: *** [drivers/acpi/sleep/proc.o] Error 1
>   make[2]: *** [drivers/acpi/sleep] Error 2
>   make[1]: *** [drivers/acpi] Error 2
>   make: *** [drivers] Error 2
> 
> 
> Is there an incremental patch from -pm1 to -pm2?
> I would apply it to -test5-mm1 then

Patch below. Sorry about that.


	Pat

diff -Nru a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
--- a/drivers/acpi/sleep/proc.c	Thu Sep 11 08:54:01 2003
+++ b/drivers/acpi/sleep/proc.c	Thu Sep 11 08:54:01 2003
@@ -69,7 +69,7 @@
 	state = simple_strtoul(str, NULL, 0);
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	if (state == 4) {
-		error = software_suspend();
+		software_suspend();
 		goto Done;
 	}
 #endif

