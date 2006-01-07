Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbWAGTMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbWAGTMc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161006AbWAGTMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:12:31 -0500
Received: from [81.2.110.250] ([81.2.110.250]:27283 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1161012AbWAGTMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:12:14 -0500
Subject: Re: Changes in SATA, IDE and ATAPI configuration
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: andyliebman@aol.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8C7E1BF63B9F5F4-AC8-506C@FWM-M45.sysops.aol.com>
References: <8C7E1BF63B9F5F4-AC8-506C@FWM-M45.sysops.aol.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 07 Jan 2006 19:14:49 +0000
Message-Id: <1136661289.3748.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-01-07 at 11:34 -0500, andyliebman@aol.com wrote:
> -- BIOS settings for the ICH5 SATA controller on my Xeon motherboard 
> (Auto, SATA, PATA?)
> -- Whether the CD is connected to the Primary or Secondary IDE channel

Secondary slave is broken in 2.6.15 and all earlier SATA releases I've
seen for ICH5. ATAPI prefetch handling is incorrect on PIIX/ICH5. If the
CD is anywhere but the secondary slave it should be fine.

> -- Use (or NOT) of "options libata atapi_enabled=1" in modprobe.conf

If its modular. Otherwise it needs to be a boot time option for libata

> -- Order of loading modules

Shouldn't be

> -- Use (or NOT) of the AHCI module. When making fresh installs onto 
> SATA drives, some distributions seem to load the AHCI module and some 
> don't, on exactly the same hardware with the same kernel.

AHCI mode is an option for the ICH5-R and later controllers and BIOS
side.

Basically ICH5 supports

'Pretend we are one device' (Combined mode) which will see the PATA
ATAPI ports appear as non DMA IDE ports (old style) and in its full
functional mode where PATA and SATA ports are properly seperated out.

> Whatever it is, I haven't found the magic formula for making the 
> transfer from IDE to SATA work. 

Insert CD, install, sync over data. Actually for Fedora and anything
using initrd root device labels you should only need to make the right
initrd and set the options.

Alan

