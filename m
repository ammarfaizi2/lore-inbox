Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130335AbRA2XgP>; Mon, 29 Jan 2001 18:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130599AbRA2XgF>; Mon, 29 Jan 2001 18:36:05 -0500
Received: from h24-67-108-36.cg.shawcable.net ([24.67.108.36]:384 "EHLO
	ogah.cgma1.ab.wave.home.com") by vger.kernel.org with ESMTP
	id <S130335AbRA2Xfz>; Mon, 29 Jan 2001 18:35:55 -0500
Date: Mon, 29 Jan 2001 16:33:21 -0700
From: Harold Oga <ogah@home.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.1-pre11
Message-ID: <20010129163321.B642@ogah.cgma1.ab.wave.home.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101281020540.3850-100000@penguin.transmeta.com> <E14NB8r-000063-00@roos.tartu-labor> <20010129032637.A642@ogah.cgma1.ab.wave.home.com> <87g0i2lj9r.fsf@ondrej.office.globe.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87g0i2lj9r.fsf@ondrej.office.globe.cz>; from ondrej@globe.cz on Mon, Jan 29, 2001 at 11:55:44AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2001 at 11:55:44AM +0100, Ondrej Sury wrote:
>Harold Oga <ogah@home.com> writes:
>
>> Hi,
>>    I'm seeing similar problems with my system on 2.4.1-pre10.  This is an
>> AMD Thunderbird 900, MSI K7T Pro2-A mobo w/VIA KT133 chipset, UP, ide/scsi
>> mix.  2.4.1-pre10 works fine if I don't configure ACPI.  I'll try to
>> narrow down when this problem started showing up later today, as I
>> initially moved from 2.4.1-pre3 straight to 2.4.1-pre10.
>
>It's something between pre9 and pre10, and probably it's VIA chipset
>problem.
Hi,
   Ok, it appears that I have 2.4.1-pre10 working properly again.  Looks
like the changes Andy made to the acpi_idle stuff was the problem.  I made
the change Andy suggested on the acpi list, namely commenting out the line
"pm_idle = acpi_idle;" at the bottom of /usr/src/linux/drivers/acpi/cpu.c,
which seems to fix the problem.

This patch makes it clear what I did:
--- linux/drivers/acpi/cpu.c.orig       Mon Jan 29 15:19:21 2001
+++ linux/drivers/acpi/cpu.c    Mon Jan 29 15:22:14 2001
@@ -329,12 +329,5 @@
        acpi_pm_timer_init();


-#ifdef CONFIG_SMP
-       if (smp_num_cpus == 1)
-               pm_idle = acpi_idle;
-#else
-       pm_idle = acpi_idle;
-#endif
-
        return 0;
 }

-Harold  
-- 
"Life sucks, deal with it!"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
