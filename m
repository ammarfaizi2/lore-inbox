Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVBBWBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVBBWBM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 17:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbVBBV7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 16:59:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53976 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262811AbVBBV5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 16:57:18 -0500
Date: Wed, 2 Feb 2005 21:57:16 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Patrick Gefre <pfg@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       matthew@wil.cx, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] Altix : ioc4 serial driver support
Message-ID: <20050202215716.GA23253@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
	matthew@wil.cx, B.Zolnierkiewicz@elka.pw.edu.pl
References: <20050103140938.GA20070@infradead.org> <Pine.SGI.3.96.1050131164059.62785B-100000@fsgi900.americas.sgi.com> <20050201092335.GB28575@infradead.org> <420139BF.4000100@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420139BF.4000100@sgi.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 02:36:15PM -0600, Patrick Gefre wrote:
> >Please kill ioc4_ide_init as it's completely unused and make 
> >ioc4_serial_init
> >a normal module_init() handler in ioc4_serial, there's no need to call
> >them from the generic driver.
> >
> 
> I want ioc4_serial_init called before pci_register_driver() if I make it a
> module_init() call I have no control over order ??

For the modular case it'd always be executed before because the module
must be loaded first, for the builtin case it'd depend on the link order.

Let's leave it as-is, it's probably safer.

> >Do you need to use ide_pci_register_driver?  IOC4 doesn't have the legacy
> >IDE problems, and it's never used together with such devices in a system,
> >so a plain pci_register_driver should do it.
> >
> 
> So ide_pci_register_driver is only for legacy devices with certain IDE
> problems - I think that is what you are saying (just trying to make sure
> I have it right) ??

Yes.

