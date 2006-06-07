Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWFGOwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWFGOwZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 10:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWFGOwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 10:52:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51118 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932244AbWFGOwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 10:52:24 -0400
Date: Wed, 7 Jun 2006 15:52:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 4/4] Make Emulex lpfc driver legacy I/O port free
Message-ID: <20060607145203.GA13951@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Greg KH <greg@kroah.com>, akpm@osdl.org,
	Rajesh Shah <rajesh.shah@intel.com>,
	Grant Grundler <grundler@parisc-linux.org>,
	"bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@atrey.karlin.mff.cuni.cz
References: <4484263C.1030508@jp.fujitsu.com> <20060606075812.GB19619@kroah.com> <448643B9.2080805@jp.fujitsu.com> <448644D6.9030907@jp.fujitsu.com> <20060607082448.GA31004@infradead.org> <4486C537.9040105@jp.fujitsu.com> <20060607124353.GA31777@infradead.org> <4486D070.2020806@jp.fujitsu.com> <20060607134034.GA4744@infradead.org> <4486DAF7.4040101@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4486DAF7.4040101@jp.fujitsu.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 10:56:07PM +0900, Kenji Kaneshige wrote:
> Christoph Hellwig wrote:
> >On Wed, Jun 07, 2006 at 10:11:12PM +0900, Kenji Kaneshige wrote:
> >
> >>I mean the right order is
> >>
> >>  (1) pci_request_regions()
> >>  (2) pci_enable_device*()
> >
> >
> >no, pci_enable_device should be first.
> >
> >
> 
> I had the same wrong assumption before. But to prevent two
> devices colliding on the same address range, pci_request_regions()
> should be called first. Please see the following discussions:

No.  That's what the pci_driver matching is for.  Without pci_enable_device
pci_request_regions could do the wrong thing when fixups aren't run.

