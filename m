Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWCMNQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWCMNQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 08:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbWCMNQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 08:16:58 -0500
Received: from fmr20.intel.com ([134.134.136.19]:23460 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751751AbWCMNQ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 08:16:57 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
Date: Mon, 13 Mar 2006 21:16:53 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041AC262@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.15.3 1/1] ACPI: Atlas ACPI driver
thread-index: AcZGaO3rdWzImBzVSQa1PSalapldnAANUMnw
From: "Yu, Luming" <luming.yu@intel.com>
To: "Jaya Kumar" <jayakumar.acpi@gmail.com>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Mar 2006 13:16:55.0036 (UTC) FILETIME=[6638FBC0:01C646A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On 3/8/06, Yu, Luming <luming.yu@intel.com> wrote:
>> I suggest LCD support in hotkey.c like:
>> http://bugzilla.kernel.org/attachment.cgi?id=6843&action=view
>>
>> Config userspace acpi daemon to respond events by evoking
>> LCD._BCM with command:
>>        echo -n xx > /sys/hotkey/brightness.
>>
>
>A quick question here. I took a look at your patch adding hotkeylib. I
>see brightness_show/store callbacks and I think they end up calling 
>write_acpi_int to do the actual method eval.

Yes.  But there are some restricts with write_acpi_int that only
takes single integer parameter, and write_acpi_int2 that fits aml
method of taking Package as argument.  

>
>So I assume my action_method has got to be "_BCM". I don't have a poll
>method but it looks like I'll need to put something in there since you
>check for it. Atlas has a _BCL. I guess I'll just use that.

Yes. poll_method is for query the status/current value.
For example, to query current brightness value.
 
>
>+       if(!poll_handle || !poll_method || !action_handle || 
>!action_method)
>+               goto do_fail;
>
>From what I can tell, it looks like I have to use ACPILCD00 as my HID
>in this hotkey code. Right? So basically, it'd be something like:
>        {
>                .ids = "ACPILCD00",
>                .name = "brightness",
>                .poll_method = "_BCL",
>                .action_method = "_BCM",
>                .min = 1,
>                .max = 31,
>                .id = 10001,
>        },

I think this is ok.

>
>So if I get that working, is that what you are saying is the right way
>to do brightness support for limited devices like Atlas? I guess it
>feels kind of odd to me because it's an LCD device rather than a
>hotkey device. But afaict it looks like doing that will work fine and
>have the added benefit of not creating any new /proc entries. So let
>me know if I understood you correctly.

Yes.  You are right.

>
>By the way, I just applied your sequence of patches from
>http://bugzilla.kernel.org/show_bug.cgi?id=5749 to my tree. You know,
>if it's okay with you, I'll post the full diff from below to your bug
>report so that the next person doesn't have to cherrypick.

Thanks for doing that.

>
>wget "http://bugzilla.kernel.org/attachment.cgi?id=6839&action=view"
>wget "http://bugzilla.kernel.org/attachment.cgi?id=6840&action=view"
>wget "http://bugzilla.kernel.org/attachment.cgi?id=6841&action=view"
>wget "http://bugzilla.kernel.org/attachment.cgi?id=6842&action=view"
>wget "http://bugzilla.kernel.org/attachment.cgi?id=6843&action=view"
>wget "http://bugzilla.kernel.org/attachment.cgi?id=7061&action=view"
>wget "http://bugzilla.kernel.org/attachment.cgi?id=7060&action=view"
>
>Thanks,
>jayakumar
