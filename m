Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbUBHIWP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 03:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbUBHIWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 03:22:15 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:45828 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262838AbUBHIWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 03:22:14 -0500
Date: Sun, 8 Feb 2004 09:20:59 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Len Brown <len.brown@intel.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BKPATCH] ACPI for 2.4
Message-ID: <20040208082059.GD29363@alpha.home.local>
References: <1076145024.8687.32.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076145024.8687.32.camel@dhcppc4>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,

On Sat, Feb 07, 2004 at 04:10:24AM -0500, Len Brown wrote:
> 	bk pull http://linux-acpi.bkbits.net/linux-acpi-release-2.4.25
> 
> 	the AML param fix is in 2.6 -- the others changes
> 	are Asus and Toshiba model specific.

I encountered something strange that I still cannot explain. I have two
machines, one athlon-based VAIO notebook and one P4-based supermicro 1U
server, which don't poweroff when I halt them or send them a Sysrq-O. At
first, I only noticed this on the VAIO so I thought that something changed
in ACPI recently, because it was OK around 2.4.21 or 2.4.22 with acpi patch
from around 09/2003, but I believe that the problem appeared when I used
2.4.23 + the acpi-20031203 patch, which is now included in 2.4.25-rc1. But
then I discovered that I can poweroff both the notebook and the 1U by a
simple "echo 5 >/proc/acpi/sleep".

So I've added printk's into acpi_power_off(), and I see that the system
doesn't return from acpi_enter_sleep_state_prep(S5), which itself hangs
on the call to acpi_evaluate_object(NULL, "\\_PTS",...). If I comment
out this line, it now goes on through the next calls, then normally leaves
acpi_enter_sleep_state_prep(), then powers off correctly. I have not tested
yet you very latest patch, but I don't think it would change anything.

Do you have any idea ? What can I provide to help in resolving this problem ?

Regards,
Willy

