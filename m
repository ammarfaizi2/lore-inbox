Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263997AbSIUQdD>; Sat, 21 Sep 2002 12:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275752AbSIUQdD>; Sat, 21 Sep 2002 12:33:03 -0400
Received: from mail.gmx.de ([213.165.64.20]:56802 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263997AbSIUQdC>;
	Sat, 21 Sep 2002 12:33:02 -0400
Date: Sat, 21 Sep 2002 19:37:52 +0300
From: Dan Aloni <da-x@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 : compile failed with undefined reference to find_smp_config with SMP disabled
Message-ID: <20020921163752.GA19943@callisto.yi.org>
References: <20020921115942.A161@alexis.itd.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020921115942.A161@alexis.itd.umich.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002 at 11:59:42AM -0400, Alexis de Bernis wrote:

> 	This happens with the vanilla 2.5.37 kernel. More information available
> on demand.
> 
> Note : I have even more undefined reference with APIC enabled (and even, even more
> with IO-APIC enabled).


The problem is that CONFIG_X86_FIND_SMP_CONFIG gets always enabled when you
enable APIC (CONFIG_X86_LOCAL_APIC).


--- linux-2.5-BKcurr/arch/i386/config.in.orig	2002-09-21 19:32:26.000000000 +0300
+++ linux-2.5-BKcurr/arch/i386/config.in	2002-09-21 19:33:00.000000000 +0300
@@ -440,7 +440,9 @@
 
 if [ "$CONFIG_X86_LOCAL_APIC" = "y" ]; then
    define_bool CONFIG_X86_EXTRA_IRQS y
-   define_bool CONFIG_X86_FIND_SMP_CONFIG y
+   if [ "$CONFIG_SMP" = "y" ]; then
+      define_bool CONFIG_X86_FIND_SMP_CONFIG y
+   fi
 fi
 
 endmenu


-- 
Dan Aloni
da-x@gmx.net
