Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264006AbUDFUv6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264007AbUDFUv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:51:57 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:5567 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264006AbUDFUvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:51:25 -0400
Date: Tue, 6 Apr 2004 21:48:43 +0100
From: Dave Jones <davej@redhat.com>
To: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
Cc: Bjoern Michaelsen <bmichaelsen@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: AGP problem SiS 746FX Linux 2.6.5-rc3
Message-ID: <20040406204843.GC1100@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>,
	Bjoern Michaelsen <bmichaelsen@gmx.de>,
	linux-kernel@vger.kernel.org
References: <20040406031949.GA8351@lord.sinclair> <200404062206.38731.volker.hemmann@heim10.tu-clausthal.de> <20040406203122.GB1100@redhat.com> <200404062237.02210.volker.hemmann@heim10.tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404062237.02210.volker.hemmann@heim10.tu-clausthal.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 10:37:02PM +0200, Hemmann, Volker Armin wrote:

 >         Capabilities: [c0] AGP version 3.0

Ok, so your system is fully AGP v3 compliant, (both host and gfx card).
The missing check highlighted in your diff means that we only do
AGPv3 stuff if we have an AGP 3.5 host bridge. You have a 3.0 bridge,
so it was falling back to AGP v2.  My suspicion now is that the 648 and
746 chipsets vary too much for them to both use the generic routines,
so I'll reinstate the check.  It'll still report that it finds an
AGP v3.0 device, but until someone comes forward with chipset docs,
it looks like it'll be limited to AGP v2. (I'm amazed that it works
at all, really).

It survives a testgart run too ?

		Dave

