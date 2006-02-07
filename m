Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbWBGMZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbWBGMZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 07:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbWBGMZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 07:25:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33290 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965056AbWBGMZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 07:25:26 -0500
Date: Tue, 7 Feb 2006 13:25:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Vishal Sharma <vishal.gnutech@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel-2.6.15 compile error
Message-ID: <20060207122525.GE5937@stusta.de>
References: <1200c63a0602062259g5a6d0a28l93f207ef6d3f9485@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1200c63a0602062259g5a6d0a28l93f207ef6d3f9485@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 12:29:03PM +0530, Vishal Sharma wrote:

> Hello All,

Hi Vishal,

> i am trying to install this new kenel into my machine with the option make
> oldconfig , my old kernel is 2.6.11-1.1369_FC4smp and i am using
> gcc-4.0.2.Below s the output of error  i am getting :-
> 
> GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x94aea): In function `sandisk_set_iobase':
> drivers/net/wireless/hostap/hostap_cs.c:242: undefined reference to
> `pcmcia_access_configuration_register'
>...

thanks for your report.

This is a known bug.
Below is the patch I submitted to fix it in 2.6.15.4.

> Regards
> Vishal

cu
Adrian


<--  snip  -->


CONFIG_PCMCIA=m, CONFIG_HOSTAP_CS=y doesn't compile.

Reported by "Gabriel C." <crazy@pimpmylinux.org>.

This patch was already included in 2.6.16-rc2.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc1-mm4/drivers/net/wireless/hostap/Kconfig.old	2006-01-30 19:00:44.000000000 +0100
+++ linux-2.6.16-rc1-mm4/drivers/net/wireless/hostap/Kconfig	2006-01-30 19:01:04.000000000 +0100
@@ -75,7 +75,7 @@
 
 config HOSTAP_CS
 	tristate "Host AP driver for Prism2/2.5/3 PC Cards"
-	depends on PCMCIA!=n && HOSTAP
+	depends on PCMCIA && HOSTAP
 	---help---
 	Host AP driver's version for Prism2/2.5/3 PC Cards.
 


