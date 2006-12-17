Return-Path: <linux-kernel-owner+w=401wt.eu-S1753134AbWLQWhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbWLQWhd (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 17:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753135AbWLQWhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 17:37:32 -0500
Received: from z2.cat.iki.fi ([212.16.98.133]:38237 "EHLO z2.cat.iki.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134AbWLQWhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 17:37:32 -0500
Date: Mon, 18 Dec 2006 00:37:30 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: "J.H." <warthog9@kernel.org>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       hpa@zytor.com, webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Message-ID: <20061217223730.GW10054@mea-ext.zmailer.org>
References: <20061214223718.GA3816@elf.ucw.cz> <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <45858B3A.5050804@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45858B3A.5050804@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 17, 2006 at 10:23:54AM -0800, Randy Dunlap wrote:
> J.H. wrote:
...
> >The root cause boils down to with git, gitweb and the normal mirroring
> >on the frontend machines our basic working set no longer stays resident
> >in memory, which is forcing more and more to actively go to disk causing
> >a much higher I/O load.  You have the added problem that one of the
> >frontend machines is getting hit harder than the other due to several
> >factors: various DNS servers not round robining, people explicitly
> >hitting [git|mirrors|www|etc]1 instead of 2 for whatever reason and
> >probably several other factors we aren't aware of.  This has caused the
> >average load on that machine to hover around 150-200 and if for whatever
> >reason we have to take one of the machines down the load on the
> >remaining machine will skyrocket to 2000+.  

Relaying on DNS and clients doing round-robin load-balancing is doomed.

You really, REALLY, need external L4 load-balancer switches.
(And installation help from somebody who really knows how to do this
kind of services on a cluster.)

Basic config features include, of course:
 - number of parallel active connections with each protocol
 - availability of each served protocol  (e.g. one can shutdown rsync
   at one server, and new rsync connections get pushed elsewere)
 - running load-balance of each served protocol separately
 - server load monitoring and letting it bias new connections to nodes
   not so utterly loaded
 - allowing direct access to each server in addition to the access
   via cluster service
 - some sort of connection persistence, only for HTTP access ?
   (ftp and rsync can do nicely without)

> >Since it's apparent not everyone is aware of what we are doing, I'll
> >mention briefly some of the bigger points.
...
> >- We've cut back on the number of ftp and rsync users to the machines.
> >Basically we are cutting back where we can in an attempt to keep the
> >load from spiraling out of control, this helped a bit when we recently
> >had to take one of the machines down and instead of loads spiking into
> >the 2000+ range we peaked at about 500-600 I believe.

How about having filesystems mounted with "noatime" ?
Or do you already do that ?

> >So we know the problem is there, and we are working on it - we are
> >getting e-mails about it if not daily than every other day or so.  If
> >there are suggestions we are willing to hear them - but the general
> >feeling with the admins is that we are probably hitting the biggest
> >problems already.

/Matti Aarnio
