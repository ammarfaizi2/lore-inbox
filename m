Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261447AbSJ1S5t>; Mon, 28 Oct 2002 13:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbSJ1S5t>; Mon, 28 Oct 2002 13:57:49 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:42444 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S261447AbSJ1S5r> convert rfc822-to-8bit; Mon, 28 Oct 2002 13:57:47 -0500
content-class: urn:content-classes:message
Subject: RE: Fixing /proc/kcore
Date: Mon, 28 Oct 2002 11:03:42 -0800
Message-ID: <DD755978BA8283409FB0087C39132BD10C4404@fmsmsx404.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-MS-Has-Attach: 
Content-Transfer-Encoding: 7BIT
X-MS-TNEF-Correlator: 
Thread-Topic: Fixing /proc/kcore
Thread-Index: AcJ9hs39eBzPn+l3Edao8gBQi2jWzABLJ/Aw
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
From: "Luck, Tony" <tony.luck@intel.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "IA64 Linux Mail Group" <linux-ia64@linuxia64.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Oct 2002 19:03:42.0956 (UTC) FILETIME=[BBC99AC0:01C27EB4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Fri, Oct 25, 2002 at 02:14:44PM -0700, Luck, Tony wrote:
> > Putting everything into the vmlist looks to be a good idea.  Perhaps
> > there should be an entry for the "direct addresses" too?
> 
> Yes that would make sense.
> 
> > 
> > So what does:
> > 
> > 	# objdump -p /proc/kcore
> > 
> > look like for you?
> 
> Very messy because of the negative addresses and still some sign problems
> in binutils :-)

Oops, I didn't mean to take this discussion off the mailing list.

What about a combined approach ... architecture dependent code
should add all the interesting stuff to the vmlist, so kcore just
needs to walk the list to cover everything.  We could also keep the
KCORE_BASE concept from my patch, but turn it into a variable that
the architecture dependent code can set to some suitable offset to
keep all the offsets in /proc/kcore positive.  This will avoid
having to fixup binutils (at least until someone comes up with an
architecture where kernel space scatters across a wide enough range
that we can't keep the offsets positive).

-Tony
