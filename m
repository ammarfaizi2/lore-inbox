Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUDBOnC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 09:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264059AbUDBOnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 09:43:02 -0500
Received: from tench.street-vision.com ([212.18.235.100]:54435 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id S264058AbUDBOm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 09:42:56 -0500
Subject: Re: [PATCH] libata transport attributes
From: Justin Cormack <justin@street-vision.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>,
       mort@wildopensource.com
In-Reply-To: <406C5B0F.4020104@pobox.com>
References: <1080752942.27347.43.camel@lotte.street-vision.com>
	 <406B3313.3080607@pobox.com>
	 <1080820605.30218.14.camel@lotte.street-vision.com>
	 <406C5B0F.4020104@pobox.com>
Content-Type: text/plain
Message-Id: <1080916817.30722.135.camel@lotte.street-vision.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 02 Apr 2004 15:40:17 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-01 at 19:10, Jeff Garzik wrote:
> Justin Cormack wrote:
> > On Wed, 2004-03-31 at 22:07, Jeff Garzik wrote:
> > 
> > 
> >>Did you see the comments I posted WRT mort's patch?
> >>
> > 
> > 
> > oops, no I missed his patch and your comments until now.
> > 
> > 
> >>Since libata is leaving SCSI in 2.7, I would rather not add superfluous 
> >>stuff like this at all.
> >>
> > 
> > 
> > I didnt know this.
> > 
> > 
> >>Further, you can already retrieve the information you export with _zero_ 
> >>new code.
> > 
> > 
> > How? Sorry to be dumb...
> 
> Obtain the SCSI inquiry info from userspace...

I looked at doing this, but unfortunately this doesnt work due to
incompatibilities between the SCSI and ATA way of doing things. The ATA
product ids are truncated from 20 chars to 16 (there is no separate
vendor ID so both are effectively combined into one field with arbitrary
layout). The product revision level is only 4 bytes in scsi, unlike the
8 byte firmware revision in ATA. You can get the serial number though.

Currently you use ATA as vendor id, I will quite happily patch libata to
stick the whole ATA identify into some EVPD scsi inquiry pages as vendor
specific info and write a userspace tool to parse it if you would
rather. Thats much easier to junk when you move out of scsi-world and
presumably start to export native sysfs info.

Justin


