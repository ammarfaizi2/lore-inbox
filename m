Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWEIUEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWEIUEh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWEIUEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:04:37 -0400
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:47053 "EHLO
	smtpq2.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1751073AbWEIUEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:04:36 -0400
Message-ID: <4460F60A.9080006@keyaccess.nl>
Date: Tue, 09 May 2006 22:05:30 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: libata PATA patch update
References: <1147104400.3172.7.camel@localhost.localdomain>	 <445FD8D4.9030106@keyaccess.nl> <1147177857.3172.70.camel@localhost.localdomain>
In-Reply-To: <1147177857.3172.70.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>> am using slackware 10.2 (vanilla) "cdparanoia III release 9.8 (March 23, 
>> 2001)". A while ago someone on this list pointed to some patches for 
>> SG_IO use with cdparanoia but this made my machine highly unstable. 
>> Would you like me to retest with this new driver? If so, any specific 
>> version of cdparanoia?
> 
> I would be interested to know what happens if you try this, version
> doesn't matter.

Did so. Took vanilla cdparanoia-III-alpha9.8 from:

http://downloads.xiph.org/releases/cdparanoia/cdparanoia-III-alpha9.8.src.tgz

and then applied the labels and sgio patches from:

ftp://ftp.redhat.com/pub/redhat/linux/enterprise/4/en/os/i386/SRPMS/cdparanoia-alpha9.8-24.src.rpm

Unfortunately, the only difference with regular cdparanoia seems to be 
that info bit. Now it's just:

===
Checking /dev/cdrom for cdrom...

CDROM model sensed sensed: PLEXTOR CD-R   PREMIUM 1.06


Checking for SCSI emulation...
         Drive is ATAPI (using SCSI host adaptor emulation)

Checking for MMC style command set...
         Drive is MMC style
Verifying CDDA command set...
         Expected command set reads OK.
===

Nothing about the SG interface and no "Couldn't disable kernel command 
translation layer" bit therefore. It gives me the exact same times 
regular cdparanoia does; 15-25% user, 15-20% system. This might be 
expected; it seems not unlikely in fact that the SG_IO patch would only 
be expected to do something for usage through the IDE driver. Added Jens 
Axboe to the CC...

I rechecked that it does indeed make a difference for the IDE driver and 
it does. Almost immediate timeout/lockups again, as I reported once before:

http://lkml.org/lkml/2006/1/10/373

This does seem to be drive dependent -- I do not get this when ripping 
from my DVD-ROM drive (hdd, sr1). There is also no difference in times 
though between normal and patched cdparanoia on hdd, so as a summary of 
what this SG_IO patch is doing for me, "nothing useful" will do nicely.

Oh well; in any case, in the context of this pata test, no regressions!

Rene.

