Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVDXJw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVDXJw2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 05:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVDXJw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 05:52:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33921 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262297AbVDXJwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 05:52:24 -0400
Date: Sun, 24 Apr 2005 10:52:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] unexport insert_resource
Message-ID: <20050424095223.GA22146@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20050415151043.GJ5456@stusta.de> <20050423164411.51d77bf1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423164411.51d77bf1.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2005 at 04:44:11PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > I didn't find any possible modular usage in the kernel.
> > 
> 
> True, but this looks like something which out-of-tree code could possibly
> be using.  I'd prefer to see this one get the deprecated_for_modules
> twelve-month treatment.

Don't you think twelve month is damn long?  Two kernel releases seem
like a better policy - extremly long deprecation periods only encourage
people to never look at mainline kernels but just ad vendor trees.

> Or we just leave it as-is.  It depends whether insert_resource is a
> sensible part of the resource management API (I think it is).  If so,
> then we should just leave it exported, whether or not any in-kernel moduels
> happen to be using it at this point in time.

It makes sense for plattforms or bus implementations.  So for typical drivers
it doesn't make sense at all.  It might make sense for bus providers, and in
case a modular one that wants this symbol appears we could re-export it
as _GPL, clearly marking it internal.

Note that you're not really helping driver authors by exporting random
kernel symbols - that way we can never guarantee a semi-stable API as
random internals are exported.  Compare that with e.g. the scsi subsystem
where we're trying to make sure to only export sensible primitives that
operate on higher-level object to the driver and make sure they're moving
off old and ill-specified APIs.

