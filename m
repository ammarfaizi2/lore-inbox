Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTIGQGV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 12:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTIGQGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 12:06:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43026 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263354AbTIGQGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 12:06:19 -0400
Date: Sun, 7 Sep 2003 17:06:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test4-bk9:  card services build error
Message-ID: <20030907170610.B23176@flint.arm.linux.org.uk>
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309071139520.16112-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0309071139520.16112-100000@localhost.localdomain>; from rpjday@mindspring.com on Sun, Sep 07, 2003 at 11:41:28AM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 11:41:28AM -0400, Robert P. J. Day wrote:
> 
>   from a build of 2.6.0-test4-bk9 (didn't appear to be there in bk8):
> 
> ...
> 
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
>   CC      kernel/configs.o
>   LD      kernel/built-in.o
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x8511c): In function `CardServices':
> : undefined reference to `pcmcia_deregister_client'
> drivers/built-in.o(.text+0x86d15): In function `pcmcia_bus_remove_socket':
> : undefined reference to `pcmcia_deregister_client'
> drivers/built-in.o(__ksymtab+0x1150): undefined reference to `pcmcia_deregister_client'
> make: *** [.tmp_vmlinux1] Error 1

Yes, my editors escape code processing was buggy so it dropped an extra "R"
(from the F3 escape code) into cs.c while I was searching.  (F3 is search
forward in MicroEMACS.)  Naturally, with open source, such things get fixed
once they cause you enough annoyance.  (Did I ever mention that terminal
escape codes are broken by design?)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1189  -> 1.1190 
#	 drivers/pcmcia/cs.c	1.60    -> 1.61   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/07	rmk@flint.arm.linux.org.uk	1.1190
# [PCMCIA] Remove editor droppings.
# --------------------------------------------
#
diff -Nru a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
--- a/drivers/pcmcia/cs.c	Sun Sep  7 17:04:33 2003
+++ b/drivers/pcmcia/cs.c	Sun Sep  7 17:04:34 2003
@@ -1053,7 +1053,7 @@
 
 /*====================================================================*/
 
-int pcmcia_deregister_clientR(client_handle_t handle)
+int pcmcia_deregister_client(client_handle_t handle)
 {
     client_t **client;
     struct pcmcia_socket *s;


-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
