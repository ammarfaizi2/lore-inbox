Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282610AbRKZW3o>; Mon, 26 Nov 2001 17:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282613AbRKZW3e>; Mon, 26 Nov 2001 17:29:34 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:7689 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S282610AbRKZW30>; Mon, 26 Nov 2001 17:29:26 -0500
Message-Id: <200111262228.fAQMSrY52300@aslan.scsiguy.com>
To: Cristian CONSTANTIN <constantin@fokus.gmd.de>
cc: Pim Zandbergen <P.Zandbergen@macroscoop.nl>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx freezes with kernel 2.4.13 
In-Reply-To: Your message of "Thu, 22 Nov 2001 12:10:36 +0100."
             <20011122121036.V24162@terix.fokus.gmd.de> 
Date: Mon, 26 Nov 2001 15:28:53 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, Nov 07, 2001 at 04:20:17PM +0100, Pim Zandbergen wrote:
>> Hi,
>> 
>> I've got a Dell PowerEdge 1300 with dual PIII's and dual aic7xxx
>> controllers. One controller is onboard, the other is in a PCI slot.
>> 
>> The system is running Red Hat 7.1 with kernel 2.4.13.
>> 
>> Lately, this system is experiencing freezes that may last one or two
>> minutes. These usually occur during heavy Samba activity. After the
>> freeze, the system usually recovers, but by then, the Samba clients
>> have timed out their operations.
>> 
>> Syslog shows the freezes are related to the SCSI subsystem. I'm having
>> trouble interpreting this information. Is my hardware suspect or could
>> this be a driver bug?
>> 
>> Syslog entries (with aic7xxx=verbose) showing the boot process and a
>> system freeze can be found on
>> 
>> http://www.macroscoop.nl/~pim/aic7xxx/syslog.html (98.080 bytes) or
>> http://www.macroscoop.nl/~pim/aic7xxx/syslog.gz   (6.410 bytes)

In the case of these traces, it appears that the bus is not up to
snuff for the negotiated speed.  We're in data-out phase, our DMA
engine is enabled, our FIFO is full of data to send, but the target
has not requested any more data.  This means that either the controller
missed a REQ or the target missed an ACK.  I would verify your cabling
and termination.

>cristian: same problem here. posted some time ago on linux-kernel and
>some days ago on linux-scsi. no solution so far...
>
>my config, in a very few words:
>- tyan SMP motherboard + 2xAthlon
>- adaptec aic7xxx (2 onboard 1 PCI - tried with all of them, same
>  result)

I'd need to see the logs to know for sure that what you are seeing
is the same as Cristian.

--
Justin
