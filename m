Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271355AbTGWWKG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 18:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271356AbTGWWKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 18:10:06 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:12555 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S271355AbTGWWJ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 18:09:28 -0400
Date: Wed, 23 Jul 2003 15:24:32 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel bug in socketpair()
Message-ID: <20030723222432.GC16188@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20030723100043.18d5b025.davem@redhat.com> <200307231724.NAA90957@raptor.research.att.com> <20030723103135.3eac4cd2.davem@redhat.com> <200307231814.OAA74344@raptor.research.att.com> <20030723112307.5b8ae55c.davem@redhat.com> <200307231854.OAA90112@raptor.research.att.com> <20030723120457.206dc02d.davem@redhat.com> <200307231911.PAA35164@raptor.research.att.com> <20030723121436.10d53965.davem@redhat.com> <200307231929.PAA77754@raptor.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307231929.PAA77754@raptor.research.att.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message is may contain confidential information.  Unauthorised disclosure will be prosecuted to the fullest extent of the law.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 03:29:03PM -0400, Glenn Fowler wrote:
> 
> On Wed, 23 Jul 2003 12:14:36 -0700 David S. Miller wrote:
> > I missed the reason why you can't use pipes and bash
> > is able to, what is it?
> 
> we have some applications, ksh included, with semantics that require
> stdin be read at most one line at a time; an inefficient implementation
> of this does 1 byte read()s until newline is read; an efficient
> implementation does a peek read (without advancing the read/seek offset),
> determines how many chars to read up to and including the newline,
> and then read()s that much
> 
> linux has ioctl(I_PEEK) for stream devices and recv() for sockets,
> and neither of these work on pipes; if there is a linux alternative
> for pipes then we'd be glad to use it
> 
> we switched from pipe() to socketpair() to take advantage of the linux
> recv() peek read

Perhaps you'd rather code a patch adding peek functionality
for pipes.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
