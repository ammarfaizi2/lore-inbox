Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270577AbUJTXXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270577AbUJTXXZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270574AbUJTXXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:23:19 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:22671 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S270580AbUJTXWz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:22:55 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: forcing PS/2 USB emulation off
Date: Wed, 20 Oct 2004 16:22:54 -0700
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B3017FC327@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: forcing PS/2 USB emulation off
Thread-Index: AcS28EO2jsNRh1EhQZSjfNl6ko30ewACAZkw
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Greg KH" <greg@kroah.com>
Cc: "Alexandre Oliva" <aoliva@redhat.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Vojtech Pavlik" <vojtech@suse.cz>,
       "Dmitry Torokhov" <dtor_core@ameritech.net>
X-OriginalArrivalTime: 20 Oct 2004 23:22:54.0709 (UTC) FILETIME=[BA040A50:01C4B6FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>-----Original Message-----
>From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
>Sent: Wednesday, October 20, 2004 12:54 PM
>To: Greg KH
>Cc: Alexandre Oliva; Linux Kernel Mailing List; Vojtech 
>Pavlik; Dmitry Torokhov
>Subject: Re: forcing PS/2 USB emulation off
>
>On Sul, 2004-10-17 at 23:57, Greg KH wrote:
>> It's already in the -mm kernels, and will be sent to Linus 
>after 2.6.9
>> is out.  If you could test that kernel and verify that it 
>works for this
>> situation, I would appreciate it.
>
>It would be ok if someone bothered to copy the USB core code (or better
>yet call into it) but the patch in the -mm tree doesn't know about the
>zillion OHCI controller bugs, and doesn't know about the suprise
>interrupt on switch from BIOS->host you sometimes see.

Isn't this interrupt disabled at that point, and status are cleared
right
after handoff ? Have you actually been able to see a problem with such 
an interrupt with this patch applied ?

>
>The real fix is to link the USB code early enough to run before the PC
>keyboard code. I've had this confirmed by BIOS folks as well.

That would be nice, but -mm patch covers not only keyboard/mouse issues,
but lockups as well. Unfortunately, to work around this, handoff should 
happen not only pretty early, but before you start enabling shared (with
USB)
interrupts for your cards.

Aleks.
