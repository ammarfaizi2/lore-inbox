Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbTDHRHp (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 13:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbTDHRHp (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 13:07:45 -0400
Received: from havoc.daloft.com ([64.213.145.173]:21223 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261665AbTDHRHn (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 13:07:43 -0400
Date: Tue, 8 Apr 2003 13:19:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rusty Russell <rusty@rustcorp.com.au>,
       zwane@linuxpower.ca,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hch@infradead.org
Subject: Re: SET_MODULE_OWNER?
Message-ID: <20030408171916.GA11773@gtf.org>
References: <20030408035210.02D142C06E@lists.samba.org> <1049802672.8120.14.camel@dhcp22.swansea.linux.org.uk> <20030408144644.GB30142@mail.jlokier.co.uk> <20030408151226.GA30285@gtf.org> <20030408164501.GA30428@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030408164501.GA30428@mail.jlokier.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 05:45:01PM +0100, Jamie Lokier wrote:
> It is all very well to insist that SET_MODULE_OWNER() remains so you
> can take 2.4 drivers and easily compile them for 2.2...  but why is
> that the benchmark?  I can't take 2.4 drivers and do that, because I
> want to support 2.0 as well, so I bite the bullet and make the
> necessary changes for broader compatibility.

You can do 2.0 compat with kcompat.  Just needs a couple more compat
macros in kcompat tarball.  I grant you that net drivers are much more
resilient across kernel versions, and are easier to make portable across
the various kernel API changes -- precisely because we've managed to
keep the core interfaces fairly stable, logic- and locking-wise.
SET_MODULE_OWNER is just one more piece of this conscious effort.


> So.. back to a point.  Is 2.2 compilability (with the help of kcompat)
> one of the goals to aim for in 2.5 drivers generally?  Or is this
> specifically meant for the network drivers which you support?

In general, the mainline kernel has two conflicting goals:
* maintain source back-compat as long as it is reasonable
* keep back-compat garbage to a minimum, eliminating it where possible

It really comes down to a maintainer decision, unless there is an
overriding decision to purposefully break source back-compat.

To answer your question specifically, SET_MODULE_OWNER eases source
back-compat in general, but it's main user is network drivers.

	Jeff



