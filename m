Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278447AbRJVJeb>; Mon, 22 Oct 2001 05:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278448AbRJVJeM>; Mon, 22 Oct 2001 05:34:12 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:46246 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278447AbRJVJeK>;
	Mon, 22 Oct 2001 05:34:10 -0400
Date: Mon, 22 Oct 2001 05:34:43 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12 
In-Reply-To: <24947.1003742395@ocs3.intra.ocs.com.au>
Message-ID: <Pine.GSO.4.21.0110220526480.2294-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Oct 2001, Keith Owens wrote:

> >Erm... Keith, I might be misreading the source, but... Shouldn't the
> >information like "block major $FOO is in module $BAR" live in
> >/lib/modules/*/* ?
> 
> Historically the mapping of device majors to module or binary format
> type to module was coded into modutils, via util/alias.h.  That was a
> mistake, it should have used the same technique as pci, isapnp, parport
> etc., each module has a table that defines what it handles and modutils
> extracts the data directly from the modules.  Developers have changed
> the names of their modules and now we have hard coded module names in
> modutils that do not match the names used by some kernels.  Hindsight
> is wonderful!
> 
> In modutils 2.5 I will get rid of all the hard coded entries in
> util/alias.h.  Instead each module will define what it supports,
> including any special commands to be run when the module is loaded or
> unloaded.  Much easier for everyone and far more flexible.

Heh.  OK, so you've stopped me in the middle of writing RFC that proposes
addition of
MODULE_CONF(string)
that would put that string into separate section and making modules_install
dump these sections, feed them through s/_NAME_/`basename $module`/ and
cat them into defaults file that would go into $INSTALL_MOD_PATH.
MODULES_BLKDEV(), MODULE_LDISC(), etc. would be trivial wrappers around that.

Looks like the thing you mentioned would make quite a few people happy.
Might be worth doing in 2.4...

