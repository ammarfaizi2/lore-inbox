Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268679AbUHTUBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268679AbUHTUBb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268057AbUHTUBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:01:31 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:3992 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S268679AbUHTUAt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:00:49 -0400
Date: Fri, 20 Aug 2004 15:53:02 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: "David S. Miller" <davem@redhat.com>
Cc: root@chaos.analogic.com, adilger@clusterfs.com, shemminger@osdl.org,
       alan@lxorguk.ukuu.org.uk, tytso@mit.edu, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] enhanced version of net_random()
Message-ID: <20040820195302.GK5806@certainkey.com>
References: <20040812104835.3b179f5a@dell_ss3.pdx.osdl.net> <20040820175952.GI5806@certainkey.com> <20040820185956.GV8967@schnapps.adilger.int> <Pine.LNX.4.53.0408201518250.25319@chaos> <20040820124823.071ac1d9.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820124823.071ac1d9.davem@redhat.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If speed is what you want, and you want a period > 2^N.

Then a single get_rand_bytes() to fill a seed of a simple LFSR might do.

Seed value will be N+1 bits long.

Rochard's PRNG does not have a period > 2^32, that's for sure.

JLC

On Fri, Aug 20, 2004 at 12:48:23PM -0700, David S. Miller wrote:
> On Fri, 20 Aug 2004 15:22:09 -0400 (EDT)
> "Richard B. Johnson" <root@chaos.analogic.com> wrote:
> 
> > The attached code will certainly work on Intel machines. It is
> > in the public domain, having been modified by myself to produce
> > a very long sequence...
> 
> How long a period does it have?  The one we're adding to the
> networking has one which is 2^88.
> 
> > I wouldn't suggest converting it to 'C' because the rotation
> > takes many CPU instructions when one tries to do the test, shift,
> > and OR in 'C',
> 
> You only need 2 'shifts' and an 'or' to do a rotate in C.
> No tests are needed.
