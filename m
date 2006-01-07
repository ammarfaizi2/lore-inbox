Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbWAGAoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWAGAoF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWAGAoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:44:05 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:49271 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030240AbWAGAoD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:44:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jyjjvy75s5T0FjlY8yrK7Qz4fJR6ag3VjiOWvAnd+OmsXG6RFGJlQYoAHKhItBcvVIG2HSsE1Q0pBSQKIiMWqTladSyJVSSAdJ2PmUx1rgx/gXTU9KPPWmiEbn9/A6teIvO+9xScHYMhsRm9dSRayHkCwYFNdV60rKRsz1qGroY=
Message-ID: <86802c440601061644s18813b1dj25f2b49f3a46a867@mail.gmail.com>
Date: Fri, 6 Jan 2006 16:44:02 -0800
From: Yinghai Lu <yinghai.lu@amd.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86_64 io_apic: memorize at bootup where the i8259 is
Cc: Andrew Morton <akpm@osdl.org>, vgoyal@in.ibm.com, ak@muc.de,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, linuxbios@openbios.org
In-Reply-To: <m1wthd4vjg.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060103044632.GA4969@in.ibm.com>
	 <86802c440601051630i4d52aa2fj1a2990acf858cd63@mail.gmail.com>
	 <20060105163848.3275a220.akpm@osdl.org>
	 <m1wthd4vjg.fsf_-_@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>@@ -1249,12 +1313,14 @@ void disable_IO_APIC(void)
>                * Add it to the IO-APIC irq-routing table:
>                */
>               spin_lock_irqsave(&ioapic_lock, flags);
>-               io_apic_write(0, 0x11+2*pin, *(((int *)&entry)+1));
>-               io_apic_write(0, 0x10+2*pin, *(((int *)&entry)+0));
>+               io_apic_write(ioapic_i8259.apic, 0x11+2*ioapic_i8259.pin,
>+                       *(((int *)&entry)+1));
>+               io_apic_write(ioapic_i8259.apic, 0x10+2*ioapic_i8259.pin,
>+                       *(((int *)&entry)+1));
>               spin_unlock_irqrestore(&ioapic_lock, flags);
>       }
>
>-       disconnect_bsp_APIC(pin != -1);
>+       disconnect_bsp_APIC(ioapci_i8259.pin != -1);
> }

There is a typo

+               io_apic_write(ioapic_i8259.apic, 0x10+2*ioapic_i8259.pin,
+                       *(((int *)&entry)+1));

===>

+               io_apic_write(ioapic_i8259.apic, 0x10+2*ioapic_i8259.pin,
+                       *(((int *)&entry)+0));

YH
