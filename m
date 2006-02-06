Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWBFTU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWBFTU1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWBFTU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:20:27 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:6665 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932294AbWBFTUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:20:25 -0500
Date: Mon, 6 Feb 2006 20:20:04 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Check for references to discarded sections during build time
Message-ID: <20060206192004.GB12979@mars.ravnborg.org>
References: <20060205002016.GA6105@mars.ravnborg.org> <9750.1139236271@ocs3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9750.1139236271@ocs3>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 01:31:11AM +1100, Keith Owens wrote:
> On Sat, Feb 04, 2006 at 11:50:25PM +0100, Sam Ravnborg wrote:
> > Hi Keith.
> > 
> > While doing some other modpost.c changes I thought about the
> > possibility to do the reference_init check during the modpost stage - so
> > it is done early and author can catch warning when he made the error.
> > Attached is first cut.
> > 
> > It does a much more lousy job than reference_init because it identifies
> > the module and not the .o file. I hope to later identify the function
> > where the illegal reference hapens.
> 
> My main concern is that we cannot get the .o file with this approach, I
> am particulary concerned about this approach when processing vmlinux.
> Static function names are duplicated in the kernel.  Reporting a
> dangling reference to init or discarded data by function name rather
> than by object will lead to confusion if the reference is from one of
> the duplicate function names.
This is an issue. But compared to todays situation where we
only do the checks occasionaly and we miss single object modules
we can live with having to deal with duplicate symbols occasionally.

> 
> # nm vmlinux | fgrep ' t ' | awk '{print $3}' | sort | uniq -dc
> 
> produces this horrible list of duplicate function names (IA64):
> 
>       2 autofs_get_sb
... deleted ~70 lines
>       2 writenote
>       2 xdr_decode_fattr

Looks ugly. Maybe something to check in modpost later.

> 
> It will also be extremely difficult to track down entries from compiler
> generated anonymous data areas.  They are hard enough to isolate when
> looking at a single object.  When all the anonymous data has been
> merged together in vmlinux, it will be beyond most people.

Agreed. Maybe we shall let reference_init.pl report anonymous data and
skip that from the runtime part (if I find a way to detact it).

I will give it a spin later to see where I end up.

	Sam
