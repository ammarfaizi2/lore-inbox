Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUF1AZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUF1AZF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 20:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbUF1AZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 20:25:05 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:11762 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S264571AbUF1AZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 20:25:00 -0400
Date: Sun, 27 Jun 2004 19:24:34 -0500
From: Erik Jacobson <erikj@subway.americas.sgi.com>
To: Chris Wedgwood <cw@f00f.org>
cc: Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Andrew Morton <akpm@osdl.org>, Pat Gefre <pfg@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
In-Reply-To: <20040626235248.GC12761@taniwha.stupidest.org>
Message-ID: <Pine.SGI.4.53.0406271908390.524706@subway.americas.sgi.com>
References: <Pine.SGI.3.96.1040623094239.19458C-100000@fsgi900.americas.sgi.com>
 <20040623143801.74781235.akpm@osdl.org> <200406231754.56837.jbarnes@engr.sgi.com>
 <Pine.SGI.4.53.0406242153360.343801@subway.americas.sgi.com>
 <20040625083130.GA26557@infradead.org> <Pine.SGI.4.53.0406250742350.377639@subway.americas.sgi.com>
 <20040625124807.GA29937@infradead.org> <Pine.SGI.4.53.0406250751470.377692@subway.americas.sgi.com>
 <20040626235248.GC12761@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jun 25, 2004 at 08:00:24AM -0500, Erik Jacobson wrote:
>
> > I certainly had failed registrations when I tried to "share" ttyS0.
> It's not clear to my why you can't use ttyS0, ttyS1, etc. since those
> will probably not be used on Altix.

Maybe you can help me clear it up then.  When I feed serial core the
name ttyS with TTY_MAJOR and minor 64, the registration fails.
If I disable 8250 in the kernel config, the registration works for us.
What should we try?

Please let me know if I'm missing something and if I should try something
different.  Any way out of this catch 22 would be good as far as we're
concerned.  So if we over-looked something, that's great.  Just let us know
what we need to try.

It seems you're attacking the patch from these angles.  I'll summerize
the issues with each.

1) You think we can some how use ttySX with our driver.  I need more
   information for that as I couldn't get it to work with serial core.

2) You think we should only use a major/minor if it's registered, but
   our attempts to register it aren't getting anywhere.  Is there a way
   around this problem?

3) You suggest we share with the major of pa/risc console driver.  This is
   fine, but the agreement to possibly share some day was based on LANANA
   accepting it.  LANANA has been unresponsive, so this doesn't help us.

4) You think we should enable dynamic minors only -- but that would make our
   driver not work properly on most current distros due to the timing of
   when the console is opened vs when the "dev" is populated.  Indeed, this
   would put is in a worse spot than where we are today.

--
Erik Jacobson - Linux System Software - Silicon Graphics - Eagan, Minnesota
