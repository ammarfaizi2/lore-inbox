Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266010AbRF2NdJ>; Fri, 29 Jun 2001 09:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266021AbRF2Nc7>; Fri, 29 Jun 2001 09:32:59 -0400
Received: from spc2.esa.lanl.gov ([128.165.67.191]:42880 "HELO
	spc2.esa.lanl.gov") by vger.kernel.org with SMTP id <S266010AbRF2Ncq>;
	Fri, 29 Jun 2001 09:32:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
To: Keith Owens <kaos@ocs.com.au>, scole@lanl.gov
Subject: Re: 2.4.5-ac20 problems with drivers/net/Config.in and make xconfig
Date: Fri, 29 Jun 2001 07:31:15 -0600
X-Mailer: KMail [version 1.2]
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <16590.993781130@ocs3.ocs-net>
In-Reply-To: <16590.993781130@ocs3.ocs-net>
MIME-Version: 1.0
Message-Id: <01062907311500.01279@spc2.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 June 2001 20:18, Keith Owens wrote:
> On Thu, 28 Jun 2001 10:05:58 -0600,
>
> Steven Cole <scole@lanl.gov> wrote:
> >[root@spc linux]# make xconfig
> >./tkparse < ../arch/i386/config.in >> kconfig.tk
> >make[1]: *** [kconfig.tk] Error 139
> >make[1]: Leaving directory `/usr/src/linux-2.4.5-ac20/scripts'
>
> Sigh.  I wish people making big changes to config files would check
> that the change works for all the variants of make *config.
>
> Index: 5.52/drivers/net/Config.in
> --- 5.52/drivers/net/Config.in Fri, 29 Jun 2001 11:39:55 +1000 kaos
> (linux-2.4/l/c/9_Config.in 1.1.2.2.1.4.1.12 644) +++
> 5.52(w)/drivers/net/Config.in Fri, 29 Jun 2001 12:14:23 +1000 kaos
> (linux-2.4/l/c/9_Config.in 1.1.2.2.1.4.1.12 644) @@ -16,7 +16,7 @@ if [
> "$CONFIG_EXPERIMENTAL" = "y" ]; the
>  fi
>
>  if [ "$CONFIG_ISAPNP" = "y" ]; then
> -   tristate 'General Instruments Surfboard 1000' CONFIG_NET_SB1000
> $CONFIG_ISAPNP +   tristate 'General Instruments Surfboard 1000'
> CONFIG_NET_SB1000 fi
>
>  #
> @@ -204,7 +204,6 @@ bool 'Ethernet (10 or 100Mbit)' CONFIG_N
>        dep_tristate '    D-Link DE600 pocket adapter support' CONFIG_DE600
> $CONFIG_ISA dep_tristate '    D-Link DE620 pocket adapter support'
> CONFIG_DE620 $CONFIG_ISA fi
> -fi
>
>  endmenu

Here is a variant of Keith's patch.  The free-floating "fi" at line 207 was the result
of a deleted line "if [ "$CONFIG_NET_ETHERNET" = "y" ]; then".  The indentation
was the major clue.  This patch was made against 2.4.5-ac21.
Steven

--- linux/drivers/net/Config.in.original        Fri Jun 29 07:17:57 2001
+++ linux/drivers/net/Config.in Fri Jun 29 07:23:02 2001
@@ -16,7 +16,7 @@
 fi
 
 if [ "$CONFIG_ISAPNP" = "y" ]; then
-   tristate 'General Instruments Surfboard 1000' CONFIG_NET_SB1000 $CONFIG_ISAPNP
+   tristate 'General Instruments Surfboard 1000' CONFIG_NET_SB1000
 fi
 
 #
@@ -27,6 +27,7 @@
 comment 'Ethernet (10 or 100Mbit)'
 
 bool 'Ethernet (10 or 100Mbit)' CONFIG_NET_ETHERNET
+if [ "$CONFIG_NET_ETHERNET" = "y" ]; then
    if [ "$CONFIG_ARM" = "y" ]; then  
       dep_bool '  ARM EBSA110 AM79C961A support' CONFIG_ARM_AM79C961A $CONFIG_ARCH_EBSA110
       if [ "$CONFIG_ARCH_ACORN" = "y" ]; then
