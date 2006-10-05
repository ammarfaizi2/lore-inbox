Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWJETpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWJETpi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWJETph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:45:37 -0400
Received: from hqemgate01.nvidia.com ([216.228.112.170]:43073 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1750802AbWJETph convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:45:37 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: forcedeth net driver: reverse mac address after pxe boot
Date: Thu, 5 Oct 2006 12:45:09 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0189CAB06@hqemmail02.nvidia.com>
In-Reply-To: <20061005193113.GE18408@tuxdriver.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: forcedeth net driver: reverse mac address after pxe boot
Thread-Index: AcbotO6u9PPAmcNESoehUtob4unzSwAAW0gA
From: "Ayaz Abdulla" <AAbdulla@nvidia.com>
To: "John W. Linville" <linville@tuxdriver.com>,
       "Carl-Daniel Hailfinger" <c-d.hailfinger.devel.2006@gmx.net>
Cc: "Alex Owen" <r.alex.owen@gmail.com>, <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
X-OriginalArrivalTime: 05 Oct 2006 19:45:07.0871 (UTC) FILETIME=[C2EE0AF0:01C6E8B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The BIOS will write to the mac address register. The address will be
written in reverse order. 

This bug has already been fixed in the PXE code. Can you let me know
what version of PXE you are running (it should display the version on
the screen during boot up)?

Thanks,
Ayaz


-----Original Message-----
From: John W. Linville [mailto:linville@tuxdriver.com] 
Sent: Thursday, October 05, 2006 12:31 PM
To: Carl-Daniel Hailfinger
Cc: Alex Owen; linux-kernel@vger.kernel.org; Ayaz Abdulla; H. Peter
Anvin; Alan Cox
Subject: Re: forcedeth net driver: reverse mac address after pxe boot


On Thu, Oct 05, 2006 at 08:35:05PM +0200, Carl-Daniel Hailfinger wrote:
> John W. Linville wrote:
> > On Wed, Oct 04, 2006 at 05:19:20PM +0100, Alex Owen wrote:
> > 
> >> The obvious fix for this is to try and read the MAC address from
the
> >> canonical location... ie where is the source of the address writen
> >> into the controlers registers at power on? But do we know where
that
> >> may be?
> > 
> > This seems like The Right Thing (TM) to me, but we need someone from
> > NVidia(?) to provide that information.  Ayaz?
> 
> The canonical location of the "original" MAC address is where we write
> back the reversed MAC address. So that won't work.

I think you misunderstand the suggestion (which is admittedly based
on supposition).

On most devices, the MAC address is programmed into a register at
runtime.  It is not "burned-in" to the device itself.  Instead it is
usually stored in some sort of eeprom/nvram/flash/whatever.  The driver
retrieves it at runtime from the nvram and programs it into the device.

In this case, the forcedeth driver is retrieving the MAC address from
a register, reversing it, and writing it back to the _same_ register.
Experience suggests that this register is unlikely to have "magically"
received that information.  The supposition is that instead some
firmware has pre-loaded the register, perhaps at IPL?

It is possible that the device itself is loading the MAC address
from e.g. a serial eeprom tied to the device and inaccessible to
the CPU.  If that is the case, there may be no other solution than
the current silliness.  Since the driver is reversed engineered,
the current silliness (and a prayer for fixed PXE firmware) is the
only good alternative we have.

John
-- 
John W. Linville
linville@tuxdriver.com
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
