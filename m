Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932737AbVHSWmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbVHSWmj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 18:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbVHSWmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 18:42:39 -0400
Received: from smtp-2.llnl.gov ([128.115.250.82]:36589 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S932737AbVHSWmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 18:42:38 -0400
Date: Fri, 19 Aug 2005 15:42:27 -0700 (PDT)
From: Chuck Harding <charding@llnl.gov>
Subject: Re: 2.6.13-rc6-rt9
In-reply-to: <200508191241.39340.annabellesgarden@yahoo.de>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.63.0508191541350.5383@ghostwheel.llnl.gov>
Organization: Lawrence Livermore National Laboratory
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Pine/4.62 (X11; U; Linux i686; en-US; rv:2.6.11-rc2-mm1)
References: <200508191241.39340.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sure did. At least on a normal reboot. I will try
SysRq+B and see what happens. Thanks.

On Fri, 19 Aug 2005, Karsten Wiese wrote:

> Chuck wrote:
>> I'm still getting the same oops when rebooting. the same process (reboot)
>> similar call trace (some addresses are slightly different but the functions
>> are the same:
>> disable_IO_APIC+0x5a/0x90 (8)
>> machine_restart+0x5/0x9 (28)
>> sys_reboot+0x147/0x156 (4)
>> netdev_run_todo+0xa4/0x209 (4)
>> etc.
>
> Does this patch help?
>
> ------
> diff -up arch/i386/kernel/io_apic.c.rt9 arch/i386/kernel/io_apic.c
> --- arch/i386/kernel/io_apic.c.rt9      2005-08-19 12:28:42.000000000 +0200
> +++ arch/i386/kernel/io_apic.c  2005-08-19 12:29:30.000000000 +0200
> @@ -1758,8 +1758,8 @@ void disable_IO_APIC(void)
>                 * Add it to the IO-APIC irq-routing table:
>                 */
>                spin_lock_irqsave(&ioapic_lock, flags);
> -               io_apic_write(0, 0x11+2*pin, *(((int *)&entry)+1));
> -               io_apic_write(0, 0x10+2*pin, *(((int *)&entry)+0));
> +               io_apic_write(ioapic_data[0], 0x11+2*pin, *(((int *)&entry)+1));
> +               io_apic_write(ioapic_data[0], 0x10+2*pin, *(((int *)&entry)+0));
>                spin_unlock_irqrestore(&ioapic_lock, flags);
>        }
>        disconnect_bsp_APIC(pin != -1);
> ------
>
>   Karsten
>
>
>
>
>
> ___________________________________________________________
> Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
Charles D. (Chuck) Harding <charding@llnl.gov>  Voice: 925-423-8879
Senior Computer Associate         ICCD            Fax: 925-423-6961
Lawrence Livermore National Laboratory      Computation Directorate
Livermore, CA USA  http://www.llnl.gov  GPG Public Key ID: B9EB6601
------------------ http://tinyurl.com/5w5ey -----------------------
-- The Lab called... Your brain is ready! --
