Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWF2Q33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWF2Q33 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 12:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWF2Q33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 12:29:29 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:39645 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1750916AbWF2Q32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 12:29:28 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: Regression in -git / [PATCH] i2c-i801.c: don't pci_disable_device() after it was just enabled
Date: Thu, 29 Jun 2006 18:30:12 +0200
User-Agent: KMail/1.7.2
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
References: <200606271840.56044.daniel.ritz-ml@swissonline.ch> <20060629140419.23822395.khali@linux-fr.org>
In-Reply-To: <20060629140419.23822395.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606291830.15027.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-05.tornado.cablecom.ch 1377;
	Body=4 Fuz1=4 Fuz2=4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

On Thursday 29 June 2006 14.04, Jean Delvare wrote:
> Hi Daniel,
> 
> I see that your patch was already merged, but I would like to reply
> anyway.
> 
> > [PATCH] i2c-i801.c: don't pci_disable_device() after it was just enabled
> > 
> > Commit 02dd7ae2892e5ceff111d032769c78d3377df970:
> > 	[PATCH] i2c-i801: Merge setup function
> > has a missing return 0 in the _probe() function. this means the error
> > path is always executed and pci_disable_device() is called even when
> > the device just got successfully enabled.
> 
> Oops, good catch, thanks. I'm quite ashamed for letting this go
> through :(
> 
> > having the SMBus device disabled makes some systems (eg. Fujitsu-Siemens
> > Lifebook E8010) hang hard during power-off.
> > 
> > Intead of reverting the whole commit this patch fixes it up:
> > - don't ever call pci_disable_device(), also not in the _remove() function
> >   to avoid hangs
> 
> This is weird, and would certainly deserve additional investigation.
> Disabling the PCI device when we no more need it is the right thing to
> do and almost all pci drivers do that by now - except I2C bus drivers,

basically i agree, but...

> this is the first one I was attempting to convert.
> 
> Do you have any idea why disabling the SMBus causes the problem you
> observe? Could be that your BIOS attempts to use the SMBus at power

no idea. the last message that is display is "Shutdown: hda" then the
cursor blinks for 2 more seconds, then complete freeze. also enabling
all the debugging options in driver model, pm, i2c does not give me anything
more (it should...the messages during boot are there)...

> down time, but I wonder what for. Do you have anything special on this
> SMBus? Proprietary EEPROM? Real-time clock? I have two laptops using
> this driver (one Sony, one Dell) and none exhibited the problem you
> described.

sensors-detect says that there is the smartbattery thingy connected...
maybe the BIOS is querying the battery? dunno...

anyway i'll try again to find out what's causing the hang...

rgds
-daniel
