Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbVKBEVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbVKBEVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 23:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbVKBEVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 23:21:03 -0500
Received: from scl-ims.phoenix.com ([216.148.212.222]:28758 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S1751491AbVKBEVD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 23:21:03 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [linux-usb-devel] Re: Commit "[PATCH] USB: Always do usb-handoff" breaks my powerbook
Date: Tue, 1 Nov 2005 20:21:01 -0800
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C376D363@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [linux-usb-devel] Re: Commit "[PATCH] USB: Always do usb-handoff" breaks my powerbook
Thread-Index: AcXeljeYjTCqrCwUTFKFPefYOWgPeQAze5yQ
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Dmitry Torokhov" <dtor_core@ameritech.net>,
       <linux-kernel@vger.kernel.org>
Cc: "David Brownell" <david-b@pacbell.net>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       <linux-usb-devel@lists.sourceforge.net>,
       "Paul Mackerras" <paulus@samba.org>,
       "Alan Stern" <stern@rowland.harvard.edu>
X-OriginalArrivalTime: 02 Nov 2005 04:21:02.0723 (UTC) FILETIME=[D5D61D30:01C5DF64]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Dmitry Torokhov
>Sent: Monday, October 31, 2005 7:40 PM
>To: linux-kernel@vger.kernel.org
>Cc: David Brownell; Benjamin Herrenschmidt; 
>linux-usb-devel@lists.sourceforge.net; Paul Mackerras; Alan Stern
>Subject: Re: [linux-usb-devel] Re: Commit "[PATCH] USB: Always 
>do usb-handoff" breaks my powerbook
>
>On Monday 31 October 2005 22:09, David Brownell wrote:
>> > > > I'm not sure it's legal to do pci_enable_device() from 
>within a pci
>> > > > quirk anyway. I really wonder what that code is doing 
>in the quirks, I
>> > > > don't think it's the right place, but I may be wrong.
>> > > 
>> > > Erm, what "code is doing" what, that you mean ??
>> > 
>> > What _That_ code is doing in the quirks... shouldn't it be in the
>> > {U,O,E}HCI drivers instead ?
>> 
>> Not for PCI.  Vojtech, this is your cue to explain some of 
>how late handoff
>> borks the input layer, as observed by SuSE on way too many 
>BIOS/hardware combos
>> for me to remember ... :)
>> 
>
>Not Vojtech, but here is goes... Not everyone has USB compiled in and
>even then I think USB is registered after serio. So when we probe for
>i8042 BIOS still has its dirty hands on USB controllers and pretends
>that they are in fact PS/2 devices. Crazy stuff like that... That's
>why we can't keep that code in HCI drivers. 

It is even worse in some cases, especially when USB host controller shares 
interrupt with other PCI devices. I've seen systems which have just been 
swamped by interrupts if shared device driver enables IRQ before HCD starts...

Aleks.

>
>-- 
>Dmitry
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
