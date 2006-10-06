Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWJFHkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWJFHkg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 03:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWJFHkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 03:40:36 -0400
Received: from holoclan.de ([62.75.158.126]:42143 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S1750728AbWJFHke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 03:40:34 -0400
Date: Fri, 6 Oct 2006 09:38:04 +0200
From: Martin Lorenz <martin@lorenz.eu.org>
To: linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Subject: Re: 2.6.19-rc1 lost ACPI events after suspend
Message-ID: <20061006073804.GE21470@gimli>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-thinkpad@linux-thinkpad.org
References: <20061006071812.GD21470@gimli>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20061006071812.GD21470@gimli>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  after a little more playing around: I unloaded all
	acpi-related modules (still without having rebooted) # for a in ibm_acpi
	ac battery button dock fan i2c_ec processor thermal video container; do
	modprobe -r $a; done FATAL: Module processor is in use. [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

after a little more playing around:


I unloaded all acpi-related modules (still without having rebooted)
# for a in  ibm_acpi ac battery button dock fan i2c_ec processor thermal video container; do modprobe -r $a; done
FATAL: Module processor is in use.

than restarting acpid which triggers loading of all modules
I get this in the log:

Oct  6 09:29:10 gimli kernel: [47459.529000] ACPI Exception (evxface-0545): AE_BAD_PARAMETER, Removing notify handler [20060707]
Oct  6 09:29:36 gimli kernel: [47485.131000] BUG: warning at fs/proc/generic.c:732/remove_proc_entry()
Oct  6 09:29:36 gimli kernel: [47485.131000]  [<c0103bbd>] dump_trace+0x69/0x1af
Oct  6 09:29:36 gimli kernel: [47485.131000]  [<c0103d1b>] show_trace_log_lvl+0x18/0x2c
Oct  6 09:29:36 gimli kernel: [47485.131000]  [<c01043ba>] show_trace+0xf/0x11
Oct  6 09:29:36 gimli kernel: [47485.131000]  [<c01044bd>] dump_stack+0x15/0x17
Oct  6 09:29:36 gimli kernel: [47485.131000]  [<c018a1e0>] remove_proc_entry+0x142/0x19c
Oct  6 09:29:36 gimli kernel: [47485.131000]  [<f928d09a>] acpi_video_bus_remove_fs+0x65/0x73 [video]
Oct  6 09:29:36 gimli kernel: [47485.131000]  [<f928d469>] acpi_video_bus_remove+0x3a/0x55 [video]
Oct  6 09:29:36 gimli kernel: [47485.131000]  [<c022910e>] acpi_bus_unregister_driver+0x3a/0x9f
Oct  6 09:29:36 gimli kernel: [47485.132000]  [<f928e82e>] acpi_video_exit+0xa/0x1a [video]
Oct  6 09:29:36 gimli kernel: [47485.132000]  [<c0139006>] sys_delete_module+0x17f/0x1a5
Oct  6 09:29:36 gimli kernel: [47485.132000]  [<c0102da7>] syscall_call+0x7/0xb
Oct  6 09:29:36 gimli kernel: [47485.132000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
Oct  6 09:29:36 gimli kernel: [47485.132000]
Oct  6 09:29:36 gimli kernel: [47485.132000] Leftover inexact backtrace:
Oct  6 09:29:36 gimli kernel: [47485.132000]
Oct  6 09:29:36 gimli kernel: [47485.132000]  [<c02e007b>] unix_dgram_connect+0x13f/0x140
Oct  6 09:29:36 gimli kernel: [47485.132000]  =======================
Oct  6 09:29:54 gimli kernel: [47503.375000] ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
Oct  6 09:29:54 gimli kernel: [47503.375000] ibm_acpi:
http://ibm-acpi.sf.net/
Oct  6 09:29:55 gimli kernel: [47503.932000] ACPI: AC Adapter [AC] (on-line)
Oct  6 09:30:01 gimli kernel: [47510.250000] ACPI: Battery Slot [BAT0] (battery present)
Oct  6 09:30:01 gimli kernel: [47510.267000] ACPI: Power Button (FF) [PWRF]
Oct  6 09:30:01 gimli kernel: [47510.267000] ACPI: Lid Switch [LID]
Oct  6 09:30:01 gimli kernel: [47510.267000] ACPI: Sleep Button (CM) [SLPB]
Oct  6 09:30:01 gimli kernel: [47510.282000] ACPI: ACPI Dock Station Driver
Oct  6 09:30:02 gimli kernel: [47510.944000] ACPI: Thermal Zone [THM0] (47 C)
Oct  6 09:30:02 gimli kernel: [47510.946000] ACPI: Thermal Zone [THM1] (50 C)
Oct  6 09:30:02 gimli kernel: [47510.965000] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)
Oct  6 09:30:02 gimli kernel: [47510.966000] ACPI: Video Device [VID] (multi-head: yes  rom: no  post: no)


more info

# cat /proc/acpi/ibm/hotkey
status:         enabled
mask:           0xff9f
commands:       enable, disable, reset, <mask>

# cat /proc/acpi/ibm/ecdump
EC       +00 +01 +02 +03 +04 +05 +06 +07 +08 +09 +0a +0b +0c +0d +0e +0f
EC 0x00: *a7 *05 *a0 *41 *fe *96  00  00 *1f *02 *47  00  00  00 *80  00
EC 0x10:  00  00 *ff *ff *f4 *3c *87 *09 *43 *ff *83 *01 *ff *ff *2d  00
EC 0x20:  00 *09  00  00 *4b  00  00  00  00  00  00  00 *89  00  00 *80
EC 0x30: *03 *07 *02  00 *30 *04 *04  00 *85  00 *30 *10 *2a *50  00  00
EC 0x40:  00  00  00  00  00  00 *14 *01 *0a  00  00  00  00  00 *04  00
EC 0x50:  00 *c0 *02 *23 *41  00 *3c *2d *03 *3f *2d *06 *25 *23 *30  00
EC 0x60: *80  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
EC 0x70:  00  00  00  00  00 *12 *30 *80 *2f *2c *80 *2d *1f *80 *1d *80
EC 0x80:  00  00  00 *06 *82 *0b *03  00  00  00 *0e *78  00  00  00  00
EC 0x90:  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
EC 0xa0: *e7 *08 *bd *0a *ff *ff *53  00  00  00 *6d *3f *ff *ff *c0  00
EC 0xb0:  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
EC 0xc0: *2b *29 *80 *80 *80 *80 *80 *80  00 *41  00  00  00  00 *10  00
EC 0xd0:  06  00  00  00  00  00  00  00  00  00  00  00  00  00  00  00
EC 0xe0:  00  00  00  00  00  00  00  00  10  80  a6  04  24  2e  55  03
EC 0xf0:  37  42  48  54  33  35  57  57  0c  f5  60  7c  0c  e7  63  93


and now the log from two suspend/resume cycles attached (my fingers were
faster than my braon on the last message)

thanks
mlo

On Fri, Oct 06, 2006 at 09:18:12AM +0200, Dipl.-Ing. Martin Lorenz wrote:
> *Waving hallo again*
> 
> After partially solving one problem another occurs...
> 
> With my most recent kernel 
> 
> commit d223a60106891bfe46febfacf46b20cd8509aaad
> tree ca81ba555de7a9a68605ef98f13fbc027439cdd2
> parent 77dc2db6d1d2703ee4e83d4b3dbecf4e06a910e6
> author Linus Torvalds <torvalds@g5.osdl.org> Wed, 04 Oct 2006 19:57:05 -0700
> 
> with additional patch tp_smapi 0.30 
> 
> I can suspend exactly twice. will say, after second wakeup I don't get 
> any ACPI events. I already searched for error messages in the logs and 
> found this:
> 
> Oct  6 08:49:09 gimli kernel: [45058.156000] ACPI Exception (evxface-0545):
> AE_BAD_PARAMETER, Removing notify handler [20060707]
> 
> it occurs on unloading ibm_acpi module after resume
> reloading ibm_acpi dosen't change anything
> 
> one message that is in the log for the first suspend/resume but not in the
> second is 
> - Breaking affinity for irq 219
> 
> and in the second I see this, which I guess has nothing to do with my
> problem...
> 
> + e1000: eth0: e1000_watchdog: NIC Link is Down
> + BUG: warning at drivers/pci/msi.c:680/pci_enable_msi()
> +  [<c0103bbd>] dump_trace+0x69/0x1af
> +  [<c0103d1b>] show_trace_log_lvl+0x18/0x2c
> +  [<c01043ba>] show_trace+0xf/0x11
> +  [<c01044bd>] dump_stack+0x15/0x17
> +  [<c0208d36>] pci_enable_msi+0x78/0x22e
> +  [<c025808b>] e1000_open+0x64/0x176
> +  [<c029b281>] dev_open+0x2b/0x62
> +  [<c0299d8f>] dev_change_flags+0x47/0xe4
> +  [<c02cde47>] devinet_ioctl+0x252/0x556
> +  [<c0290ffa>] sock_ioctl+0x19e/0x1c2
> +  [<c01697df>] do_ioctl+0x1f/0x62
> +  [<c0169a67>] vfs_ioctl+0x245/0x257
> +  [<c0169ac5>] sys_ioctl+0x4c/0x67
> +  [<c0102da7>] syscall_call+0x7/0xb
> + DWARF2 unwinder stuck at syscall_call+0x7/0xb
> +
> + Leftover inexact backtrace:
> +
> +  =======================
> 
> the complete logs are attached
> 
> 
> gruss
>   mlo
> --
> Dipl.-Ing. Martin Lorenz
> 
>             They that can give up essential liberty 
> 	    to obtain a little temporary safety 
> 	    deserve neither liberty nor safety.
>                                    Benjamin Franklin
> 
> please encrypt your mail to me
> GnuPG key-ID: F1AAD37D
> get it here:
> http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D
> 
> ICQ UIN: 33588107
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=messages_2suspends

Oct  6 00:18:59 gimli -- MARK --
Oct  6 00:38:59 gimli -- MARK --
Oct  6 00:58:59 gimli -- MARK --
Oct  6 01:18:59 gimli -- MARK --
Oct  6 01:38:59 gimli -- MARK --
Oct  6 01:58:59 gimli -- MARK --
Oct  6 02:18:59 gimli -- MARK --
Oct  6 02:38:59 gimli -- MARK --
Oct  6 02:58:59 gimli -- MARK --
Oct  6 03:18:59 gimli -- MARK --
Oct  6 03:38:59 gimli -- MARK --
Oct  6 03:58:59 gimli -- MARK --
Oct  6 04:18:59 gimli -- MARK --
Oct  6 04:38:59 gimli -- MARK --
Oct  6 04:58:59 gimli -- MARK --
Oct  6 05:18:59 gimli -- MARK --
Oct  6 05:38:59 gimli -- MARK --
Oct  6 05:58:59 gimli -- MARK --
Oct  6 06:18:59 gimli -- MARK --
Oct  6 06:38:59 gimli -- MARK --
Oct  6 06:58:59 gimli -- MARK --
Oct  6 07:18:59 gimli -- MARK --
Oct  6 07:39:00 gimli -- MARK --
Oct  6 07:40:56 gimli kernel: [40965.057000] e1000: eth0: e1000_watchdog: NIC Link is Down
Oct  6 07:40:59 gimli kernel: [40968.313000] smapi smapi: set_real_thresh: set start to 39 for bat=0
Oct  6 07:40:59 gimli kernel: [40968.518000] smapi smapi: set_real_thresh: set stop to 75 for bat=0
Oct  6 07:41:01 gimli syslogd 1.4.1#19: restart.
Oct  6 07:41:01 gimli kernel: [40970.520000] smapi smapi: set_real_thresh: set start to 39 for bat=0
Oct  6 07:41:02 gimli kernel: [40970.725000] smapi smapi: set_real_thresh: set stop to 75 for bat=0
Oct  6 07:41:03 gimli kernel: [40972.329000] Disabling non-boot CPUs ...
Oct  6 07:41:03 gimli kernel: [40972.335000] Breaking affinity for irq 219
Oct  6 07:41:03 gimli kernel: [40972.437000] CPU 1 is now offline
Oct  6 07:41:03 gimli kernel: [40972.437000] SMP alternatives: switching to UP code
Oct  6 07:51:58 gimli kernel: [40972.453000] CPU1 is down
Oct  6 07:51:58 gimli kernel: [40972.453000] Stopping tasks: ==========================================================================================================================|
Oct  6 07:51:58 gimli kernel: [40972.670000] Suspending console(s)
Oct  6 07:51:58 gimli kernel: [40974.544000] pnp: Device 00:0a disabled.
Oct  6 07:51:58 gimli kernel: [40974.545000] ACPI: PCI interrupt for device 0000:15:00.2 disabled
Oct  6 07:51:58 gimli kernel: [40974.567000] ACPI: PCI interrupt for device 0000:15:00.0 disabled
Oct  6 07:51:58 gimli kernel: [40974.613000] ACPI: PCI interrupt for device 0000:02:00.0 disabled
Oct  6 07:51:58 gimli kernel: [40974.626000] ACPI: PCI interrupt for device 0000:00:1f.2 disabled
Oct  6 07:51:58 gimli kernel: [40974.637000] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
Oct  6 07:51:58 gimli kernel: [40974.749000] ACPI: PCI interrupt for device 0000:00:1d.3 disabled
Oct  6 07:51:58 gimli kernel: [40974.749000] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
Oct  6 07:51:58 gimli kernel: [40974.749000] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
Oct  6 07:51:58 gimli kernel: [40974.749000] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
Oct  6 07:51:58 gimli kernel: [40974.751000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
Oct  6 07:51:58 gimli kernel: [40974.751000] Intel machine check architecture supported.
Oct  6 07:51:58 gimli kernel: [40974.751000] Intel machine check reporting enabled on CPU#0.
Oct  6 07:51:58 gimli kernel: [41625.776000] PCI: Enabling device 0000:00:1b.0 (0100 -> 0102)
Oct  6 07:51:58 gimli kernel: [41625.776000] ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 21
Oct  6 07:51:58 gimli kernel: [41625.794000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 20
Oct  6 07:51:58 gimli kernel: [41625.794000] usb usb1: root hub lost power or was reset
Oct  6 07:51:58 gimli kernel: [41625.794000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 21
Oct  6 07:51:58 gimli kernel: [41625.794000] usb usb2: root hub lost power or was reset
Oct  6 07:51:58 gimli kernel: [41625.794000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 22
Oct  6 07:51:58 gimli kernel: [41625.794000] usb usb3: root hub lost power or was reset
Oct  6 07:51:58 gimli kernel: [41625.794000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 23
Oct  6 07:51:58 gimli kernel: [41625.794000] usb usb4: root hub lost power or was reset
Oct  6 07:51:58 gimli kernel: [41625.805000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 23
Oct  6 07:51:58 gimli kernel: [41625.817000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level, low) -> IRQ 20
Oct  6 07:51:58 gimli kernel: [41626.829000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 20
Oct  6 07:51:58 gimli kernel: [41626.872000] ACPI: PCI Interrupt 0000:15:00.0[A] -> GSI 16 (level, low) -> IRQ 20
Oct  6 07:51:58 gimli kernel: [41626.925000] ACPI: PCI Interrupt 0000:15:00.2[C] -> GSI 18 (level, low) -> IRQ 22
Oct  6 07:51:58 gimli kernel: [41626.936000] pnp: Device 00:08 does not support activation.
Oct  6 07:51:58 gimli kernel: [41626.936000] pnp: Device 00:09 does not support activation.
Oct  6 07:51:58 gimli kernel: [41626.937000] pnp: Device 00:0a activated.
Oct  6 07:51:58 gimli kernel: [41627.121000] ata2: SATA link down (SStatus 0 SControl 0)
Oct  6 07:51:58 gimli kernel: [41627.121000] ata3: SATA link down (SStatus 0 SControl 0)
Oct  6 07:51:58 gimli kernel: [41627.121000] ata4: SATA link down (SStatus 0 SControl 0)
Oct  6 07:51:58 gimli kernel: [41627.466000] smapi smapi: set_real_thresh: set stop to 75 for bat=0
Oct  6 07:51:58 gimli kernel: [41627.568000] smapi smapi: set_real_thresh: set start to 39 for bat=0
Oct  6 07:51:58 gimli kernel: [41627.670000] smapi smapi: set_real_thresh: set stop to 0 for bat=1
Oct  6 07:51:58 gimli kernel: [41627.772000] smapi smapi: set_real_thresh: set start to 95 for bat=1
Oct  6 07:51:58 gimli kernel: [41627.773000] Restarting tasks...<6>usb 4-1: USB disconnect, address 2
Oct  6 07:51:58 gimli kernel: [41627.813000]  done
Oct  6 07:51:58 gimli kernel: [41627.813000] Enabling non-boot CPUs ...
Oct  6 07:51:58 gimli kernel: [41627.821000] SMP alternatives: switching to SMP code
Oct  6 07:51:58 gimli kernel: [41627.821000] Booting processor 1/1 eip 3000
Oct  6 07:51:58 gimli kernel: [41627.832000] Initializing CPU#1
Oct  6 07:51:58 gimli kernel: [41627.893000] Calibrating delay using timer specific routine.. 3325.05 BogoMIPS (lpj=1662528)
Oct  6 07:51:58 gimli kernel: [41627.893000] monitor/mwait feature present.
Oct  6 07:51:58 gimli kernel: [41627.893000] CPU: L1 I cache: 32K, L1 D cache: 32K
Oct  6 07:51:58 gimli kernel: [41627.893000] CPU: L2 cache: 2048K
Oct  6 07:51:58 gimli kernel: [41627.893000] CPU: Physical Processor ID: 0
Oct  6 07:51:58 gimli kernel: [41627.893000] CPU: Processor Core ID: 1
Oct  6 07:51:58 gimli kernel: [41627.893000] Intel machine check architecture supported.
Oct  6 07:51:58 gimli kernel: [41627.893000] Intel machine check reporting enabled on CPU#1.
Oct  6 07:51:58 gimli kernel: [41627.893000] CPU1: Intel Genuine Intel(R) CPU           L2400  @ 1.66GHz stepping 08
Oct  6 07:51:58 gimli kernel: [41627.903000] CPU1 is up
Oct  6 07:51:58 gimli kernel: [41627.946000] usb 4-2: USB disconnect, address 3
Oct  6 07:51:58 gimli kernel: [41628.203000] usb 4-2: new full speed USB device using uhci_hcd and address 4
Oct  6 07:51:58 gimli kernel: [41628.336000] ata1: waiting for device to spin up (7 secs)
Oct  6 07:51:58 gimli kernel: [41628.368000] usb 4-2: configuration #1 chosen from 1 choice
Oct  6 07:51:59 gimli kernel: [41628.860000] usb 4-1: new full speed USB device using uhci_hcd and address 5
Oct  6 07:51:59 gimli kernel: [41629.071000] usb 4-1: configuration #1 chosen from 1 choice
Oct  6 07:52:06 gimli kernel: [41635.918000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Oct  6 07:52:06 gimli kernel: [41635.922000] ata1.00: configured for UDMA/100
Oct  6 07:52:06 gimli kernel: [41635.923000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
Oct  6 07:52:06 gimli kernel: [41635.923000] sda: Write Protect is off
Oct  6 07:52:06 gimli kernel: [41635.923000] SCSI device sda: drive cache: write back
Oct  6 08:05:53 gimli kernel: [42463.057000] Disabling non-boot CPUs ...
Oct  6 08:05:53 gimli kernel: [42463.166000] CPU 1 is now offline
Oct  6 08:05:53 gimli kernel: [42463.166000] SMP alternatives: switching to UP code
Oct  6 08:38:40 gimli kernel: [42463.172000] CPU1 is down
Oct  6 08:38:40 gimli kernel: [42463.172000] Stopping tasks: ====================================================================================================================|
Oct  6 08:38:40 gimli kernel: [42463.202000] Suspending console(s)
Oct  6 08:38:40 gimli kernel: [42465.104000] pnp: Device 00:0a disabled.
Oct  6 08:38:40 gimli kernel: [42465.104000] ACPI: PCI interrupt for device 0000:15:00.2 disabled
Oct  6 08:38:40 gimli kernel: [42465.126000] ACPI: PCI interrupt for device 0000:15:00.0 disabled
Oct  6 08:38:40 gimli kernel: [42465.170000] ACPI: PCI interrupt for device 0000:02:00.0 disabled
Oct  6 08:38:40 gimli kernel: [42465.183000] ACPI: PCI interrupt for device 0000:00:1f.2 disabled
Oct  6 08:38:40 gimli kernel: [42465.194000] ACPI: PCI interrupt for device 0000:00:1d.7 disabled
Oct  6 08:38:40 gimli kernel: [42465.305000] ACPI: PCI interrupt for device 0000:00:1d.3 disabled
Oct  6 08:38:40 gimli kernel: [42465.305000] ACPI: PCI interrupt for device 0000:00:1d.2 disabled
Oct  6 08:38:40 gimli kernel: [42465.305000] ACPI: PCI interrupt for device 0000:00:1d.1 disabled
Oct  6 08:38:40 gimli kernel: [42465.305000] ACPI: PCI interrupt for device 0000:00:1d.0 disabled
Oct  6 08:38:40 gimli kernel: [42465.307000] ACPI: PCI interrupt for device 0000:00:1b.0 disabled
Oct  6 08:38:40 gimli kernel: [42465.307000] Intel machine check architecture supported.
Oct  6 08:38:40 gimli kernel: [42465.307000] Intel machine check reporting enabled on CPU#0.
Oct  6 08:38:40 gimli kernel: [44428.926000] PCI: Enabling device 0000:00:1b.0 (0100 -> 0102)
Oct  6 08:38:40 gimli kernel: [44428.926000] ACPI: PCI Interrupt 0000:00:1b.0[B] -> GSI 17 (level, low) -> IRQ 21
Oct  6 08:38:40 gimli kernel: [44428.944000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 20
Oct  6 08:38:40 gimli kernel: [44428.944000] usb usb1: root hub lost power or was reset
Oct  6 08:38:40 gimli kernel: [44428.944000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 21
Oct  6 08:38:40 gimli kernel: [44428.944000] usb usb2: root hub lost power or was reset
Oct  6 08:38:40 gimli kernel: [44428.944000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 22
Oct  6 08:38:40 gimli kernel: [44428.944000] usb usb3: root hub lost power or was reset
Oct  6 08:38:40 gimli kernel: [44428.944000] ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 23
Oct  6 08:38:40 gimli kernel: [44428.944000] usb usb4: root hub lost power or was reset
Oct  6 08:38:40 gimli kernel: [44429.255000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 23
Oct  6 08:38:40 gimli kernel: [44429.266000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 16 (level, low) -> IRQ 20
Oct  6 08:38:40 gimli kernel: [44430.278000] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 20
Oct  6 08:38:40 gimli kernel: [44430.321000] ACPI: PCI Interrupt 0000:15:00.0[A] -> GSI 16 (level, low) -> IRQ 20
Oct  6 08:38:40 gimli kernel: [44430.374000] ACPI: PCI Interrupt 0000:15:00.2[C] -> GSI 18 (level, low) -> IRQ 22
Oct  6 08:38:40 gimli kernel: [44430.385000] pnp: Device 00:08 does not support activation.
Oct  6 08:38:40 gimli kernel: [44430.385000] pnp: Device 00:09 does not support activation.
Oct  6 08:38:40 gimli kernel: [44430.386000] pnp: Device 00:0a activated.
Oct  6 08:38:40 gimli kernel: [44430.570000] ata2: SATA link down (SStatus 0 SControl 0)
Oct  6 08:38:40 gimli kernel: [44430.570000] ata3: SATA link down (SStatus 0 SControl 0)
Oct  6 08:38:40 gimli kernel: [44430.570000] ata4: SATA link down (SStatus 0 SControl 0)
Oct  6 08:38:40 gimli kernel: [44430.909000] smapi smapi: set_real_thresh: set stop to 75 for bat=0
Oct  6 08:38:40 gimli kernel: [44431.011000] smapi smapi: set_real_thresh: set start to 39 for bat=0
Oct  6 08:38:40 gimli kernel: [44431.113000] smapi smapi: set_real_thresh: set stop to 0 for bat=1
Oct  6 08:38:40 gimli kernel: [44431.215000] smapi smapi: set_real_thresh: set start to 95 for bat=1
Oct  6 08:38:40 gimli kernel: [44431.216000] Restarting tasks...<6>usb 4-1: USB disconnect, address 5
Oct  6 08:38:40 gimli kernel: [44431.272000]  done
Oct  6 08:38:40 gimli kernel: [44431.272000] Enabling non-boot CPUs ...
Oct  6 08:38:40 gimli kernel: [44431.276000] SMP alternatives: switching to SMP code
Oct  6 08:38:40 gimli kernel: [44431.276000] Booting processor 1/1 eip 3000
Oct  6 08:38:40 gimli kernel: [44431.287000] Initializing CPU#1
Oct  6 08:38:40 gimli kernel: [44431.348000] Calibrating delay using timer specific routine.. 3325.05 BogoMIPS (lpj=1662529)
Oct  6 08:38:40 gimli kernel: [44431.348000] monitor/mwait feature present.
Oct  6 08:38:40 gimli kernel: [44431.348000] CPU: L1 I cache: 32K, L1 D cache: 32K
Oct  6 08:38:40 gimli kernel: [44431.348000] CPU: L2 cache: 2048K
Oct  6 08:38:40 gimli kernel: [44431.348000] CPU: Physical Processor ID: 0
Oct  6 08:38:40 gimli kernel: [44431.348000] CPU: Processor Core ID: 1
Oct  6 08:38:40 gimli kernel: [44431.348000] Intel machine check architecture supported.
Oct  6 08:38:40 gimli kernel: [44431.348000] Intel machine check reporting enabled on CPU#1.
Oct  6 08:38:40 gimli kernel: [44431.348000] CPU1: Intel Genuine Intel(R) CPU           L2400  @ 1.66GHz stepping 08
Oct  6 08:38:40 gimli kernel: [44431.375000] usb 4-2: USB disconnect, address 4
Oct  6 08:38:41 gimli kernel: [44431.632000] usb 4-2: new full speed USB device using uhci_hcd and address 6
Oct  6 08:38:41 gimli kernel: [44431.791000] ata1: waiting for device to spin up (7 secs)
Oct  6 08:38:41 gimli kernel: [44431.796000] usb 4-2: configuration #1 chosen from 1 choice
Oct  6 08:38:41 gimli kernel: [44432.252000] usb 4-1: new full speed USB device using uhci_hcd and address 7
Oct  6 08:38:41 gimli kernel: [44432.411000] usb 4-1: configuration #1 chosen from 1 choice
Oct  6 08:38:49 gimli kernel: [44436.352000] CPU1 is up
Oct  6 08:38:49 gimli kernel: [44439.775000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Oct  6 08:38:49 gimli kernel: [44439.779000] ata1.00: configured for UDMA/100
Oct  6 08:38:49 gimli kernel: [44439.780000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
Oct  6 08:38:49 gimli kernel: [44439.780000] sda: Write Protect is off
Oct  6 08:38:49 gimli kernel: [44439.780000] SCSI device sda: drive cache: write back
Oct  6 08:38:57 gimli kernel: [44447.805000] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
Oct  6 08:38:57 gimli kernel: [44447.805000] e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
Oct  6 08:39:06 gimli kernel: [44457.180000] smapi smapi: set_real_thresh: set start to 39 for bat=0
Oct  6 08:39:06 gimli kernel: [44457.385000] smapi smapi: set_real_thresh: set stop to 75 for bat=0
Oct  6 08:39:08 gimli syslogd 1.4.1#19: restart.
Oct  6 08:39:09 gimli kernel: [44459.469000] smapi smapi: set_real_thresh: set start to 39 for bat=0
Oct  6 08:39:09 gimli kernel: [44459.673000] smapi smapi: set_real_thresh: set stop to 75 for bat=0
Oct  6 08:40:48 gimli kernel: [44557.191000] e1000: eth0: e1000_watchdog: NIC Link is Down
Oct  6 08:40:54 gimli kernel: [44563.109000] BUG: warning at drivers/pci/msi.c:680/pci_enable_msi()
Oct  6 08:40:54 gimli kernel: [44563.109000]  [<c0103bbd>] dump_trace+0x69/0x1af
Oct  6 08:40:54 gimli kernel: [44563.109000]  [<c0103d1b>] show_trace_log_lvl+0x18/0x2c
Oct  6 08:40:54 gimli kernel: [44563.109000]  [<c01043ba>] show_trace+0xf/0x11
Oct  6 08:40:54 gimli kernel: [44563.109000]  [<c01044bd>] dump_stack+0x15/0x17
Oct  6 08:40:54 gimli kernel: [44563.109000]  [<c0208d36>] pci_enable_msi+0x78/0x22e
Oct  6 08:40:54 gimli kernel: [44563.110000]  [<c025808b>] e1000_open+0x64/0x176
Oct  6 08:40:54 gimli kernel: [44563.111000]  [<c029b281>] dev_open+0x2b/0x62
Oct  6 08:40:54 gimli kernel: [44563.112000]  [<c0299d8f>] dev_change_flags+0x47/0xe4
Oct  6 08:40:54 gimli kernel: [44563.113000]  [<c02cde47>] devinet_ioctl+0x252/0x556
Oct  6 08:40:54 gimli kernel: [44563.114000]  [<c0290ffa>] sock_ioctl+0x19e/0x1c2
Oct  6 08:40:54 gimli kernel: [44563.115000]  [<c01697df>] do_ioctl+0x1f/0x62
Oct  6 08:40:54 gimli kernel: [44563.115000]  [<c0169a67>] vfs_ioctl+0x245/0x257
Oct  6 08:40:54 gimli kernel: [44563.115000]  [<c0169ac5>] sys_ioctl+0x4c/0x67
Oct  6 08:40:54 gimli kernel: [44563.116000]  [<c0102da7>] syscall_call+0x7/0xb
Oct  6 08:40:54 gimli kernel: [44563.116000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
Oct  6 08:40:54 gimli kernel: [44563.116000] 
Oct  6 08:40:54 gimli kernel: [44563.116000] Leftover inexact backtrace:
Oct  6 08:40:54 gimli kernel: [44563.116000] 
Oct  6 08:40:54 gimli kernel: [44563.116000]  =======================
Oct  6 08:43:22 gimli kernel: [44711.149000] e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
Oct  6 08:43:22 gimli kernel: [44711.149000] e1000: eth0: e1000_watchdog: 10/100 speed: disabling TSO
Oct  6 08:48:39 gimli kernel: [45028.144000] tp_smapi unloaded.
Oct  6 08:48:39 gimli kernel: [45028.144000] thinkpad_ec: unloaded.
Oct  6 08:48:52 gimli kernel: [45041.621000] thinkpad_ec: thinkpad_ec 0.30 loaded.
Oct  6 08:48:52 gimli kernel: [45041.623000] tp_smapi 0.30 loading...
Oct  6 08:48:52 gimli kernel: [45041.624000] tp_smapi successfully loaded (smapi_port=0xb2).
Oct  6 08:49:04 gimli kernel: [45053.568000] tp_smapi unloaded.
Oct  6 08:49:04 gimli kernel: [45053.568000] thinkpad_ec: unloaded.
Oct  6 08:49:09 gimli kernel: [45058.156000] ACPI Exception (evxface-0545): AE_BAD_PARAMETER, Removing notify handler [20060707]
Oct  6 08:49:13 gimli kernel: [45062.218000] thinkpad_ec: thinkpad_ec 0.30 loaded.
Oct  6 08:49:13 gimli kernel: [45062.220000] tp_smapi 0.30 loading...
Oct  6 08:49:13 gimli kernel: [45062.220000] tp_smapi successfully loaded (smapi_port=0xb2).
Oct  6 08:49:16 gimli kernel: [45065.464000] ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
Oct  6 08:49:16 gimli kernel: [45065.464000] ibm_acpi: http://ibm-acpi.sf.net/
Oct  6 09:02:33 gimli -- MARK --

--huq684BweRXVnRxX--
