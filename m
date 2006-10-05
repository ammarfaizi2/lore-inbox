Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWJETcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWJETcK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWJETcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:32:10 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:3858 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750999AbWJETcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:32:08 -0400
Date: Thu, 5 Oct 2006 15:31:20 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: Alex Owen <r.alex.owen@gmail.com>, linux-kernel@vger.kernel.org,
       aabdulla@nvidia.com, "H. Peter Anvin" <hpa@zytor.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: forcedeth net driver: reverse mac address after pxe boot
Message-ID: <20061005193113.GE18408@tuxdriver.com>
References: <55c223960610040919u221deffei5a5b6c37cfc8eb5a@mail.gmail.com> <20061005144442.GB18408@tuxdriver.com> <45255059.3040908@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45255059.3040908@gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 08:35:05PM +0200, Carl-Daniel Hailfinger wrote:
> John W. Linville wrote:
> > On Wed, Oct 04, 2006 at 05:19:20PM +0100, Alex Owen wrote:
> > 
> >> The obvious fix for this is to try and read the MAC address from the
> >> canonical location... ie where is the source of the address writen
> >> into the controlers registers at power on? But do we know where that
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
