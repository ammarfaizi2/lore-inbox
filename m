Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264994AbTIDNai (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 09:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265000AbTIDNah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 09:30:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56082 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264994AbTIDNaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 09:30:35 -0400
Date: Thu, 4 Sep 2003 14:30:30 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: "David S. Miller" <davem@redhat.com>, hch@lst.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-ID: <20030904143030.C8414@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	"David S. Miller" <davem@redhat.com>, hch@lst.de,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20030903203231.GA8772@lst.de> <16214.34933.827653.37614@nanango.paulus.ozlabs.org> <20030904071334.GA14426@lst.de> <20030904083007.B2473@flint.arm.linux.org.uk> <16215.1054.262782.866063@nanango.paulus.ozlabs.org> <20030904023624.592f1601.davem@redhat.com> <20030904104801.A7387@flint.arm.linux.org.uk> <16215.14133.352143.660688@nanango.paulus.ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16215.14133.352143.660688@nanango.paulus.ozlabs.org>; from paulus@samba.org on Thu, Sep 04, 2003 at 10:59:33PM +1000
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 10:59:33PM +1000, Paul Mackerras wrote:
> > 2. The resource tree won't know about the upper bits or whatever sitting
> >    in flags, and as such identical addresses on two different buses will
> >    clash.
> > 
> > Resource start,end needs to be some unique quantity no matter which (PCI)
> > bus you are on.
> 
> They are non-overlapping for PCI buses in the same domain.  Perhaps
> the sensible thing is to have a separate resource tree for each PCI
> domain (actually two trees, for I/O and memory space), and have them
> contain bus addresses rather than physical addresses.  I don't know if
> the generic iomem_resource and ioport_resource are still useful if we
> do that.

I thought I pointed out that this approach would break request_region
and request_mem_region, which are the work-horses of the "this region
of space is busy".

Someone would have to (somehow) fix up all drivers which use those
functions...

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core


