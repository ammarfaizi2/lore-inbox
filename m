Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270529AbRHNIu7>; Tue, 14 Aug 2001 04:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270530AbRHNIus>; Tue, 14 Aug 2001 04:50:48 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:6886 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S270529AbRHNIue>; Tue, 14 Aug 2001 04:50:34 -0400
Message-ID: <3B78E6AF.449B903B@kernelconcepts.de>
Date: Tue, 14 Aug 2001 10:51:59 +0200
From: Nils Faerber <nils@kernelconcepts.de>
Organization: kernel concepts
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix 2.4.8 compile errors
In-Reply-To: <100C620A6B75@coral.indstate.edu>
Content-Type: multipart/mixed;
 boundary="------------578D88907F7F2F4D93426DC5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------578D88907F7F2F4D93426DC5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Rich Baum wrote:
> This patch fixes two compile errors I get when compiling 2.4.8 on my K6-2.
> Both of these errors are caused by compiling drivers for other architectures.
>  I've changed the Config.in files to keep these options from being selected
> on the wrong architecture.

The first hunk seems OK to me but the second one is a little crude.
There are also other architectures that use the Epson 1355 framebuffer;
we had for example a MIPS reference design from Toshiba here that had
that one. Limiting this to just SH architecture goes a little too far.

> Let me know if you have any questions about this patch.
> Rich
CU
  nils

> diff -urN -X dontdiff linux-2.4.8/drivers/net/Config.in
> rb/drivers/net/Config.in
> --- linux-2.4.8/drivers/net/Config.in   Sat Aug 11 11:10:07 2001
> +++ rb/drivers/net/Config.in    Mon Aug 13 20:43:41 2001
> @@ -28,7 +28,8 @@
> 
>  bool 'Ethernet (10 or 100Mbit)' CONFIG_NET_ETHERNET
>  if [ "$CONFIG_NET_ETHERNET" = "y" ]; then
> -   dep_bool '  ARM EBSA110 AM79C961A support' CONFIG_ARM_AM79C961A
> $CONFIG_ARCH_EBSA110
> +   if [ "$ARCH" = "arm" ]; then
> +      dep_bool '  ARM EBSA110 AM79C961A support' CONFIG_ARM_AM79C961A
> $CONFIG_ARCH_EBSA110
>     if [ "$CONFIG_ARCH_ACORN" = "y" ]; then
>        source drivers/acorn/net/Config.in
>     fi
> diff -urN -X dontdiff linux-2.4.8/drivers/video/Config.in
> rb/drivers/video/Config.in
> --- linux-2.4.8/drivers/video/Config.in Sat Aug 11 11:10:30 2001
> +++ rb/drivers/video/Config.in  Mon Aug 13 20:43:46 2001
> @@ -103,7 +103,8 @@
>     fi
>     tristate '  NEC PowerVR 2 display support' CONFIG_FB_PVR2
>     dep_bool '    Debug pvr2fb' CONFIG_FB_PVR2_DEBUG $CONFIG_FB_PVR2
> -   bool '  Epson 1355 framebuffer support' CONFIG_FB_E1355
> +   if [ "$ARCH" = "sh" ]; then
> +      bool '  Epson 1355 framebuffer support' CONFIG_FB_E1355
>     if [ "$CONFIG_FB_E1355" = "y" ]; then
>        hex '    Register Base Address' CONFIG_E1355_REG_BASE a8000000
>        hex '    Framebuffer Base Address' CONFIG_E1355_FB_BASE a8200000
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          D1 : +49-170-2729106
--
--------------578D88907F7F2F4D93426DC5
Content-Type: text/x-vcard; charset=us-ascii;
 name="nils.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Nils Faerber
Content-Disposition: attachment;
 filename="nils.vcf"

begin:vcard 
n:Faerber;Nils
tel;cell:+49-170-2729106
tel;fax:+49-271-771091-19
tel;work:+49-271-771091-12
x-mozilla-html:FALSE
url:http://www.kernelconcepts.de
org:kernel concepts
adr:;;Dreisbachstrasse 24;Netphen;;57250;Germany
version:2.1
email;internet:nils@kernelconcepts.de
x-mozilla-cpt:;0
fn:Nils Faerber
end:vcard

--------------578D88907F7F2F4D93426DC5--

