Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbVHIXOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbVHIXOI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 19:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbVHIXOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 19:14:08 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:30880 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750967AbVHIXOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 19:14:06 -0400
Date: Wed, 10 Aug 2005 01:13:57 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Bodo Eggert <7eggert@gmx.de>, LKML <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: Regression: radeonfb: No synchronisation on CRT with linux-2.6.13-rc5
In-Reply-To: <Pine.LNX.4.58.0508092140030.2096@be1.lrz>
Message-ID: <Pine.LNX.4.58.0508100113100.2027@be1.lrz>
References: <Pine.LNX.4.58.0508040103100.2220@be1.lrz>  <1123195493.30257.75.camel@gaston>
  <Pine.LNX.4.58.0508051935570.2326@be1.lrz>  <1123401069.30257.102.camel@gaston>
  <3EF2003B-12DF-4EBB-B304-59614AEFAA09@mac.com>  <Pine.LNX.4.58.0508071921540.3495@be1.lrz>
  <1123451289.30257.118.camel@gaston>  <Pine.LNX.4.58.0508080158520.7822@be1.lrz>
 <1123489200.30257.133.camel@gaston> <Pine.LNX.4.58.0508092140030.2096@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2005, Bodo Eggert wrote:
> On Mon, 8 Aug 2005, Benjamin Herrenschmidt wrote:
> > On Mon, 2005-08-08 at 02:06 +0200, Bodo Eggert wrote:

> > > The wrong values are constant across reboots (see my first mail), and I 
> > > have a CRT.
> > > 
> > > Can you tell me where the timing values are read?
> > 
> > radeon_write_mode() programs the mode. The monitor timing infos are read
> > by the various bits of code in radeon_monitor.c
> > 
> > I'd be curious if you could identify what bit of code is misbehaving
> 
> I added preempt_*able around radeon_probe_i2c_connector, and now I get the 
> output from below and still no sync. Obviously you shouldn't msleep in 
> preempt-disabled code. I'll try voluntary preemption, but that will at 
> best hide the error.

Update: voluntary preemption does not cause bad readings.
-- 
Who is General Failure and why is he reading my disk? 
