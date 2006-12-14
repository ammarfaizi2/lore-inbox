Return-Path: <linux-kernel-owner+w=401wt.eu-S932197AbWLNJ4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWLNJ4R (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 04:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWLNJ4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 04:56:17 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:17002 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932197AbWLNJ4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 04:56:16 -0500
Date: Thu, 14 Dec 2006 11:56:13 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Erik Andersen <andersen@codepoet.org>
Cc: Karsten Weiss <K.Weiss@science-computing.de>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory hole mapping related bug?!
Message-ID: <20061214095613.GJ6674@rhun.haifa.ibm.com>
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de> <20061213202925.GA3909@codepoet.org> <20061214092311.GC6674@rhun.haifa.ibm.com> <20061214095235.GA10208@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214095235.GA10208@codepoet.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 02:52:35AM -0700, Erik Andersen wrote:
> On Thu Dec 14, 2006 at 11:23:11AM +0200, Muli Ben-Yehuda wrote:
> > > I just realized that booting with "iommu=soft" makes my pcHDTV
> > > HD5500 DVB cards not work.  Time to go back to disabling the
> > > memhole and losing 1 GB.  :-(
> > 
> > That points to a bug in the driver (likely) or swiotlb (unlikely), as
> > the IOMMU in use should be transparent to the driver. Which driver is
> > it?
> 
> presumably one of cx88xx, cx88_blackbird, cx8800, cx88_dvb,
> cx8802, cx88_alsa, lgdt330x, tuner, cx2341x, btcx_risc,
> video_buf, video_buf_dvb, tveeprom, or dvb_pll.  It seems
> to take an amazing number of drivers to make these devices
> actually work...

Yikes! do you know which one actually handles the DMA mappings? I
suspect a missnig unmap or sync, which swiotlb requires to sync back
the bounce buffer with the driver's buffer.

Cheers,
Muli
