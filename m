Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWIRS7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWIRS7u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 14:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWIRS7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 14:59:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10445 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932218AbWIRS7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 14:59:48 -0400
Date: Mon, 18 Sep 2006 19:59:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>
Subject: Re: [PATCH] libsas: move ATA bits into a separate module
Message-ID: <20060918185924.GC17670@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@us.ibm.com>,
	linux-scsi <linux-scsi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alexis Bruemmer <alexisb@us.ibm.com>,
	Mike Anderson <andmike@us.ibm.com>
References: <4508A0A2.2080605@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4508A0A2.2080605@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 05:21:54PM -0700, Darrick J. Wong wrote:
> Hi all,
> 
> Per James Bottomley's request, I've moved all the libsas SATA support
> code into a separate module, named sas_ata.  To satisfy his further
> requirement that libsas not require libata (and vice versa), ata_sas
> maintains fixed function pointer tables to various required functions
> within libsas and libata.  Unfortunately, this means that libsas and
> libata both require sas_ata, but sas_ata is smaller than libata.
> Unloads of libata/libsas at inopportune moments are prevented by
> increasing the refcounts on both modules whenever libsas detects a SATA
> device (and decreasing it when the device goes away, of course).  If the
> module is removed from the .config, then all of hooks into libsas/libata
> should go away.
> 
> This is a rough-cut at separating out the ATA code; please let me know
> what I can improve.  At the moment, I can load and talk to SATA disks
> with the module enabled, as well as watch nothing happen if the module
> is not config'd in.

I think this while idea is flawed.  Please separate out the ATA code
so it can be compiled out whelibata isn't built in, but it defintly
shouldn't be a separate module.  We're not doing any complexity like
that in any other subsystem (we used to do for AGP but got rid of it
again because it caused lots of problems).
