Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277825AbRJLTgN>; Fri, 12 Oct 2001 15:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277827AbRJLTgD>; Fri, 12 Oct 2001 15:36:03 -0400
Received: from peace.netnation.com ([204.174.223.2]:52234 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S277825AbRJLTfs>; Fri, 12 Oct 2001 15:35:48 -0400
Date: Fri, 12 Oct 2001 12:36:19 -0700
From: Simon Kirby <sim@netnation.com>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: Really slow netstat and /proc/net/tcp in 2.4
Message-ID: <20011012123619.E26630@netnation.com>
In-Reply-To: <20011011125538.C10868@netnation.com> <200110121644.UAA12030@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <200110121644.UAA12030@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Fri, Oct 12, 2001 at 08:44:58PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 08:44:58PM +0400, kuznet@ms2.inr.ac.ru wrote:

> > Is it possible to fix this?  Was the 2.2 hash table just that much
> > smaller?
> 
> 2.2 did not use hash tables, holding special single list for /proc.
> 
> If I understand correctly it was removed because added more data/work
> and new point of synchronization for main path being useful only for /proc.
> The approach would be justified, if you had 100000 sockets. In this
> case both approaches are equally slow. :-) But for 1000 sockets hash
> table of 100000 entries is sort of overscaled.
> 
> > Is it possible to fix this?
> 
> To fix --- no. To make differently --- yes.
> 
> Well, actually, if you are interested drop me a not I can pack for you some
> my old work on this. It is fully functional, but api is still dirty.
> It requires some patching kernel, unfortunately.

If it involves changing the TCP stack locking stuff and putting the old
list back, it's probably not worth the bother.  The only thing we're
using the file for (other than the occasional admin-run "netstat") is to
check to see what ports are listening on the machine without actually
attempting to connect to them.  We check our services this way more often
than actually connecting and requesting a response to reduce log clutter
and testing load on the server.  Is there an easier way to accomplish
this than parsing /proc/net/tcp?  We could attempt to bind to the ports
we want to check, but that would race with daemons trying to start up.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
