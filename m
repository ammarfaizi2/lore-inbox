Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWDEWCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWDEWCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 18:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWDEWCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 18:02:05 -0400
Received: from mail21.bluewin.ch ([195.186.18.66]:47239 "EHLO
	mail21.bluewin.ch") by vger.kernel.org with ESMTP id S932092AbWDEWCD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 18:02:03 -0400
Date: Thu, 6 Apr 2006 00:01:18 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Andrew Morton <akpm@osdl.org>
Cc: zlynx@acm.org, linux-kernel@vger.kernel.org, linville@tuxdriver.com
Subject: Re: 2.6.17-rc1-mm1
Message-ID: <20060405220117.GB15748@k3.hellgate.ch>
References: <20060404014504.564bf45a.akpm@osdl.org> <1144187618.26812.7.camel@localhost> <20060404150953.41d7e04e.akpm@osdl.org> <20060405070150.GA10351@k3.hellgate.ch> <20060405002909.2ab4482b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060405002909.2ab4482b.akpm@osdl.org>
X-Operating-System: Linux 2.6.16 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2006 00:29:09 -0700, Andrew Morton wrote:
> Roger Luethi <rl@hellgate.ch> wrote:
> >
> > Any suggestions for an elegant solution?
> 
> Move the locking down lower, so it just locks the stuff which needs locking?
> 
> It all depends on what the lock's role is, and so often that's a big secret.

Indeed.

Over a dozen drivers now use calls like mii_ethtool_gset or
generic_mii_ioctl, and only one (sis190) makes the call without grabbing
the lock to the driver private data.

Pushing that lock down is not something I'd do lightly.

> If the intention is to prevent concurrent execution of mdio_read()
> (reasonable) and we really need that 1 msec delay between writing the

I'm afraid that delay is not negotiable -- unless we want to go back to
polling the chip for link state changes.

Roger
