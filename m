Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264584AbUF1Aek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264584AbUF1Aek (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 20:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264578AbUF1Aek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 20:34:40 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:12697 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264584AbUF1Aei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 20:34:38 -0400
Date: Sun, 27 Jun 2004 17:33:11 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Erik Jacobson <erikj@subway.americas.sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Andrew Morton <akpm@osdl.org>, Pat Gefre <pfg@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
Message-ID: <20040628003311.GA23017@taniwha.stupidest.org>
References: <Pine.SGI.3.96.1040623094239.19458C-100000@fsgi900.americas.sgi.com> <20040623143801.74781235.akpm@osdl.org> <200406231754.56837.jbarnes@engr.sgi.com> <Pine.SGI.4.53.0406242153360.343801@subway.americas.sgi.com> <20040625083130.GA26557@infradead.org> <Pine.SGI.4.53.0406250742350.377639@subway.americas.sgi.com> <20040625124807.GA29937@infradead.org> <Pine.SGI.4.53.0406250751470.377692@subway.americas.sgi.com> <20040626235248.GC12761@taniwha.stupidest.org> <Pine.SGI.4.53.0406271908390.524706@subway.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.53.0406271908390.524706@subway.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2004 at 07:24:34PM -0500, Erik Jacobson wrote:

> Maybe you can help me clear it up then.  When I feed serial core the
> name ttyS with TTY_MAJOR and minor 64, the registration fails.  If I
> disable 8250 in the kernel config, the registration works for us.

I'm not sure why the 8250 code reserves/registers ttyS0 on Altix when
do such hardware exists.  I vaguely recall patching it to prevent this
in a hacky way.

I would like to know why the 8250 code is registering a driver for
hardware that doesn't exist and see that fixed.

> 1) You think we can some how use ttySX with our driver.  I need more
>    information for that as I couldn't get it to work with serial
>    core.

You can, I did this.  It was probably a horrible hack, I really can't
recall anymore.  I don't know if that code ever got out or what
happened to it.  Maybe there are some PVs about it somewhere?  I'm
pretty sure the patches got sent out for vendor inclusion.

I would simply find out why the 8250 driver is preventing a
registration for you and go down that path.

The other issue is what if someone puts a serial-port/modem card in an
Altix so you do have 8250/16550-like hardware?  I'm not sure that's
sensible though and they probably deserves to break.

I guess in general you have a bigger problem though, you can have tens
of serial ports on a large system and if you want to support them all
(or have the option of doing so) something more sensible needs to be
figure out.


  --cw
