Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261735AbREWSuA>; Wed, 23 May 2001 14:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbREWStu>; Wed, 23 May 2001 14:49:50 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:31178 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261735AbREWStf>;
	Wed, 23 May 2001 14:49:35 -0400
Date: Wed, 23 May 2001 14:49:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Neulinger, Nathan" <nneul@umr.edu>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: lot's of oops's on 2.4.4 in d_lookup/cached_lookup
In-Reply-To: <F349BC4F5799D411ACE100D0B706B3BB768D16@umr-mail03.cc.umr.edu>
Message-ID: <Pine.GSO.4.21.0105231444070.20269-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 May 2001, Neulinger, Nathan wrote:

> I've got a system monitoring box, running 2.4.4 with a few patches (ide,
> inode-nr_unused, max-readahead, knfsd, and a couple of basic tuning opts w/o
> code changes). Basically, the server runs anywhere from a few hours to a few
> days, but always seems to get to a point where it gets tons of the following
> type of oops. It is almost ALWAYS in d_lookup. It's not always the same
> script, but generally is one of a set of scripts that get run repeatedly
> every few minutes. check-all is a shell script that just runs a set of local
> commands (/local/sysmon/check-XXXX.pl hostname args). 
> 
> The machine is running afs, but the call traces don't appear to be in afs
> code.
> 
> Any ideas on what might be causing this?

Anything that corrupts dcache and/or memory. d_lookup() is the place where
and dcache corruption (regardless of its origins) will show up - here you
walk long lists, so its chances of being the first function to hit the
screwed stuff are pretty high.

Most likely you are looking at the results of earlier event, so chances of
seeing it in the stack trace are very low.

