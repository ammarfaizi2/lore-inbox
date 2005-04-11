Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVDKPm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVDKPm7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 11:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVDKPm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 11:42:57 -0400
Received: from unthought.net ([212.97.129.88]:38064 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261820AbVDKPmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 11:42:15 -0400
Date: Mon, 11 Apr 2005 17:42:11 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Greg Banks <gnb@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make sense
Message-ID: <20050411154211.GG13369@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Greg Banks <gnb@sgi.com>, linux-kernel@vger.kernel.org
References: <20050407153848.GN347@unthought.net> <1112890671.10366.44.camel@lade.trondhjem.org> <20050409213549.GW347@unthought.net> <1113083552.11982.17.camel@lade.trondhjem.org> <20050411074806.GX347@unthought.net> <1113222939.14281.17.camel@lade.trondhjem.org> <20050411134703.GC13369@unthought.net> <1113230125.9962.7.camel@lade.trondhjem.org> <20050411144127.GE13369@unthought.net> <1113232905.9962.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1113232905.9962.15.camel@lade.trondhjem.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 11:21:45AM -0400, Trond Myklebust wrote:
> må den 11.04.2005 Klokka 16:41 (+0200) skreiv Jakob Oestergaard:
> 
> > > That can mean either that the server is dropping fragments, or that the
> > > client is dropping the replies. Can you generate a similar tcpdump on
> > > the server?
> > 
> > Certainly;  http://unthought.net/sparrow.dmp.bz2
> 
> So, it looks to me as if "sparrow" is indeed dropping packets (missed
> sequences). Is it running with NAPI enabled too?

Yes, as far as I know - the Broadcom Tigeon3 driver does not have the
option of enabling/disabling RX polling (if we agree that is what we're
talking about), but looking in tg3.c it seems that it *always*
unconditionally uses NAPI...

sparrow:~# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:09:3D:10:BB:1E
          inet addr:10.0.1.20  Bcast:10.0.1.255  Mask:255.255.255.0
          inet6 addr: fe80::209:3dff:fe10:bb1e/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2304578 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2330829 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:2381644307 (2.2 GiB)  TX bytes:2191756317 (2.0 GiB)
          Interrupt:169

No dropped packets... I wonder if the tg3 driver is being completely
honest about this...

Still, 2.4 manages to perform twice as fast against the same server.

And, the 2.6 client still has extremely heavy CPU usage (from rpciod
mainly, which doesn't show up in profiles)

The plot thickens...

Trond (or anyone else feeling they might have some insight they would
like to share on this one), I'll do anything you say (ok, *almost*
anything you say) - any ideas?


-- 

 / jakob

