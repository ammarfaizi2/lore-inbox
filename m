Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWGTRHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWGTRHq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 13:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWGTRHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 13:07:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51384 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750739AbWGTRHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 13:07:45 -0400
Date: Thu, 20 Jul 2006 19:07:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: cramerj@intel.com, john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: e1000: "fix" it on thinkpad x60 / eeprom checksum read fails
Message-ID: <20060720170758.GA9938@atrey.karlin.mff.cuni.cz>
References: <20060721005832.GA1889@elf.ucw.cz> <44BFADA6.6090909@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BFADA6.6090909@intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >e1000 in thinkpad x60 fails without this dirty hack. What to do with
> >it?
> >
> >Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> NAK, certainly this should never be merged in any tree...
> 
> this is a known issue that we're tracking here:
> 
> http://sourceforge.net/tracker/index.php?func=detail&aid=1474679&group_id=42302&atid=447449
> 
> Summary of the issue:
> 
> Lenovo has used certain BIOS versions where ASPD/DSPD was turned on which 
> turns the PHY off when no cable is inserted to save power. The e1000 driver 
> already turns off this feature but can't do this until the driver is 
> loaded. It seems that turning this feature on causes the MAC to give read 
> errors.
> 
> Lenovo seems to have the feature turned off in their latest BIOS versions, 
> we encourage all people to upgrade their BIOS with the latest version from 
> Lenovo (available from their website). It seems that for at least 2 people, 
> this has fixed the problem.
> 
> Inserting a cable obviously might also work :)

Hehe.

> We did reproduce the problem initially with the old BIOS (1.01-1.03) on a 
> T60 system, but unfortunately the bug disappeared into nothingness.
> 
> Bypassing the checksum leaves the NIC in an uncertain state and is not 
> recommended.

Okay, perhaps this should be inserted as a comment into the driver,
and printk should be fixed to point at this explanation?

Can't we enable the driver with the bad checksum, then read the _real_
data?
								Pavel
-- 
Thanks, Sharp!
