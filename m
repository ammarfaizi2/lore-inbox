Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVBZSSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVBZSSK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 13:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVBZSSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 13:18:09 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:63197 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261256AbVBZSRe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 13:17:34 -0500
Message-ID: <4220BD40.6040104@tiscali.de>
Date: Sat, 26 Feb 2005 19:17:36 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias.Kunze@gmx-topmail.de
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] config option for default loglevel
References: <20050226190556.0def242c.Matthias.Kunze@gmx-topmail.de>
In-Reply-To: <20050226190556.0def242c.Matthias.Kunze@gmx-topmail.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Kunze wrote:

>Hi,
>
>I've created a little patch to make the default loglevel a configurable
>option. Is there a chance that this patch will be included in a future
>release?
>
>diff -Naur linux-2.6.10/drivers/video/console/Kconfig linux-2.6.10-new/drivers/video/console/Kconfig
>--- linux-2.6.10/drivers/video/console/Kconfig  2004-12-24 22:34:26.000000000 +0100
>+++ linux-2.6.10-new/drivers/video/console/Kconfig      2005-02-26 17:11:03.000000000 +0100
>@@ -186,5 +186,25 @@
>          big letters (like the letters used in the SPARC PROM). If the
>          standard font is unreadable for you, say Y, otherwise say N.
> 
>+config DEFAULT_CONSOLE_LOGLEVEL
>+        int "Default Console Loglevel"
>+        range 1 8
>+        default 7
>+        help
>+          All Kernel Messages with a loglevel smaller than the console loglevel
>+          will be printed to the console. This value can later be changed with
>+          klogd or other programs. The loglevels are defined as follows:
>+
>+          0 (KERN_EMERG)        system is unusable
>+          1 (KERN_ALERT)        action must be taken immediately
>+          2 (KERN_CRIT)         critical conditions
>+          3 (KERN_ERR)          error conditions
>+          4 (KERN_WARNING)      warning conditions
>+          5 (KERN_NOTICE)       normal but significant condition
>+          6 (KERN_INFO)         informational
>+          7 (KERN_DEBUG)        debug-level messages
>+
>+          The console loglevel can be set to a value in the range from 1 to 8.
>+
> endmenu
> 
>diff -Naur linux-2.6.10/kernel/printk.c linux-2.6.10-new/kernel/printk.c
>--- linux-2.6.10/kernel/printk.c        2005-02-26 16:49:03.000000000 +0100
>+++ linux-2.6.10-new/kernel/printk.c    2005-02-26 17:32:09.000000000 +0100
>@@ -41,7 +41,7 @@
> 
> /* We show everything that is MORE important than this.. */
> #define MINIMUM_CONSOLE_LOGLEVEL 1 /* Minimum loglevel we let people use */
>-#define DEFAULT_CONSOLE_LOGLEVEL 7 /* anything MORE serious than KERN_DEBUG */
>+#define DEFAULT_CONSOLE_LOGLEVEL CONFIG_DEFAULT_CONSOLE_LOGLEVEL
> 
> DECLARE_WAIT_QUEUE_HEAD(log_wait);
>
>
>---
>Matthias Kunze
>http://elpp.foofighter.de
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hi!
I think this patch is useful and should be included in further Kernel 
releases.

Matthias-Christian Ott
