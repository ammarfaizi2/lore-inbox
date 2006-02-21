Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161222AbWBUPYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161222AbWBUPYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 10:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161225AbWBUPYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 10:24:12 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:53508 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1161222AbWBUPYL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 10:24:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <Pine.LNX.4.64.0602201810260.6773@iabervon.org>
x-originalarrivaltime: 21 Feb 2006 15:24:05.0459 (UTC) FILETIME=[DA0C2230:01C636FA]
Content-class: urn:content-classes:message
Subject: Re: Missing file
Date: Tue, 21 Feb 2006 10:24:04 -0500
Message-ID: <Pine.LNX.4.61.0602211001300.4470@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Missing file
Thread-Index: AcY2+toTzvMVQTDkTiGX1wwO7/CqHQ==
References: <Pine.LNX.4.61.0602201201200.4888@chaos.analogic.com> <1140456505.2979.66.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0602201333360.5440@chaos.analogic.com> <Pine.LNX.4.64.0602201810260.6773@iabervon.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Daniel Barkalow" <barkalow@iabervon.org>
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Feb 2006, Daniel Barkalow wrote:

> On Mon, 20 Feb 2006, linux-os (Dick Johnson) wrote:
>
>> On Mon, 20 Feb 2006, Arjan van de Ven wrote:
>>
>>> On Mon, 2006-02-20 at 12:08 -0500, linux-os (Dick Johnson) wrote:
>>>>
>>>> Hello,
>>>> Linux-2.6.15.4 fails to contain the file:
>>>>  	/usr/src/linux-2.6.15.4/drivers/pci/devlist.h
>>>>
>>>> This contains product NAMES used to identity various PCI
>>>> devices when they are installed. What replaces this file?
>>>>
>>>> The file existed up until at least linux-2.6.13.4 and
>>>> should not have been removed just because some audit
>>>> may have determined that it's "not in use." It is in
>>>> use by vendors which need to convert "Computerese" to
>>>> "Customer readable" stuff.
>>>
>>> actually an entirely different file is used for that;
>>> /usr/share/hwdata/pci.ids
>>>
>>> which comes from the pci id repo on sourceforge (same as the file you
>>> want to look at). Distributions at least tend to update pci.ids file
>>> more frequent than the kernel updated devlist.h...
>>
>> Thanks. Changes like that make tons of work! Great, there will
>> always be something for us to do. Now all I have to do is
>> modify a tool to be Linux version-specific so I get the right
>> ASCII put into driver(s). The drivers don't run in anything
>> that has a shell or anything like that. They need to "know"
>> the vendor-name of some interface chips so the name(s) were
>> compiled in, based upon OS headers.
>
> If you actually want a "devlist.h" file, 2.6.11 has a program
> gen-devlist.c that generates it (and "classlist.h") from pci.ids. The
> kernel source hasn't come with a devlist.h file since before the dawn of
> time (i.e., the beginning of the git repository). The only recent change
> is not including a pci.ids or generating a devlist.h from it.
>
> 	-Daniel

The modules were generally compiled against a compiled kernel that
has everything we need enabled, including PCI -- and what
we don't use, disabled. So, the file was available up until
2.6.13.4 and disappeared by 2.6.15.4. Also, even the pci.ids
has now been eliminated. This means that one needs to keep
/usr/share/hwdata/pci.ids current if that is what we need to
use now, which implies that one needs a specific Linux
distribution NotGood(tm).

The major problem, not completely understood by many, is
that when a customer says they need to know the vendor name(s)
of the devices on a particular board, by making an ioctl() call
to the device-driver, we cannot say; "Use a user-mode program."
We need to provide what the customer required. During the lifetime
of the product, we cannot change the requirements because that
would require a new certification from a federal agency, either
FAA/TSA for security stuff, or FDA for medical stuff. So, when
stuff gets removed from the kernel, it shouldn't be arbitrary.
There should be some kind of notice that something is going
away so that people who make embedded systems, that don't have
any ability to "use another program", can accommodate.

Most embedded systems do not have any 'init', shells, or
anything like that. That's what makes them reliable and
secure. The only thing that could possibly get executed
is what designers designed and coded for the system. So
moving something that has been "in the kernel" to "outside"
has some considerable consequences, especially since there
isn't an "outside".

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.49 BogoMips).
Warning : 98.36% of all statistics are fiction.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
