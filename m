Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWIMP0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWIMP0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 11:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWIMP0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 11:26:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:58097 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750929AbWIMP0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 11:26:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kQfJrIEyssR7ekbZkU7BpOhnoEdhRyPQFCbt5QJNocmke/CUQZkT8+Rsb23/kEFSr6gJWrA3MHO26R7xcvpS+OP3Lp2TcS7iV1nLp/QCLeiQtJsOC1yyoSi0EqswQ+u2L31c/HFb+Cnbroq06WB1mOt+TDo+PC6Yzn1UTnploWU=
Message-ID: <a2ebde260609130826u12a82ffy2c71dd5ec7c4f6bd@mail.gmail.com>
Date: Wed, 13 Sep 2006 23:26:50 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
To: "Andi Kleen" <ak@suse.de>, liqiang@nortel.com,
       "=?GB2312?B?wO7Hvw==?=" <victor.liqiang@gmail.com>
Subject: Question on The Timer Interrupt Dispatch
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One question confuses me for quiet a while about the initialization of
the IO APIC.

For my understanding, in i386 architecture, the timer interrupts are
dispatched among every CPU in a roughly round-robin fashion
*immediately* (or reasonably short) after the IO APIC has been
initialized and a secondary CPU has enabled its local IRQ. Turning to
code, I suppose the first condition should be met by [init() ->
smp_prepare_cpus() -> smp_boot_cpus() -> smpboot_setup_io_apic() ->
setup_IO_APIC()], and the second condition should be met by [
start_secondary() -> local_irq_enable() ].

I tried to confirm my guess by tracing the initialization code
execution on my Dual-core laptop . However, I get very confusing
result. While both the conditions had just been met as described
above, CPU 0 has handled about 70 ticks (i.e. timer interrupt) and CPU
1 has handled 0 tick. I expected CPU 1 would get its first timer
interrupt after few ticks. But the fact is that CPU 1 has not been
interrupted by timer until CPU 0 has handled over 7000 ticks. Since
CPU 1 gets the first interrupt, the subsequent timer interrupts are
distributed on both CPU roughly equally.

I still can not find any explanation myself for the gap between my
presumption and the result from code tracing. According to the
presumption, CPU 1 should get the first interrupt while CPU 0 handles
70 ticks, but CPU 1 does not until CPU 0 handles over 7000 ticks.
Could you please pointed out which part I missed in my understanding?

Thanks.
