Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbUKCPKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUKCPKV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 10:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbUKCPKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 10:10:20 -0500
Received: from unthought.net ([212.97.129.88]:46762 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261628AbUKCPKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 10:10:13 -0500
Date: Wed, 3 Nov 2004 16:10:11 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Brad Campbell <brad@wasp.net.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
Message-ID: <20041103151011.GC12752@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Brad Campbell <brad@wasp.net.au>, lkml <linux-kernel@vger.kernel.org>
References: <41877751.502@wasp.net.au> <1099413424.7582.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099413424.7582.5.camel@lade.trondhjem.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 08:37:04AM -0800, Trond Myklebust wrote:
> ty den 02.11.2004 Klokka 16:02 (+0400) skreiv Brad Campbell:
> 
> > /raid 192.168.2.81(rw,async,no_root_squash)
> > /raid 192.168.3.80(rw,async,no_root_squash)
> > /raid0 192.168.2.81(rw,async,no_root_squash)
> > /raid0/tmp 192.168.2.81(rw,async,no_root_squash)
> > /raid2 192.168.2.81(rw,async,no_root_squash)
> > /raid2 192.168.3.80(rw,async,no_root_squash)
> > /nfsroot 192.168.2.81(rw,async,no_root_squash)
> 
> You should only have 1 line per directory.

But exportfs won't complain about this.

Additionally, it seems to be allowed to use NIS netgroups in the exports
file, except, well, it "sort of doesn't quite entirely always work".
The best part of course being the errors you get: None on the server -
but mounts might misbehave randomly at some point in the future on some
client machines.

I just edited an exports file (according to your recommendations -
because my server occationally gave stale file handles on some client
machines), and found that the netmask 255.255.254.0 doesn't work either
- you need to specify two nets with 255.255.255.0 instead.   My point
being, that even though I administer a network that I would describe as
"small", even I run into major problems with the lack of proper parsing
and error reporting of /etc/exports.

Generally, it seems exportfs would accept virtually any input, export it
one way or another to the kernel, with unpredictable results and
spurious errors at random times in the future.

What I would like was for exportfs to either say "No! Fix your file
stupid" or "Good! This setup will work reliably for all eternity then".

Is anyone considering fixing this?   And; is the problem mainly in
exportfs, in the kernel, or both?  (relevant for me to know if I want to
go fix it myself)    Thanks!

-- 

 / jakob

