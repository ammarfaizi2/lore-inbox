Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267552AbUHEFoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267552AbUHEFoJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 01:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267554AbUHEFoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 01:44:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29072 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267552AbUHEFoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 01:44:05 -0400
Date: Thu, 5 Aug 2004 07:43:54 +0200
From: Jens Axboe <axboe@suse.de>
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.enemy.org>
Cc: linux-kernel@vger.kernel.org, schilling@fokus.fraunhofer.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040805054354.GD10376@suse.de>
References: <20040804124335.GK10340@suse.de> <200408050025.i750P3Li010082@wildsau.enemy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408050025.i750P3Li010082@wildsau.enemy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05 2004, H.Rosmanith (Kernel Mailing List) wrote:
> > > + * Sat Jun 12 12:48:12 CEST 2004 herp - Herbert Rosmanith
> > > + *     Force ATAPI driver if dev= starts with /dev/hd and device
> > > + *     is present in /proc/ide/hdX
> > > + *
> > 
> > That's an extremely bad idea, you want to force ATA driver in either
> > case.
> 
> I don't think so.
> 
> If "dev=/dev/hd?" and "/dev/hd?" is *not* present in /proc/ide, then
> cdrtools falls back to the default behaviour, which is: treat it as
> scsi device.
> 
> If the device cannot be found in /proc/ide, it simply does not make sense
> to treat it as atapi device - because it is none.

ATA method is misnamed, it's really SG_IO that is used. And you want to
use that regardless of the device type, SCSI or ATAPI. There's no such
thing as an ATA burner, and there's no need to differentiate between
SCSI or ATAPI CD-ROM's when burning - SG_IO is the method to use. So
forget browsing /proc/ide and other hacks.

-- 
Jens Axboe

