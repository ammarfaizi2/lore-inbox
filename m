Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbUCDNxi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 08:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUCDNwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 08:52:04 -0500
Received: from pxy4allmi.all.mi.charter.com ([24.247.15.43]:15518 "EHLO
	proxy4.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S261905AbUCDNve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:51:34 -0500
Message-ID: <40473461.80105@quark.didntduck.org>
Date: Thu, 04 Mar 2004 08:51:29 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3: PnPBIOS hangs with S875WP1 BIOS
References: <Pine.GSO.4.44.0403040920480.2398-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0403040920480.2398-100000@math.ut.ee>
Content-Type: multipart/mixed;
 boundary="------------000607090600080107080108"
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000607090600080107080108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Meelis Roos wrote:
> I run a 2.6.3 kernel on Intel S875WP1 mainboard. When I enable PnPBIOS
> in kernel config, the kernel gets general protection fault 0 just after
> telling it found PnP BIOS. No backtrace. Disabling PnPBIOS in kernel
> works around the problem.
> 

Try this patch

--
				Brian Gerst

--------------000607090600080107080108
Content-Type: text/plain;
 name="pnpsegs-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnpsegs-1"

diff -urN linux-bk/arch/i386/mm/extable.c linux/arch/i386/mm/extable.c
--- linux-bk/arch/i386/mm/extable.c	2004-02-15 00:41:41.000000000 -0500
+++ linux/arch/i386/mm/extable.c	2004-03-04 08:42:12.169000128 -0500
@@ -12,7 +12,7 @@
 	const struct exception_table_entry *fixup;
 
 #ifdef CONFIG_PNPBIOS
-	if (unlikely((regs->xcs | 8) == 0x88)) /* 0x80 or 0x88 */
+	if (unlikely((regs->xcs & ~15) == (GDT_ENTRY_PNPBIOS_BASE << 3)))
 	{
 		extern u32 pnp_bios_fault_eip, pnp_bios_fault_esp;
 		extern u32 pnp_bios_is_utter_crap;

--------------000607090600080107080108--
