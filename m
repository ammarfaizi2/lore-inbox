Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWIUTEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWIUTEO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 15:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWIUTEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 15:04:14 -0400
Received: from slimak.dkm.cz ([62.24.64.34]:57340 "HELO slimak.dkm.cz")
	by vger.kernel.org with SMTP id S1750859AbWIUTEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 15:04:13 -0400
Date: Thu, 21 Sep 2006 21:03:46 +0200
From: iSteve <isteve@rulez.cz>
To: Sergey Vlasov <vsu@altlinux.ru>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: broken modules.alias entries for some USB devices
Message-ID: <20060921210346.1a59666b@silver>
In-Reply-To: <20060921223035.c5fda02d.vsu@altlinux.ru>
References: <20060920185301.21dcf9bc@silver>
	<20060920102248.ebb55960.rdunlap@xenotime.net>
	<20060921165424.139138e5@silver>
	<20060921223035.c5fda02d.vsu@altlinux.ru>
X-Mailer: Sylpheed-Claws 2.4.0cvs175 (GTK+ 2.10.1; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 22:30:35 +0400
Sergey Vlasov <vsu@altlinux.ru> wrote:
> The problem is that the bcdDevice field is supposed to be BCD - i.e.,
> its hex representation should contain only decimal digits 0..9.
> Therefore a proper USB device cannot have bcdDevice == 0x030a.
> Apparently some ibmcam devices violate this and use the bcdDevice field
> as if it was binary.
> 
> The code in scripts/mod/file2alias.c assumes that the bcdDevice_lo and
> bcdDevice_hi field contain proper BCD data.  Seems that, thanks to buggy
> hardware, this assumption is incorrect, and the code needs to support
> any hex numbers there.

So the 'correct' alias for this device should be eg.:
usb:v0545p800Dd030Adc*dsc*dp*ic*isc*ip*
right?

Given this new info... what if _lo is 0x030a and _hi is 0x030f? How would the
alias look like? Or worse, what if _lo is 0x030a and _hi is 0x040a?

Would these be correct?
usb:v0545p800Dd030[A-F]dc*dsc*dp*ic*isc*ip*
usb:v0545p800Dd0[30A-40A]dc*dsc*dp*ic*isc*ip*

Thanks in advance.
-- 
 -- iSteve
