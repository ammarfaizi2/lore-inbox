Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVASR4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVASR4m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVASRxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:53:02 -0500
Received: from cantor.suse.de ([195.135.220.2]:35299 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261790AbVASRwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:52:05 -0500
Subject: Re: [kbuild 2/5] Dont use the running kernels config file by
	default
From: Andreas Gruenbacher <agruen@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.61.0501182106340.6118@scrub.home>
References: <20050118184123.729034000.suse.de>
	 <20050118192608.423265000.suse.de>
	 <Pine.LNX.4.61.0501182106340.6118@scrub.home>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1106157119.8642.25.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 19 Jan 2005 18:51:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-18 at 21:15, Roman Zippel wrote:
> Hi,
> 
> On Tue, 18 Jan 2005, Andreas Gruenbacher wrote:
> 
> > A user ran into the following problem: They grab a SuSE kernel-source
> > package that is more recent than their running kernel. The tree under
> > /usr/src/linux is unconfigured by default; there is no .config. User
> > does a ``make menuconfig'', which gets its default values from
> > /boot/config-$(uname -r). User tries to build the kernel, which doesn't
> > work.
> 
> NAK. This isn't normally supposed to happen and it shouldn't be as bad 
> anymore as it used to be. Removing these path doesn't magically create a 
> working kernel.

"Not normally supposed to happen" and "shouldn't be as bad anymore"
aren't very sound arguments. It's fundamentally broken to use a
semi-random configuration for a kernel source tree that may be
arbitrarily far apart. In the best case you notice that the
configuration doesn't work anymore. In the worst case you will fall flat
on your nose and only notice what happened after a long time.

It's not uncommon that users who build their own kernel modules often
are very clueless. Nevertheless we shouldn't cause them pain
unnecessarily.

Removing the running kernel's paths at least ensures that we don't get
arbitrary, unexpected results. I'd much prefer the user to be explicit
when he wants to clone the running kernel's configuration. That's what
patch 3/5 in this set does.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

