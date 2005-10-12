Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbVJLEb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVJLEb1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 00:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbVJLEb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 00:31:27 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:54023 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932414AbVJLEb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 00:31:26 -0400
Date: Wed, 12 Oct 2005 06:31:08 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Leif Nixon <nixon@nsc.liu.se>, linux-kernel@vger.kernel.org
Subject: Re: Cache invalidation bug in NFS v3 - trivially reproducible
Message-ID: <20051012043108.GI22601@alpha.home.local>
References: <m33bn8bet4.fsf@nammatj.nsc.liu.se> <1129042077.11164.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129042077.11164.9.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 11, 2005 at 10:47:57AM -0400, Trond Myklebust wrote:
> ty den 11.10.2005 Klokka 11:09 (+0200) skreiv Leif Nixon:
> > Hi,
> > 
> > We have come across a bug where a NFS v3 client fails to invalidate
> > its data cache for a file even though it realizes that the file
> > attributes have changed. We have been able to recreate the bug on a
> > range of kernel versions and different underlying file systems.
> > 
> > Here's a minimal way to reproduce the error (there seems to be some
> > timing issues involved, but this has worked at least 90% of the time):
> > 
> >   NFS client n1                NFS client n2
> > 
> >   $ echo 1 > f
> > 			       $ cat f
> > 			       1
> >   $ touch .
> >   $ echo 2 > f
> > 			       $ touch f
> > 			       $ cat f
> > 			       1
> > 
> > Now client n2 is stuck in a state where it uses its old cached data
> > forever (or at least for several hours):
> 
> Yep. I can see a problem whereby the cache is "losing" consistency
> information when you do this sort of thing. I'm working on a fix.

Trond, if this can help you, I *cannot* reproduce this with 2.4 clients
and server.

Cheers,
Willy

