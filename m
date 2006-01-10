Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWAJIGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWAJIGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 03:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWAJIGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 03:06:45 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:36904 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751007AbWAJIGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 03:06:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=AFchwypT0dDAkRzr4Xz2f0U1l0gVNGKRsHcSDxhwNfrj/a4XQAO5fGxbHnlq87yN5JKoJrZC/FubnU9y+lHF7vk3/h/00C4gA8w7dLfsi9grttUJyBWL6riDChpx5wTOsxhkb2bOI/c9U8ULKb21Ge5zJhqXngSx0DDZrzcV6Tw=
Message-ID: <43C36B0D.3030808@gmail.com>
Date: Tue, 10 Jan 2006 09:06:37 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051210)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: rlrevell@joe-job.com, "Kernel, " <linux-kernel@vger.kernel.org>
Subject: [BUG 2.6.15-git5] new alsa power management completly broken
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.15: suspend works but on resume mixer volumes are not restored
(registers not saved), so you need to restart your alsa script.
boring but working.

with 2.6.15-git5 i saw a new power management part. lt's test it:

suspending...

Jan 10 08:44:51 blight kernel: Stopping tasks: ===================|
Jan 10 08:44:51 blight kernel: Shrinking memory...  ^H-^Hdone (0 pages
freed)
Jan 10 08:44:51 blight kernel: pnp: Device 00:0b disabled.
Jan 10 08:44:51 blight kernel: pnp: Device 00:07 disabled.
Jan 10 08:44:51 blight kernel: ACPI: PCI interrupt for device
0000:00:0b.0 disabled
Jan 10 08:44:51 blight kernel: ACPI: PCI interrupt for device
0000:00:0a.2 disabled
Jan 10 08:44:51 blight kernel: ACPI: PCI interrupt for device
0000:00:0a.1 disabled
Jan 10 08:44:51 blight kernel: ACPI: PCI interrupt for device
0000:00:0a.0 disabled
Jan 10 08:44:51 blight kernel: ACPI: PCI interrupt for device
0000:00:09.0 disabled
Jan 10 08:44:51 blight kernel: ACPI: PCI interrupt for device
0000:00:04.2 disabled
Jan 10 08:44:51 blight kernel: swsusp: Need to copy 15888 pages
Jan 10 08:44:51 blight kernel: ACPI: PCI Interrupt 0000:00:04.2[D] ->
Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Jan 10 08:44:51 blight kernel: ACPI: PCI Interrupt 0000:00:09.0[A] ->
Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Jan 10 08:44:51 blight kernel: ACPI: PCI Interrupt 0000:00:09.0[A] ->
Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Jan 10 08:44:51 blight kernel: ACPI: PCI Interrupt 0000:00:0a.0[A] ->
Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
Jan 10 08:44:51 blight kernel: ACPI: PCI Interrupt 0000:00:0a.1[B] ->
Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
Jan 10 08:44:51 blight kernel: ACPI: PCI Interrupt 0000:00:0a.2[C] ->
Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
Jan 10 08:44:51 blight kernel: usb usb1: root hub lost power or was reset
Jan 10 08:44:51 blight kernel: ehci_hcd 0000:00:0a.2: USB 2.0 started,
EHCI 0.95, driver 10 Dec 2004
Jan 10 08:44:51 blight kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] ->
Link [LNKB] -> GSI 10 (level, low) -> IRQ 10
Jan 10 08:44:51 blight kernel: codec write timeout, status = 0x660
Jan 10 08:44:51 blight last message repeated 25 times

25 times....about half on suspending and about half on restarting.


now restarting..

Jan 10 08:44:51 blight kernel: pnp: Device 00:07 activated.
Jan 10 08:44:51 blight kernel: pnp: Failed to activate device 00:0a.
Jan 10 08:44:51 blight kernel: pnp: Device 00:0b activated.
Jan 10 08:44:51 blight kernel: Restarting tasks... done

device can't play any sound, as before. so i tried the usual solution
(restart the alsasound script in gentoo)

Jan 10 08:45:45 blight rc-scripts: WARNING:  you are stopping a boot
service.
Jan 10 08:45:47 blight kernel: codec write timeout, status = 0x660
Jan 10 08:46:33 blight last message repeated 64 times
Jan 10 08:46:57 blight last message repeated 199 times

as you can see it flood the syslog with 0x660 errors.
infact if i try to adjust the volume via alsamixer the volume level
moves soooo slow (it's flooding syslog)

so actually power resume is completly broken. the only way is restarting
the kernel via a reboot (built-in alsa).


Audio card: Creative Sound Blaster PCI 128
00:0b.0 Multimedia audio controller: Ensoniq ES1370 [AudioPCI] (rev 01)

Ready to test patches.

Thanks.

--
Patrizio Bassi

www.patriziobassi.it

