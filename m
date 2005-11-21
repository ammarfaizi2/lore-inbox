Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbVKUH1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVKUH1z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 02:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbVKUH1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 02:27:55 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:29372 "EHLO
	mail.intellilink.co.jp") by vger.kernel.org with ESMTP
	id S1751003AbVKUH1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 02:27:54 -0500
Subject: Re: [Fastboot] kdump's dump capture kernel fails (APICs &
	linux-2.6.15-rc1)
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: ebiederm@xmission.com
Cc: akpm@osdl.org, fastboot@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1132501594.2432.132.camel@localhost.localdomain>
References: <1132501594.2432.132.camel@localhost.localdomain>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A?= =?UTF-8?Q?=E7=A4=BE?=
Date: Mon, 21 Nov 2005 16:24:03 +0900
Message-Id: <1132557843.4806.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 00:46 +0900, Fernando Luis Vazquez Cao wrote:
> Hi Eric,
> 
> It seems there are still some problems with the initialization of the
> APICs in the second kernel. As you can see from the serial line captures
> below, early during the boot process the kernel is flooded with
> "unexpected IRQ trap at vector ##" errors and fails to boot.
> 
> Some basic details about the machine:
>  - Dual Xeon Hyper-Threading 2.4GHz 
>  - 1GB RAM
> 
> In this particular machine the problem could be solved by reintroducing
> the APICs shutdown patch. The drawback with this approach is that
> LAPIC/IOAPIC registers setup for the legacy PIC mode differs a lot
> between mother boards and the somewhat hackish shutdown code fails to
> set the APICs properly under certain configurations.

I have just realized that the "move apic init in init_IRQs" patches by
Eric were reverted back. Besides, APICs shutdown code made it back into
linux-2.6.15-rc2.
This is a desirable stopgap solution that will solve the problem for
some machines and configurations.

Anyway, up to now, the "LAPIC/IO-APIC save/restore" solution is the only
one that has worked reliably for us (even with badly broken BIOSes).

I will test Eric's patches and report the results.

Regards,

Fernando

