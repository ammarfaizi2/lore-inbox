Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266417AbTATQvJ>; Mon, 20 Jan 2003 11:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266411AbTATQvJ>; Mon, 20 Jan 2003 11:51:09 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:13768 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266384AbTATQvH>;
	Mon, 20 Jan 2003 11:51:07 -0500
Date: Mon, 20 Jan 2003 16:56:38 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: propagating failures down to pci_module_init()
Message-ID: <20030120165638.GA31809@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jeff Garzik <jgarzik@pobox.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030120155435.GA29238@codemonkey.org.uk> <20030120163321.A32585@infradead.org> <20030120165236.GA27972@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030120165236.GA27972@gtf.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 11:52:36AM -0500, Jeff Garzik wrote:
 > 
 > Nope.  Look at pci_module_init code.  It propagates pci_register_driver
 > return value.
 > 
 > The _real_ problem is that ->probe return value is not propagated back
 > to pci_register_driver return value.  The reason for this is that you
 > may call ->probe many times, and nobody has written the code to collate
 > the error returns.
 > 
 > Since one can only sanely return an error code when there was _one_
 > device and it failed, you are rather limited in error propagation.

*nod*. I cheated, and used a static global, which seems to get the
desired effect I was after.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
