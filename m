Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbUAPF1o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 00:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUAPF1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 00:27:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:14530 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265254AbUAPF1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 00:27:37 -0500
Date: Thu, 15 Jan 2004 21:00:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Jesse Barnes <jbarnes@sgi.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       jeremy@sgi.com
Subject: Re: [PATCH] readX_relaxed interface
In-Reply-To: <20040116003224.GF23253@kroah.com>
Message-ID: <Pine.LNX.4.58.0401152057380.2631@evo.osdl.org>
References: <20040115204913.GA8172@sgi.com> <20040116003224.GF23253@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Jan 2004, Greg KH wrote:
> 
> It looks ok, but it would really be good if we could indicate if the
> read actually was successful.  Right now some platforms can detect
> faults and do not have a way to get that error back to the driver in a
> sane manner.  If we were to change the read* functions to look something
> like:
> 	int readb(void *addr, u8 *data);
> it would be a world easier.

NOOOO!

Please don't. 99.99% of all uses don't care one whit, and an interface 
like the above ends up being total cr*p to use.

If you care about machine check errors, use a special interface for that. 
A _really_ special one. Especially as on many systems you'll likely have 
to read status registers etc (and clear them before doing the IO) to see 
the errors.

So that way you can get errors working, AND it won't actually make normal 
code any uglier.

		Linus
