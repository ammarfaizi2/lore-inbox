Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbWGTQ0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWGTQ0d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 12:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbWGTQ0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 12:26:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:45207 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030362AbWGTQ0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 12:26:32 -0400
X-IronPort-AV: i="4.07,163,1151910000"; 
   d="scan'208"; a="68174216:sNHT3212314987"
Message-ID: <44BFADA6.6090909@intel.com>
Date: Thu, 20 Jul 2006 09:21:58 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.4 (X11/20060617)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: cramerj@intel.com, john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: e1000: "fix" it on thinkpad x60 / eeprom checksum read fails
References: <20060721005832.GA1889@elf.ucw.cz>
In-Reply-To: <20060721005832.GA1889@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jul 2006 16:22:56.0730 (UTC) FILETIME=[C26613A0:01C6AC18]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> e1000 in thinkpad x60 fails without this dirty hack. What to do with
> it?
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>

NAK, certainly this should never be merged in any tree...



this is a known issue that we're tracking here:

http://sourceforge.net/tracker/index.php?func=detail&aid=1474679&group_id=42302&atid=447449

Summary of the issue:

Lenovo has used certain BIOS versions where ASPD/DSPD was turned on which 
turns the PHY off when no cable is inserted to save power. The e1000 driver 
already turns off this feature but can't do this until the driver is loaded. 
It seems that turning this feature on causes the MAC to give read errors.

Lenovo seems to have the feature turned off in their latest BIOS versions, we 
encourage all people to upgrade their BIOS with the latest version from Lenovo 
(available from their website). It seems that for at least 2 people, this has 
fixed the problem.

Inserting a cable obviously might also work :)

We did reproduce the problem initially with the old BIOS (1.01-1.03) on a T60 
system, but unfortunately the bug disappeared into nothingness.

Bypassing the checksum leaves the NIC in an uncertain state and is not 
recommended.

Auke
