Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWHLQM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWHLQM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 12:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWHLQM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 12:12:56 -0400
Received: from miranda.se.axis.com ([193.13.178.8]:44458 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S964877AbWHLQM4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 12:12:56 -0400
Date: Sat, 12 Aug 2006 18:12:53 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@axis.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>, netdev@vger.kernel.org
Subject: Re: 2.6.18-rc3-mm2 (+ hotfixes): GPF related to skge on suspend
Message-ID: <20060812161253.GA30691@edgar.underground.se.axis.com>
References: <200608121207.42268.rjw@sisk.pl> <20060812052853.f9e5d648.akpm@osdl.org> <200608121631.18603.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608121631.18603.rjw@sisk.pl>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 04:31:18PM +0200, Rafael J. Wysocki wrote:
> On Saturday 12 August 2006 14:28, Andrew Morton wrote:
> > On Sat, 12 Aug 2006 12:07:42 +0200
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > Hi,
> > > 
> > > On 2.6.18-rc3-mm2 with hotfixes I get things like the appended one on attempts
> > > to suspend to disk.  It occurs while devices are being suspended and is fairly
> > > reproducible.
> > > 
> > > Greetings,
> > > Rafael
> > > 
> > > 
> > > Suspending device 0000:01:00.0
> > > Suspending device 0000:02:02.0
> > > Suspending device 0000:02:01.4
> > > Suspending device 0000:02:01.3
> > > Suspending device 0000:02:01.2
> > > Suspending device 0000:02:01.1
> > > Suspending device 0000:02:01.0
> > > Suspending device 0000:02:00.0
> > > skge Ram read data parity error
> > > skge Ram write data parity error
> > > skge eth0: receive queue parity error
> > > skge <NULL>: receive queue parity error
> 
> This stuff comes from the interrupt handler which apparently races with
> something.

Maybe the skge driver is not doing netif_poll_disable before clearing the rx 
ring at suspend/down?

Best regards
-- 
        Programmer
        Edgar E. Iglesias <edgar.iglesias@axis.com> 46.46.272.1946
