Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbVLUTHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVLUTHv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 14:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbVLUTHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 14:07:51 -0500
Received: from fmr14.intel.com ([192.55.52.68]:9152 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751200AbVLUTHu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 14:07:50 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: asus_acpi still broken on Samsung P30/P35
Date: Wed, 21 Dec 2005 14:06:42 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B300580F140@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: asus_acpi still broken on Samsung P30/P35
Thread-Index: AcYGXa03/n6a059wTKi3syFsIsJ6QgAA50dA
From: "Brown, Len" <len.brown@intel.com>
To: "Linus Torvalds" <torvalds@osdl.org>,
       =?iso-8859-1?B?SGFubm8gQsO2Y2s=?= <mail@hboeck.de>,
       "Karol Kozimor" <sziwan@hell.org.pl>
Cc: "Andrew Morton" <akpm@osdl.org>, <acpi-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>, "Christian Aichinger" <Greek0@gmx.net>
X-OriginalArrivalTime: 21 Dec 2005 19:06:45.0899 (UTC) FILETIME=[AFE0FDB0:01C60661]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karol,
Do you have an update of your asus driver in the pipeline
that addresses this?

thanks,
-Len
 

>-----Original Message-----
>From: Linus Torvalds [mailto:torvalds@osdl.org] 
>Sent: Wednesday, December 21, 2005 1:37 PM
>To: Hanno Böck
>Cc: Andrew Morton; Brown, Len; 
>acpi-devel@lists.sourceforge.net; 
>linux-kernel@vger.kernel.org; Karol Kozimor; Christian Aichinger
>Subject: Re: asus_acpi still broken on Samsung P30/P35
>
>
>
>On Wed, 21 Dec 2005, Hanno Böck wrote:
>> 
>> This is not "some minor issue", this completely breaks the 
>usage of current 
>> vanilla-kernels on certain Hardware. Can please, please, 
>please anyone in the 
>> position to do this take care that this patch get's accepted 
>before 2.6.15?
>> 
>> The patch is available inside mm-sources or here:
>> http://www.int21.de/samsung/p30-2.6.14.diff
>> 
>> If I should send it to anyone else or if there's anything I 
>can do to help 
>> fixing this, I'm glad to help.
>
>Last I saw this patch, I wrote this reply (the patch above is still 
>broken). Nobody ever came back to me on it.
>
>			Linus
>
>---
>Date: Tue, 13 Dec 2005 21:15:56 -0800 (PST)
>From: Linus Torvalds <torvalds@osdl.org>
>To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
>cc: Greg KH <greg@kroah.com>, 
>    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
>    stable@kernel.org, acpi-devel <acpi-devel@lists.sourceforge.net>
>Subject: Re: [PATCH] Fix oops in asus_acpi.c on Samsung P30/P35 Laptops
>
>On Wed, 14 Dec 2005, Carl-Daniel Hailfinger wrote:
>> 
>> The patch has been tested and verified, is shipped in the
>> SUSE 10.0 kernel and does not cause any regressions.
>
>I'd be _much_ happier if
>
> - the patch wasn't totally whitespace-damaged (your mailer seems 
>   to not only remove spaces at the end of lines, it _also_ 
>adds them to 
>   the beginning when there was another space there, as far as 
>I can tell)
>
>   Being right "on average" thanks to having two different 
>bugs does not a 
>   good mailer make.
>
> - you were to separate out the oops-fixing code from the code 
>that adds 
>   handling for that (strange?) model type logic.
>
>   It seems that the _oops_ is because the later paths just 
>assume that 
>   it's a ACPI_TYPE_STRING and will dereference 
>"model->string.pointer" 
>   regardless of whether that is true or not. And you add a test for 
>   ACPI_TYPE_INTEGER, however, you do _not_ fix the oops for any other 
>   type, so the exact _same_ bug is still waiting to happen if 
>there is 
>   some other strange ACPI table entry some day.
>
>So I think the proper fix is to _first_ just do something like
>
>	if (model->type != ACPI_TYPE_STRING)
>		goto unknown;
>
>which should fix the oops (no?), and then handling 
>ACPI_TYPE_INTEGER above 
>that as one case would be a separate patch.
>
>		Linus
>
