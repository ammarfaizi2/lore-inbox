Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWHLROP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWHLROP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWHLROO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:14:14 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:8591 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964921AbWHLRON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:14:13 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Edgar E. Iglesias" <edgar.iglesias@axis.com>
Subject: Re: 2.6.18-rc3-mm2 (+ hotfixes): GPF related to skge on suspend
Date: Sat, 12 Aug 2006 19:13:01 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>, netdev@vger.kernel.org
References: <200608121207.42268.rjw@sisk.pl> <200608121631.18603.rjw@sisk.pl> <20060812161253.GA30691@edgar.underground.se.axis.com>
In-Reply-To: <20060812161253.GA30691@edgar.underground.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608121913.01139.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 August 2006 18:12, Edgar E. Iglesias wrote:
> On Sat, Aug 12, 2006 at 04:31:18PM +0200, Rafael J. Wysocki wrote:
> > On Saturday 12 August 2006 14:28, Andrew Morton wrote:
> > > On Sat, 12 Aug 2006 12:07:42 +0200
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > 
> > > > Hi,
> > > > 
> > > > On 2.6.18-rc3-mm2 with hotfixes I get things like the appended one on attempts
> > > > to suspend to disk.  It occurs while devices are being suspended and is fairly
> > > > reproducible.
> > > > 
> > > > Greetings,
> > > > Rafael
> > > > 
> > > > 
> > > > Suspending device 0000:01:00.0
> > > > Suspending device 0000:02:02.0
> > > > Suspending device 0000:02:01.4
> > > > Suspending device 0000:02:01.3
> > > > Suspending device 0000:02:01.2
> > > > Suspending device 0000:02:01.1
> > > > Suspending device 0000:02:01.0
> > > > Suspending device 0000:02:00.0
> > > > skge Ram read data parity error
> > > > skge Ram write data parity error
> > > > skge eth0: receive queue parity error
> > > > skge <NULL>: receive queue parity error
> > 
> > This stuff comes from the interrupt handler which apparently races with
> > something.
> 
> Maybe the skge driver is not doing netif_poll_disable before clearing the rx 
> ring at suspend/down?

Apparently it doesn't.

At least netif_poll_disable is not referenced anywhere in skge.c .

Greetings,
Rafael
