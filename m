Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266104AbUA1RAf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 12:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266100AbUA1RAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 12:00:35 -0500
Received: from palrel12.hp.com ([156.153.255.237]:18095 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S266074AbUA1RAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 12:00:33 -0500
Date: Wed, 28 Jan 2004 09:01:53 -0800
From: Grant Grundler <iod00d@hp.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Hironobu Ishii <ishii.hironobu@jp.fujitsu.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>
Subject: Re: [RFC/PATCH, 2/4] readX_check() performance evaluation
Message-ID: <20040128170153.GA5494@cup.hp.com>
References: <00a301c3e541$c13a6350$2987110a@lsd.css.fujitsu.com> <Pine.LNX.4.58.0401271847440.10794@home.osdl.org> <20040128085825.A3591@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040128085825.A3591@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 08:58:25AM +0000, Russell King wrote:
> On Tue, Jan 27, 2004 at 06:55:17PM -0800, Linus Torvalds wrote:
> > Does anybody see any downsides to something like this?
> 
> What if the failing PCI access happened in an interrupt routine?
> (I'm thinking of the situation where you may need to read the PCI
> status registers to find out whether an error occurred.)

The driver needs to be able to clean up in any context.
That's why I'm advocating what willy called an "exception framework".

While I like linus' suggestion is better than the original,
it spreads the driver error recovery code throughout the driver.
That upside is it can handle every situation.
The downside is numerous error paths makes the regular code alot
harder to read and maintain.

> Also, for that matter, what if a network device receives an abort
> while performing BM-DMA?

The next PIO read will see the error caused by BM-DMA.

> Do we even care about either of these two scenarios?

yes. IO Error recovery has to deal with every scenario.

grant
