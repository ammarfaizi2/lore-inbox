Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263317AbTEMR5a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTEMR5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:57:06 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:34548 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262383AbTEMR4H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:56:07 -0400
Date: Tue, 13 May 2003 11:11:06 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: akpm@diego.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030513181106.GB1626@beaverton.ibm.com>
Mail-Followup-To: James Bottomley <James.Bottomley@steeleye.com>,
	akpm@diego.com, Linux Kernel <linux-kernel@vger.kernel.org>
References: <1052845953.6663.23.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052845953.6663.23.camel@mulgrave>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley [James.Bottomley@steeleye.com] wrote:
> For SCSI, as far as the basics go we still have
> 
> Need to convert to DMA-mapping:
> 
> 	am53c974 dpt_i2o initio pci2220i
> 
> Don't compile currently:
> 
> 	inia100 cpqfc pci2000 dc390t
> 
> Need converting to the new eh:
> 
> 	wd33c99 based: a2091 a3000 gpv11 mvme174 sgiwd93 
> 	53c7xx based: amiga7xxx bvme6000 mvme16x
> 	initio am53c974 pci2000 pci2220i qla1280 sym53c8xx dc390t
> 
> I think the sym53c8xx could probably be pulled out of the tree because
> the sym_2 replaces it.  I'm also looking at converting the qla1280.
> 

I would vote for sym_2 replacement. I have bug 647 that fails on
sym53c8xx but works on sym_2. The bug still has a rmmod problem which
maybe cleaned up with the cleanups in scsi-misc.

> It also might be possible to shift the 53c7xx based drivers over to
> 53c700 which does the new EH stuff, but I don't have the hardware to
> check such a shift.
> 
> For the non-compiling stuff, I've probably missed a few that just aren't
> compilable on my platforms, so any updates would be welcome.  Also, are
> some of our non-compiling or unconverted drivers obsolete?


I have the following not covered by your list above

qlogicisp (isp1020) - Convert to new eh and other issues. Could be
covered by feral driver, but status unclear of inclusion of feral.
Bug 140.

iph5526.c - Compile failure. Bug 201.

ini9100u.c - DMA-mapping conversion. Bug 213.

tmscsim.c - Compile failure. Bug 219.

AM53C974.c - Compile failure Bug 220.


An issue on fixing some of these is that lack of hardware,
documentation, or maintainer makes verification beyond compile difficult
(and just compile testing could lead to hidden data issues).

-andmike
--
Michael Anderson
andmike@us.ibm.com

