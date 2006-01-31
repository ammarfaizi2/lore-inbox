Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbWAaCeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWAaCeJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 21:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWAaCeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 21:34:09 -0500
Received: from smtprelay06.ispgateway.de ([80.67.18.44]:63626 "EHLO
	smtprelay06.ispgateway.de") by vger.kernel.org with ESMTP
	id S1030273AbWAaCeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 21:34:07 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata queue updated
Date: Tue, 31 Jan 2006 03:33:56 +0100
User-Agent: KMail/1.7.2
Cc: Tejun <htejun@gmail.com>
References: <20060128182522.GA31458@havoc.gtf.org> <200601302002.18962.ioe-lkml@rameria.de> <43DEA978.8000706@gmail.com>
In-Reply-To: <43DEA978.8000706@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601310333.57518.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Tuesday 31 January 2006 01:04, Tejun wrote:
> Ingo Oeser wrote:
> > What about putting the information directly into "ap->device[INDEX].class" 
> > in the sole caller (ata_drive_probe_reset) so far?
> > 
> 
> Not altering ->class directly in lldd driver is one major point of this 
> whole patchset such that higher level driving logic has a say on whether 
> a device is online or not, not the low level driver.  Primarily this is 
> useful for sharing low-level codes with hot plugging / EH but it's also 
> possible to retry some of the operations during probing in limited cases.

Ok, with this argument, I finally get it. Now I know why you do it this
way. You let the lld driver suggest a class for it's devices and verify
these suggestions by high level code. 

The only way to get to this classification data is by resetting the ATA
device.

It might be technically possible to set ->class directly and 
fix it up in high level logic, as needed.

Your explicit design decision was NOT to do this but to put this
suggestions from low level driver into a temporary on stack structure
from the higher level API.

And since the maintainer is happy already, I couldn't care less.

Thanks for your patience :-)


Regards

Ingo Oeser

