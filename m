Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265408AbUAJWeT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 17:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265413AbUAJWeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 17:34:19 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:64151 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265408AbUAJWeS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 17:34:18 -0500
Date: Sat, 10 Jan 2004 14:34:12 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
Message-ID: <20040110223412.GC17845@matchmail.com>
Mail-Followup-To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-kernel@vger.kernel.org
References: <20040110013824.GA17845@matchmail.com> <Pine.LNX.4.44.0401101143280.2363-100000@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401101143280.2363-100000@poirot.grange>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 12:10:46PM +0100, Guennadi Liakhovetski wrote:
> On Fri, 9 Jan 2004, Mike Fedyk wrote:
> 
> > On Sat, Jan 10, 2004 at 01:38:00AM +0100, Guennadi Liakhovetski wrote:
> > > With 2.6 (on the server, same client) the client reads about 16K at a
> > > time, split into 11 fragments, and then packets number 9 and 10 get
> > > lost... This all with a StrongARM client and a PCMCIA network-card. With a
> > > PXA-client (400MHz compared to 200MHz SA) and an on-board eth smc91x, it
> > > gets the first 5 fragments, and then misses every other fragment. Again -
> > > in both cases I was copying files to RAM. Yes, 2.6 sends fragments in
> > > direct order.
> >
> > Is that an x86 server, and an arm client?
> 
> Yes. The reason for the problem seems to be the increased default size of
> the transfer unit of NFS from 2.4 to 2.6. 8K under 2.4 was still ok, 16K
> is too much - only the first 5 fragments pass fine, then data starts to
> get lost. If it is a hardware limitation (not all platforms can manage
> 16K), it should be probably set back to 8K. If the reason is that some
> buffer size was not increased correspondingly, then this should be done.
> 
> Just checked - mounting with rsize=8192,wsize=8192 fixes the problem -
> there are again 5 fragments and they all are received properly.

What version is the arm kernel you're running on the client, and where is it
from? 
