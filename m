Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVA2WxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVA2WxQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 17:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVA2WxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 17:53:15 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:42666 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261581AbVA2Wwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 17:52:50 -0500
Message-ID: <41FC13A3.6080407@ens-lyon.fr>
Date: Sat, 29 Jan 2005 23:52:19 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, benoit.boissinot@ens-lyon.org
Subject: Re: 2.6.11-rc2-mm2
References: <20050129131134.75dacb41.akpm@osdl.org>
In-Reply-To: <20050129131134.75dacb41.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc2/2.6.11-rc2-mm2/
> 
> Changes since 2.6.11-rc2-mm1:
> +fix-kallsyms-insmod-rmmod-race.patch
> +fix-kallsyms-insmod-rmmod-race-fix.patch
> +fix-kallsyms-insmod-rmmod-race-fix-fix.patch
> 
>  fix a modules race

Hi Andrew,

CONFIG_STOP_MACHINE is not defined on my laptop. This breaks module loading.
The reason is that stop_machine_run does nothing, especially
it does not call the function that is passed as a parameter.

Looks like -fix needs another fix :)

What about a patch like this one ?

Regards,
Brice


Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>

--- linux-mm/include/linux/stop_machine.h.orig	2005-01-29 23:37:11.000000000 +0100
+++ linux-mm/include/linux/stop_machine.h	2005-01-29 23:37:31.000000000 +0100
@@ -57,7 +57,7 @@
  static inline int stop_machine_run(int (*fn)(void *), void *data,
  				   unsigned int cpu)
  {
-	return 0;
+	return fn(data);
  }

  #endif	/* CONFIG_STOP_MACHINE */
