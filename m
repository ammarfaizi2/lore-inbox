Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265526AbVBFIx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265526AbVBFIx5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 03:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbVBFIx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 03:53:57 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:17844 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S272784AbVBFIxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 03:53:11 -0500
Subject: Re: [PATCH] Dynamic tick, version 050127-1
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20050206081137.GA994@elf.ucw.cz>
References: <20050201204008.GD14274@atomide.com>
	 <20050201212542.GA3691@openzaurus.ucw.cz>
	 <20050201230357.GH14274@atomide.com> <20050202141105.GA1316@elf.ucw.cz>
	 <20050203030359.GL13984@atomide.com> <20050203105647.GA1369@elf.ucw.cz>
	 <20050203164331.GE14325@atomide.com> <20050204051929.GO14325@atomide.com>
	 <20050205230017.GA1070@elf.ucw.cz> <20050206023344.GA15853@atomide.com>
	 <20050206081137.GA994@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 06 Feb 2005 03:53:09 -0500
Message-Id: <1107679990.3532.37.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-06 at 09:11 +0100, Pavel Machek wrote:
> I do have CONFIG_X86_PM_TIMER enabled, but it seems by board does not
> have such piece of hardware:
> 
> pavel@amd:/usr/src/linux-mm$ dmesg | grep -i "time\|tick\|apic"
> PCI: Setting latency timer of device 0000:00:11.5 to 64
> pavel@amd:/usr/src/linux-mm$ 

If you are sure that machine supports ACPI, maybe this is your problem
(from the POSIX high res timer patch):

          If you enable the ACPI pm timer and it cannot be found, it is
          possible that your BIOS is not producing the ACPI table or
          that your machine does not support ACPI.  In the former case,
          see "Default ACPI pm timer address".  If the timer is not
          found the boot will fail when trying to calibrate the 'delay'
          loop.

[...]


config HIGH_RES_TIMER_ACPI_PM_ADD
        int "Default ACPI pm timer address"
        depends on HIGH_RES_TIMER_ACPI_PM
        default 0
        help
          This option is available for use on systems where the BIOS
          does not generate the ACPI tables if ACPI is not enabled.  For
          example some BIOSes will not generate the ACPI tables if APM
          is enabled.  The ACPI pm timer is still available but cannot
          be found by the software.  This option allows you to supply
          the needed address.  When the high resolution timers code
          finds a valid ACPI pm timer address it reports it in the boot
          messages log (look for lines that begin with
          "High-res-timers:").  You can turn on the ACPI support in the
          BIOS, boot the system and find this value.  You can then enter
          it at configure time.  Both the report and the entry are in
          decimal.

HTH,

Lee

