Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422889AbWBATUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422889AbWBATUJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 14:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422888AbWBATUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 14:20:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61967 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1422887AbWBATUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 14:20:07 -0500
Date: Wed, 1 Feb 2006 19:19:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "'Akinobu Mita'" <mita@miraclelinux.com>,
       Grant Grundler <iod00d@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 1/12] generic *_bit()
Message-ID: <20060201191957.GG3072@flint.arm.linux.org.uk>
Mail-Followup-To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	'Christoph Hellwig' <hch@infradead.org>,
	'Akinobu Mita' <mita@miraclelinux.com>,
	Grant Grundler <iod00d@hp.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	linux-ia64@vger.kernel.org
References: <20060201180237.GA18464@infradead.org> <200602011807.k11I7ag15563@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602011807.k11I7ag15563@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 10:07:28AM -0800, Chen, Kenneth W wrote:
> Christoph Hellwig wrote on Wednesday, February 01, 2006 10:03 AM
> > > Akinobu Mita wrote on Wednesday, January 25, 2006 7:29 PM
> > > > This patch introduces the C-language equivalents of the functions below:
> > > > 
> > > > - atomic operation:
> > > > void set_bit(int nr, volatile unsigned long *addr);
> > > > void clear_bit(int nr, volatile unsigned long *addr);
> > > > void change_bit(int nr, volatile unsigned long *addr);
> > > > int test_and_set_bit(int nr, volatile unsigned long *addr);
> > > > int test_and_clear_bit(int nr, volatile unsigned long *addr);
> > > > int test_and_change_bit(int nr, volatile unsigned long *addr);
> > > 
> > > I wonder why you did not make these functions take volatile
> > > unsigned int * address argument?
> > 
> > Because they are defined to operate on arrays of unsigned long
> 
> I think these should be defined to operate on arrays of unsigned int.
> Bit is a bit, no matter how many byte you load (8/16/32/64), you can
> only operate on just one bit.

Invalid assumption, from the point of view of endianness across different
architectures.  Consider where bit 0 is for a LE and BE unsigned long *
vs a LE and BE unsigned char *.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
