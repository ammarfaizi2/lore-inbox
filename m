Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265370AbUAAKbY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 05:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265391AbUAAKbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 05:31:24 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:18836 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S265370AbUAAKbX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 05:31:23 -0500
Date: Thu, 1 Jan 2004 05:27:27 -0500
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-mm2] e100 driver hangs after period of moderate receive load
Message-ID: <20040101102727.GA1427@gnu.org>
References: <20031231110209.GA9858@gnu.org> <3FF2BCDE.5010302@pobox.com> <20031231122155.GA13323@gnu.org> <3FF2C266.8010104@pobox.com> <Pine.LNX.4.58.0312312115120.3069@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312312115120.3069@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: Lennert Buytenhek <buytenh@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 09:21:56PM -0500, Thomas Molina wrote:

> [hangs on e100 under moderate receive load]
> > > Yes, NAPI was indeed enabled.
> > > 
> > > I 'went back' to 2.6.1-rc1 and that seems fine now.  Any patches you want
> > > me to try on top of 2.6.0-mm2?
> > 
> > Well, the two are vastly different, since -mm2 includes a complete 
> > rewrite of e100.
> > 
> > Does disabling NAPI in -mm2 change anything?
> 
> I have one of these beasts so I decided to test it after seeing this 
> message.  2.6.0-mm2 NAPI enabled and I am not seeing any of the symptoms 
> described here.  My test consists of downloading an iso from RedHat's ftp 
> site.  I'm not sure that is generating the kind of traffic you are talking 
> about, but I'm open to suggestions on what test to run trying to duplicate 
> what is being reported.

Make sure you have slab debugging enabled to see if you also get the slab
corruption messages, and then hit the machine with anything above 50000
packets per second.  pktgen from a different machine on the same subnet
works nicely for that.  I doubt that downloading a Red Hat iso would give
you a load anywhere near that.

Oh, do you have an SMP box?  This was on a 2-way (4-way HT) SMP box.  Not
sure if that matters here.

I'm just about to try 2.6.0-mm2 without NAPI.


--L
