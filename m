Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWCFNuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWCFNuo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 08:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWCFNun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 08:50:43 -0500
Received: from fmr18.intel.com ([134.134.136.17]:34781 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932309AbWCFNum convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 08:50:42 -0500
Content-class: urn:content-classes:message
Subject: RE: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Mon, 6 Mar 2006 21:50:38 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC25E@pdsmsx403>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
thread-index: AcY+m1gyLRDdxP6dQNa/yUKPggwFSAChrnqg
From: "Yu, Luming" <luming.yu@intel.com>
To: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 06 Mar 2006 13:50:39.0809 (UTC) FILETIME=[F4309310:01C64124]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On 2/21/06, Yu, Luming <luming.yu@intel.com> wrote:
>> It would be better if you can merge this stuff with acpi 
>video driver.
>> If you look at video.c, there is NO HID definition for video device.
>> we rely on acpi_video_bus_match to recoginize video device in ACPI
>> namespace.
>
>I took a quick look and I think Atlas might be ugly. The current acpi
>video driver, as you pointed out, looks for well known required nodes,
>specifically _DOD,_DOS,_ROM,.... None of these nodes are provided on
>Atlas. From looking at the DSDT, all I see are _BCL and _BCM. It
>doesn't even have _BQC. So, from a quick look at the existing video
>driver, I see a couple of problems that I need advice on:
>
>- is it ok if I add a _BCM check in acpi_video_bus_match. i think this
>is not a problem.

Yes, it's ok, i think.

>- acpi_video_bus_check fails out if no _DOS,_ROM,_GPD,_SPD,_VPO. this
>check fails on Atlas because it doesn't have any of those

These check might be too strict. To face reality, it might need 
be more loose, because it depends on platform vendor to implement
acpi video extension.

>capabilities. The video driver does check for _BCM in
>video_device_find_cap but that's at a much later stage. Do you want me
>to do something like if (acpi_video_bus_check() &&
>acpi_video_output_device_exceptions_detect() )... or do you want me to
>do something cleaner and move the whole _BCM detection earlier in the
>process?

moving it earlier might better.
 
>- acpi_video_bus_get_devices will only call video_bus_get_one_device
>if the device node has children. In Atlas, the "Video Bus", (ie: LCD
>device in the DSDT I pasted before) has no children, at least as found
>by scan.c, so we won't get to get_one_device(). What do you think I
>should do about this?

Please resend me the acpidump, it's somehow dropped from my mailbox.

>
>I have a suspicion that for boards like this where ACPI support isn't
>so complete, we should just use board specific drivers rather than
>mangling the mainstream video driver code. What do you think?

that is the last resort, if you can prove video.c or hotkey.c is NOT 
capable to handle . We do need to make things as generic as possible
in this area, otherwise, I cannot imagine how they can be maintained .
That's the reason why I'm thinking about to propose a ACPI hotkey spec.
Do you have idea for that?

Thanks,
Luming
 

