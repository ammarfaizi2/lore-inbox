Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVANPZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVANPZG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 10:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVANPZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 10:25:06 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:1471 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262007AbVANPZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 10:25:00 -0500
Date: Fri, 14 Jan 2005 16:24:50 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andi Kleen <ak@muc.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <m1zmzcpfca.fsf@muc.de>
Message-ID: <Pine.LNX.4.61.0501141549460.6118@scrub.home>
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 14 Jan 2005, Andi Kleen wrote:

> > - Added the Linux Trace Toolkit (and hence relayfs).  Mainly because I
> >   haven't yet taken as close a look at LTT as I should have.  Probably neither
> >   have you.
> 
> I think it would be better to have a standard set of kprobes instead
> of all the ugly LTT hooks. kprobes could then log to relayfs or another
> fast logging mechanism.

kprobes is not portable.

> The problem relayfs has IMHO is that it is too complicated. It 
> seems to either suffer from a overfull specification or second system
> effect. There are lots of different options to do everything,
> instead of a nice simple fast path that does one thing efficiently.

I have to agree with this. relayfs should resemble a very simple pipe, 
maybe making it possible to writing them directly to disk.
ltt has the same problem. It still does way too much at event time, it 
should just pump the data to disk and postprocess it later. I think it's 
better to implement multiple traces in user space via a daemon, which 
synchronizes multiple users.

> IMHO before merging it should go through a diet and only keep
> the paths that are actually needed and dropping a lot of the current
> baggage.

While I agree this is needed, I don't think it's a reason against merging, 
it should just be made clear, that the API is not stable and will change.

bye, Roman
