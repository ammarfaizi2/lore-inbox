Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbVIQM3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVIQM3f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 08:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVIQM3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 08:29:35 -0400
Received: from smtp9.wanadoo.fr ([193.252.22.22]:29301 "EHLO smtp9.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1751093AbVIQM3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 08:29:34 -0400
X-ME-UUID: 20050917122902108.1A9031C0012E@mwinf0908.wanadoo.fr
Message-ID: <432C0BF2.6020406@zarb.org>
Date: Sat, 17 Sep 2005 14:28:34 +0200
From: trem <trem@zarb.org>
User-Agent: Mozilla Thunderbird 1.0.6-5mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Tom Rini <trini@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: dependance loop on 2.6.14-rc1-mm1
References: <432C00C6.20305@zarb.org> <20050917115138.GA17589@flint.arm.linux.org.uk>
In-Reply-To: <20050917115138.GA17589@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've done a little test, I've remove this line from serial_core.c

+#ifdef CONFIG_KGDB
+       {
+               extern int kgdb_irq;
+
+               if (port->irq == kgdb_irq)
+                       return;
+       }
+#endif


and now the make modules_install works fine.

thanks for the help,
trem



Russell King a écrit :

>On Sat, Sep 17, 2005 at 01:40:54PM +0200, trem wrote:
>  
>
>>I've tried to compile a 2.6.14-rc1-mm1 on my amd64. When I do the make 
>>modules_install,
>>I have this warning:
>>
>>WARNING: Loop detected:
>>/lib/modules/2.6.14-rc1-mm1/kernel/drivers/serial/8250.ko needs 
>>serial_core.ko which needs 8250.ko again!
>>    
>>
>
>This looks suspicious.  8250 should need serial_core, but there's no
>way in hell serial_core should require 8250. 
>
>Seems to be caused by the kgdb patches, which add the following to
>serial_core:
>
>+#ifdef CONFIG_KGDB
>+       {
>+               extern int kgdb_irq;
>+
>+               if (port->irq == kgdb_irq)
>+                       return;
>+       }
>+#endif
>+
>
>and kgdb_irq comes from the 8250 module.
>
>Tom, can this dependency be solved before kgdb goes near mainline
>please?
>
>  
>


