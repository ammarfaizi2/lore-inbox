Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVHCUDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVHCUDk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 16:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbVHCUDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 16:03:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:53170 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262437AbVHCUDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 16:03:39 -0400
Subject: Re: Calling suspend() in halt/restart/shutdown -> not a good idea
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Pavel Machek <pavel@ucw.cz>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <D6591B2F-4E98-48A0-A3DD-71AAC564278E@mac.com>
References: <1122908972.18835.153.camel@gaston>
	 <20050801203728.2012f058.Ballarin.Marc@gmx.de>
	 <1122926885.30257.4.camel@gaston> <20050802095401.GB1442@elf.ucw.cz>
	 <1123069255.30257.27.camel@gaston>
	 <D6591B2F-4E98-48A0-A3DD-71AAC564278E@mac.com>
Content-Type: text/plain
Date: Wed, 03 Aug 2005 21:59:14 +0200
Message-Id: <1123099155.30257.43.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-03 at 12:53 -0400, Kyle Moffett wrote:
> On Aug 3, 2005, at 07:40:54, Benjamin Herrenschmidt wrote:
> >> I'd like to get rid of shutdown callback. Having two copies of code
> >> (one in callback, one in suspend) is ugly.
> >
> > Well, it's obviously not a good time for this. First, suspend and
> > shutdown don't necessarily do the same thing, then it just doesn't  
> > work
> > in practice. So either do it right completely or not at all, but  
> > 2.6.13
> > isn't the place for an half-assed hack that looks like a solution to
> > you.
> 
> One possible way to proceed might be to add a new callback that takes a
> pm_message_t: powerdown()  If it exists, it would be called in both the
> suspend and shutdown paths, before the suspend() and shutdown() calls to
> that driver are made.  As drivers are fixed to clean up and combine that
> code, they could put the merged result into the powerdown() function,
> and remove their suspend() and shutdown() functions.

We already have shutdown() for that.

Ben.


