Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268487AbUJOVrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268487AbUJOVrm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 17:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268497AbUJOVrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 17:47:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:44206 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268487AbUJOVrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 17:47:23 -0400
Date: Fri, 15 Oct 2004 14:45:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: "H. J. Lu" <hjl@lucon.org>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: 2.6.9 kexec patch causes kernel panic during reboot on x86-64
Message-Id: <20041015144528.2556d00c.akpm@osdl.org>
In-Reply-To: <20041015214013.GA6555@lucon.org>
References: <20041015214013.GA6555@lucon.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. J. Lu" <hjl@lucon.org> wrote:
>
> 2.6.9 kexec patch adds a call to find_isa_irq_pin in disable_IO_APIC.
>  But find_isa_irq_pin is marked __init on x86-64, which leads to
>  kernel panic. This patch should fix it.
> 
> 
>  H.J.
>  --- linux-2.6.8/arch/x86_64/kernel/io_apic.c.init	2004-10-14 16:21:44.000000000 -0700
>  +++ linux-2.6.8/arch/x86_64/kernel/io_apic.c	2004-10-15 14:34:53.615495099 -0700
>  @@ -332,7 +332,7 @@ static int __init find_irq_entry(int api
>   /*
>    * Find the pin to which IRQ[irq] (ISA) is connected
>    */
>  -static int __init find_isa_irq_pin(int irq, int type)
>  +static int find_isa_irq_pin(int irq, int type)
>   {

Yup, there are several such fixups needed.  See
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/assign_irq_vector-section-fix.patch.

If you're testing kexec you might be better off using 2.6.9-rc4-mm1 (minus
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/optimize-profile-path-slightly.patch)
because it has the latest kexec version (it had better be!) and whatever
fixups people have found against it.

