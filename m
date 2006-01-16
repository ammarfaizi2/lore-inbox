Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWAPKhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWAPKhS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 05:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWAPKhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 05:37:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36022 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932322AbWAPKhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 05:37:17 -0500
Date: Mon, 16 Jan 2006 02:36:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Gerrit Visser" <g.visser@msc-africa.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Net: e1000 driver: TX Hang message
Message-Id: <20060116023644.3b567f30.akpm@osdl.org>
In-Reply-To: <C086BA41F8EFC942B7BBBCF09CC95D210E7634@svr.msc-africa.co.za>
References: <C086BA41F8EFC942B7BBBCF09CC95D210E7634@svr.msc-africa.co.za>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If this bug is still present in 2.6.15 could you please create a report
(against 2.6.15) at bugzilla.kenrel.org?

Thanks.

"Gerrit Visser" <g.visser@msc-africa.co.za> wrote:
>
> Hi,
> 
> I've got a DELL precision 670 that has an Intel Gigabit Ethernet onboard
> NIC (82545GM chipset). It receives packets but keeps on giving "Tx hang"
> messages and doesn't send any packets.
> 
> Both standard Redhat WS4 (kernel 2.6.9) and kernel 2.6.13.2 did the
> same.
> 
> To fix it, I've changed the following in the file e1000_hw.c:
> 
>     case E1000_DEV_ID_82545GM_COPPER:
>     case E1000_DEV_ID_82545GM_FIBER:
>     case E1000_DEV_ID_82545GM_SERDES:
>         hw->mac_type = e1000_82545_rev_3;
>         break;
> 
> to
> 
>     case E1000_DEV_ID_82545GM_COPPER:
>     case E1000_DEV_ID_82545GM_FIBER:
>     case E1000_DEV_ID_82545GM_SERDES:
>         hw->mac_type = e1000_82545;
>         break;
> 
> (ie. removed the "_rev_3")
> 
> I'm not certain whether it's necessary to change this for copper, fiber
> and serdes. Mine is a copper (pci id 1026).
> 
> This worked for the Linux e1000 driver from Intel's website, but exactly
> the same piece of code is in the 2.6.13.2 kernel's e1000 driver.
> 
> Best regards,
> Gerrit
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
