Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWJETpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWJETpz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWJETpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:45:54 -0400
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:52963 "EHLO
	mail.lidskialf.net") by vger.kernel.org with ESMTP id S1750886AbWJETpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:45:53 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: forcedeth net driver: reverse mac address after pxe boot
Date: Thu, 5 Oct 2006 20:45:52 +0100
User-Agent: KMail/1.9.4
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       Alex Owen <r.alex.owen@gmail.com>, linux-kernel@vger.kernel.org,
       aabdulla@nvidia.com, "H. Peter Anvin" <hpa@zytor.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <55c223960610040919u221deffei5a5b6c37cfc8eb5a@mail.gmail.com> <45255059.3040908@gmx.net> <20061005193113.GE18408@tuxdriver.com>
In-Reply-To: <20061005193113.GE18408@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610052045.52955.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 20:31, John W. Linville wrote:
> On Thu, Oct 05, 2006 at 08:35:05PM +0200, Carl-Daniel Hailfinger wrote:
> > John W. Linville wrote:
> > > On Wed, Oct 04, 2006 at 05:19:20PM +0100, Alex Owen wrote:
> > >> The obvious fix for this is to try and read the MAC address from the
> > >> canonical location... ie where is the source of the address writen
> > >> into the controlers registers at power on? But do we know where that
> > >> may be?
> > >
> > > This seems like The Right Thing (TM) to me, but we need someone from
> > > NVidia(?) to provide that information.  Ayaz?
> >
> > The canonical location of the "original" MAC address is where we write
> > back the reversed MAC address. So that won't work.
>
> I think you misunderstand the suggestion (which is admittedly based
> on supposition).
>
> On most devices, the MAC address is programmed into a register at
> runtime.  It is not "burned-in" to the device itself.  Instead it is
> usually stored in some sort of eeprom/nvram/flash/whatever.  The driver
> retrieves it at runtime from the nvram and programs it into the device.
>
> In this case, the forcedeth driver is retrieving the MAC address from
> a register, reversing it, and writing it back to the _same_ register.
> Experience suggests that this register is unlikely to have "magically"
> received that information.  The supposition is that instead some
> firmware has pre-loaded the register, perhaps at IPL?
>
> It is possible that the device itself is loading the MAC address
> from e.g. a serial eeprom tied to the device and inaccessible to
> the CPU.  If that is the case, there may be no other solution than
> the current silliness.  Since the driver is reversed engineered,
> the current silliness (and a prayer for fixed PXE firmware) is the
> only good alternative we have.

I think my conclusion was that the BIOS was responsible for retrieving the MAC 
from "somewhere" (perhaps a BIOS specific location) and writing it into the 
register that forcedeth users. 

AFAIR, the binary driver only ever accessed the location forcedeth is 
accessing, and it also did the same byte swapping process. I never bothered 
to take the BIOS itelf apart to find out where it was getting the MAC from to 
begin with.
