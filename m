Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWF2Q71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWF2Q71 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 12:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWF2Q71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 12:59:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46762 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750972AbWF2Q7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 12:59:25 -0400
Date: Thu, 29 Jun 2006 09:58:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
cc: Jean Delvare <khali@linux-fr.org>, Greg KH <gregkh@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Regression in -git / [PATCH] i2c-i801.c: don't pci_disable_device()
 after it was just enabled
In-Reply-To: <200606291830.15027.daniel.ritz-ml@swissonline.ch>
Message-ID: <Pine.LNX.4.64.0606290956410.12404@g5.osdl.org>
References: <200606271840.56044.daniel.ritz-ml@swissonline.ch>
 <20060629140419.23822395.khali@linux-fr.org> <200606291830.15027.daniel.ritz-ml@swissonline.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 29 Jun 2006, Daniel Ritz wrote:
> > 
> > Do you have any idea why disabling the SMBus causes the problem you
> > observe? Could be that your BIOS attempts to use the SMBus at power
> 
> no idea. the last message that is display is "Shutdown: hda" then the
> cursor blinks for 2 more seconds, then complete freeze. also enabling
> all the debugging options in driver model, pm, i2c does not give me anything
> more (it should...the messages during boot are there)...

The SMBus devices may well be used by ACPI (or even SMM, although that is 
probably rare these days).

I don't actually think we should necessarily shut off motherboard devices 
like that, for this reason.

		Linus
