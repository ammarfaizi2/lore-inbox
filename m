Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753460AbWKCSzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbWKCSzz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 13:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753466AbWKCSzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 13:55:55 -0500
Received: from web38411.mail.mud.yahoo.com ([209.191.125.42]:9601 "HELO
	web38411.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1753460AbWKCSzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 13:55:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ad280rwmLctxIBb4K1yfrY4cXI8L+37qwO6zqulGWJO8z5ytedUCsJz/wrEJm4kbCBdH0AoDQHAx0uW4RtOMECu/C/njOkCa/Kvs6XxNwqjQK1LyXxa3D1jAarGxk3LY3ygVKVR6XnJFFPzWckAnJO7jJXMcEim1qFReFjzYJhM=  ;
Message-ID: <20061103185554.92453.qmail@web38411.mail.mud.yahoo.com>
Date: Fri, 3 Nov 2006 10:55:54 -0800 (PST)
From: xp newbie <xp_newbie@yahoo.com>
Subject: Re: irqpoll kernel option hurts performance?
To: linux-kernel@vger.kernel.org
In-Reply-To: <1162569659.12810.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> The two systems don't measure performance the same
> way. That makes
> comparisons using their own monitoring tools a bit
> dubious and can make
> either OS look better in cases where it isn't

OK, but in this case Linux kernel itself tells me that
something is wrong (via the demsg log). So I am trying
to optimize the system *before* intalling the tons of
tools that I need and discovering later that I may
have  use the incorrect boot option during
installation, requiring me to re-install again.

> I wish I knew. One possibility - especially as this
> appears to be the
> USB 2.0 is that it provides different rules for
> different OS's (thats
> intended to be a feature so it can hide EHCI from
> old windows etc)
> 
> You might want to see if booting with the kernel
> option	"acpi_noirq" has
> any effect for the better, you can also spoof

I just tried that:

Once replacing the 'irqpoll' option (which froze boot
completely, sending tons of lines of the following
error message:

[17179576.748000] hda: cdrom_pc_intr: The drive
appears confused (ireason = 0x01)

And only a hard reset could get me out of there...

The second trial was appending acpi_noirq to the boot
options (i.e. in addition to 'irqpoll') and this time,
it booted. However, demsg still shows that something
is wrong with the system:

[17179569.184000] Kernel command line: root=/dev/sda3
ro quiet splash irqpoll acpi_noirq
[17179569.184000] Misrouted IRQ fixup and polling
support enabled
[17179569.184000] This may significantly impact system
performance
[17179569.184000] mapped APIC to ffffd000 (fee00000)
[17179569.184000] mapped IOAPIC to ffffc000 (fec00000)

But a few lines later:

[17179577.600000] irq 177: nobody cared (try booting
with the "irqpoll" option)
[17179577.600000]  [<c014fc8a>]
__report_bad_irq+0x2a/0xa0
[17179577.600000]  [<c014fda7>]
note_interrupt+0x87/0xf0
[17179577.600000]  [<c014f57d>] __do_IRQ+0xfd/0x110
[17179577.600000]  [<c0105c79>] do_IRQ+0x19/0x30
[17179577.600000]  [<c0103eb6>]
common_interrupt+0x1a/0x20
[17179577.600000]  [<c014f428>]
handle_IRQ_event+0x18/0x70
[17179577.600000]  [<c014fde6>]
note_interrupt+0xc6/0xf0
[17179577.600000]  [<c014f51d>] __do_IRQ+0x9d/0x110
[17179577.600000]  [<c0105c79>] do_IRQ+0x19/0x30
[17179577.600000]  [<c0103eb6>]
common_interrupt+0x1a/0x20
[17179577.600000]  [<c01fd0a9>] vsnprintf+0x499/0x640
[17179577.600000]  [<f88f9000>] handshake+0x0/0x60
[ehci_hcd]
[17179577.600000]  [<c01994e8>] seq_printf+0x38/0x60
[17179577.600000]  [<c0146404>] m_show+0x44/0xc0
[17179577.600000]  [<c0198fef>] seq_read+0x28f/0x2f0
[17179577.600000]  [<c0173ea6>] vfs_read+0xd6/0x1b0
[17179577.600000]  [<c01742ab>] sys_read+0x4b/0x80
[17179577.600000]  [<c0103471>] syscall_call+0x7/0xb
[17179577.600000] handlers:
[17179577.600000] [<c02737f0>] (ide_intr+0x0/0x1f0)
[17179577.600000] [<c02737f0>] (ide_intr+0x0/0x1f0)
[17179577.600000] [<f891f1c0>] (usb_hcd_irq+0x0/0x70
[usbcore])
[17179577.600000] Disabling IRQ #177

And my question is: if the kernel recognizes that the
irqpoll options has been specified, why does it say
"(try booting with the irqpoll option"?

Could this be a kernel bug?

Thanks,
Alex


 
____________________________________________________________________________________
We have the perfect Group for you. Check out the handy changes to Yahoo! Groups 
(http://groups.yahoo.com)

