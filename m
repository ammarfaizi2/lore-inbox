Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267372AbUITVxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267372AbUITVxw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 17:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267374AbUITVxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 17:53:52 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:61136 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S267372AbUITVxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 17:53:48 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: device driver for the SGI system clock, mmtimer
Date: Mon, 20 Sep 2004 15:53:29 -0600
User-Agent: KMail/1.7
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel@vger.kernel.org, Bob Picco <Robert.Picco@hp.com>,
       venkatesh.pallipadi@intel.com, Andrew Morton <akpm@osdl.org>
References: <200409161003.39258.bjorn.helgaas@hp.com> <20040916181426.GA5052@ucw.cz> <Pine.LNX.4.58.0409161142570.7453@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409161142570.7453@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409201553.29824.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 September 2004 12:46 pm, Christoph Lameter wrote:
> On Thu, 16 Sep 2004, Vojtech Pavlik wrote:
> > mmtimer and hpet are the same hardware actually, just a different
> > specification revision, hpet being the newer one.
> 
> Its basically the same software API but different hardware.

OK, I guess I'm convinced that the SGI mmtimer and the HPET
really are different things.  It looks like the counter resolution,
frequency, and size (which are all described in the HPET register
set) are either compiled into mmtimer or discovered via special-
purpose SGI hooks.

So maybe it's not really a good thing to integrate mmtimer and
hpet.  Apps that mmap the HPET will be expecting a certain register
layout that mmtimer doesn't support.

I was confused because your mmtimer patch mentions the Intel
spec, and the driver identifies itself as "IA-PC Multimedia Timer".
My vote would be to leave mmtimer alone, and perhaps remove the
references to the Intel spec and change the driver ident string.
After all, it doesn't really implement very much of the HPET
functionality, and I don't think the Intel spec says anything
that relates to the SGI hardware.
