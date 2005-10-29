Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbVJ2Onz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbVJ2Onz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 10:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbVJ2Onz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 10:43:55 -0400
Received: from sccrmhc13.comcast.net ([63.240.77.83]:3512 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751167AbVJ2Ony (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 10:43:54 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Roland Dreier <rolandd@cisco.com>
Subject: Re: [PATCH] toshiba_ohci1394_dmi_table should be __devinitdata, not __devinit
Date: Sat, 29 Oct 2005 07:43:59 -0700
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, gregkh@suse.de
References: <52fyqlorj8.fsf@cisco.com>
In-Reply-To: <52fyqlorj8.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wq4YD9Ysrrvpqky"
Message-Id: <200510290744.00642.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_wq4YD9Ysrrvpqky
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday, October 28, 2005 9:50 pm, Roland Dreier wrote:
> I don't really understand why gcc gives the error it does, but
> without this patch, when building with CONFIG_HOTPLUG=n, I get errors
> like:
>
>       CC      arch/x86_64/pci/../../i386/pci/fixup.o
>     arch/x86_64/pci/../../i386/pci/fixup.c: In function
> `pci_fixup_i450nx': arch/x86_64/pci/../../i386/pci/fixup.c:13: error:
> pci_fixup_i450nx causes a section type conflict
>
> The change is obviously correct: an array should be declared
> __devinitdata rather that __devinit.

Oops, yeah I think this is correct.  We should also mark 
toshiba_line_size as __devinitdata.  Patch relative to yours.

Thanks,
Jesse

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

--Boundary-00=_wq4YD9Ysrrvpqky
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="toshiba-quirk-devinitdata.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="toshiba-quirk-devinitdata.patch"

--- linux-2.6.14/arch/i386/pci/fixup.c.orig	2005-10-29 07:42:46.000000000 -0700
+++ linux-2.6.14/arch/i386/pci/fixup.c	2005-10-29 07:42:06.000000000 -0700
@@ -396,7 +396,7 @@
  * the wrong IRQ line, causing any devices sharing the the line it's
  * *supposed* to use to be disabled by the kernel's IRQ debug code.
  */
-static u16 toshiba_line_size;
+static u16 __devinitdata toshiba_line_size;
 
 static struct dmi_system_id __devinitdata toshiba_ohci1394_dmi_table[] = {
 	{

--Boundary-00=_wq4YD9Ysrrvpqky--
