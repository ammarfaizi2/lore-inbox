Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264652AbUF1GWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264652AbUF1GWP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 02:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264677AbUF1GWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 02:22:15 -0400
Received: from fmr12.intel.com ([134.134.136.15]:13472 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S264652AbUF1GWH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 02:22:07 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Subject: RE: [ACPI] No APIC interrupts after ACPI suspend
Date: Mon, 28 Jun 2004 14:20:01 +0800
Message-ID: <B44D37711ED29844BEA67908EAF36F032D566A@pdsmsx401.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] No APIC interrupts after ACPI suspend
Thread-Index: AcRchVJ69eDy11qtT+2exQlVmSAtwQAUdpPQ
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Hamie" <hamish@travellingkiwi.com>
Cc: <linux-kernel@vger.kernel.org>, <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 28 Jun 2004 06:20:09.0189 (UTC) FILETIME=[F6394950:01C45CD7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I attached a new patch to handler all level triggered IRQs after resume
for 8259 in http://bugme.osdl.org/show_bug.cgi?id=2643. Please try and
attach your test result on it.

Thanks,
Shaohua
>-----Original Message-----
>From: acpi-devel-admin@lists.sourceforge.net [mailto:acpi-devel-
>admin@lists.sourceforge.net] On Behalf Of Hamie
>Sent: Monday, June 28, 2004 4:27 AM
>Cc: Alexander Gran; linux-kernel@vger.kernel.org; acpi-
>devel@lists.sourceforge.net
>Subject: Re: [ACPI] No APIC interrupts after ACPI suspend
>
>Hamie wrote:
>
>> Alexander Gran wrote:
>>
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> Am Sonntag, 27. Juni 2004 19:57 schrieb Hamie:
>>>
>>>
>>>> FWIW the sound & networking appear to run fine for a while after
>>>> resuming. But I just started a DVD. It ran fine for about 30
seconds
>>>> and
>>>> then the sound went. About 30 seconds later the video froze and the
app
>>>> (xine) has frozen also. (kill -9 time...).
>>>>
>>>
>>> <>
>>> I can confirm that here:
>>> after resuming, network completely works (yeah!).
>>> Sound doesn't.
>>> unloading/reloading the sound driver does not help.
>>> USB works jumpy (perhaps 5-10hz)
>>> Reloading does the trick for usb.
>>>
>>
>> Since it sounds like a different bug to 2643, (Similiar but the patch
>> that fixes the ethernet doesn't appear to doa  lot for the sound).
>> I've opened a new one... #2965.
>>
>
>Seeing as sound was on IRQ5 and the patch for 2643 fixed the ethernet,
I
>added a
>(big hack here :) call to
>
>                acpi_pic_sci_set_trigger(5, acpi_sci_flags.trigger);
>
>in  acpi_pm_finish(u32 state); just after the call to set the IRQ
trigger
>for
>the acpi irq...
>
>Results in (kern.log)
>
>Jun 27 21:15:28 ballbreaker kernel: ACPI: IRQ9 SCI: Edge set to Level
>Trigger.
>Jun 27 21:15:28 ballbreaker kernel: ACPI: IRQ5 SCI: Edge set to Level
>Trigger.
>
>
>and then sound works after resume... Obviously not a very good fix as
it
>won't
>fix anything that uses somethign other than IRQ5.
>
>So... What should the correct fix be? Obviously some IRQ's triggers
aren't
>surviving the resume... But why... The timer (IRQ 0) obviously does...
>
>
>
>
>-------------------------------------------------------
>This SF.Net email sponsored by Black Hat Briefings & Training.
>Attend Black Hat Briefings & Training, Las Vegas July 24-29 -
>digital self defense, top technical experts, no vendor pitches,
>unmatched networking opportunities. Visit www.blackhat.com
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/acpi-devel

