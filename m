Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751514AbWCHXlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbWCHXlH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbWCHXlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:41:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:7563 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751514AbWCHXlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:41:05 -0500
Subject: Re: [PATCH] Define flush_wc, a way to flush write combining store
	buffers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: akpm@osdl.org, ak@suse.de, paulus@samba.org, bcrl@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1141854208.27555.1.camel@localhost.localdomain>
References: <e27c8e0061e03594b3e1.1141853501@localhost.localdomain>
	 <1141853919.11221.183.camel@localhost.localdomain>
	 <1141854208.27555.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 10:40:29 +1100
Message-Id: <1141861230.11221.189.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 13:43 -0800, Bryan O'Sullivan wrote:
> On Thu, 2006-03-09 at 08:38 +1100, Benjamin Herrenschmidt wrote:
> 
> > I think people already don't undersatnd the existing gazillion of
> > barriers we have with quite unclear semantics in some cases, it's not
> > time to add a new one ...
> 
> What do you suggest I do, then?  This makes a substantial difference to
> performance for us.  Should I confine this somehow to the ipath driver
> directory and have a nest of ifdefs in an include file there?

What bothers me is that because of that exact same argument "it makes
substantial difference for us", we end up with basically barriers
tailored for architectures... that is as many kind of barriers as we
have architectuers... like mmiowb :)

Currently, PowerPC is losing significant performances for example to try
to "fit" in the linux barriers for things like IOs which would leak out
of spinlocks if we didn't have a strong barrier in pretty much every
writeX() or things like that. We could use the same argument you are
making to come up with yet another set of barriers that are more
friendly to ppc ...

At the end of the day, however, the problem is that pretty much no
driver write understand anything about any of the barriers and get them
all wrong...

Which makes me thing we are trying to use the wrong tool or providing
the wrong level of abstraction or something there...

Ben.


