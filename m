Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265550AbRF1GOi>; Thu, 28 Jun 2001 02:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265552AbRF1GO3>; Thu, 28 Jun 2001 02:14:29 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:34103 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S265550AbRF1GOY>; Thu, 28 Jun 2001 02:14:24 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: elenstev@mesatop.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.4.6-pre6 fix drivers/net/Config.in error 
In-Reply-To: Your message of "Thu, 28 Jun 2001 00:07:13 -0400."
             <3B3AAD71.84FC36AD@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Jun 2001 16:14:12 +1000
Message-ID: <3541.993708852@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001 00:07:13 -0400, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>Steven Cole wrote:
>> -   dep_bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI
>> +   dep_bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI $CONFIG_PCI
>
>See the "EISA" and "VLB" parts in there?  EISA != PCI

Against 2.4.6-pre6.

Index: 6-pre6.1/drivers/net/Config.in
--- 6-pre6.1/drivers/net/Config.in Thu, 28 Jun 2001 10:34:32 +1000 kaos (linux-2.4/l/c/9_Config.in 1.1.2.2.1.3.1.8 644)
+++ 6-pre6.1(w)/drivers/net/Config.in Thu, 28 Jun 2001 16:07:03 +1000 kaos (linux-2.4/l/c/9_Config.in 1.1.2.2.1.3.1.8 644)
@@ -142,7 +142,11 @@ if [ "$CONFIG_NET_ETHERNET" = "y" ]; the
       tristate '  NE/2 (ne2000 MCA version) support' CONFIG_NE2_MCA
       tristate '  IBM LAN Adapter/A support' CONFIG_IBMLANA
    fi
-   dep_bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI
+   if [ "$CONFIG_ISA" = "y" -o "$CONFIG_EISA" = "y" -o "$CONFIG_PCI" = "y" ]; then
+     bool '  EISA, VLB, PCI and on board controllers' CONFIG_NET_PCI
+   else
+     define_bool CONFIG_NET_PCI n
+   fi
    if [ "$CONFIG_NET_PCI" = "y" ]; then
       dep_tristate '    AMD PCnet32 PCI support' CONFIG_PCNET32 $CONFIG_PCI
       dep_tristate '    Adaptec Starfire support (EXPERIMENTAL)' CONFIG_ADAPTEC_STARFIRE $CONFIG_PCI $CONFIG_EXPERIMENTAL

