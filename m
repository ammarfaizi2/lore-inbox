Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWCaPYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWCaPYF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 10:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWCaPYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 10:24:04 -0500
Received: from unthought.net ([212.97.129.88]:33296 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751387AbWCaPYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 10:24:02 -0500
Date: Fri, 31 Mar 2006 17:24:01 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: NFS client (10x) performance regression 2.6.14.7 -> 2.6.15
Message-ID: <20060331152401.GM9811@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	"Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <20060331124518.GH9811@unthought.net> <1143810392.8096.11.camel@lade.trondhjem.org> <20060331132131.GI9811@unthought.net> <1143812658.8096.18.camel@lade.trondhjem.org> <20060331140816.GJ9811@unthought.net> <1143814889.8096.22.camel@lade.trondhjem.org> <20060331143500.GK9811@unthought.net> <20060331144951.GA9207@ti64.telemetry-investments.com> <20060331145726.GL9811@unthought.net> <20060331150453.GB9207@ti64.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331150453.GB9207@ti64.telemetry-investments.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 10:04:53AM -0500, Bill Rugolsky Jr. wrote:
> On Fri, Mar 31, 2006 at 04:57:26PM +0200, Jakob Oestergaard wrote:
> > True. But it is my impression that this is a problem isolated on the
> > client side (am I wrong?)
> 
> That seems to be the case.

Hmm...

> 
> > Do you mean NFS exporting a local filesystem, NFS mounting it again on
> > the local host?   Or do you mean something with loopback mounts?
>  
> The former; just export a local directory to 127.0.0.1 in /etc/exports,
> then mount it on /mnt.

With a local export/mount I see very few reads running the test  :/

Could this be a timing issue?  That pages in the cache are invalidated
after maybe less than 100 microseconds which is roughly the round-trip
time on the gigabit network connecting my server and client?

/proc/self/mountstats on the two filesystems look identical to me:

device sparrow:/exported/joe mounted on /u/joe with fstype nfs statvers=1.0
opts: rw,vers=3,rsize=32768,wsize=32768,acregmin=3,acregmax=60,
      acdirmin=30,acdirmax=60,hard,intr,proto=udp,timeo=7,retrans=3

device localhost:/home/test mounted on /mnt with fstype nfs statvers=1.0
opts: rw,vers=3,rsize=32768,wsize=32768,acregmin=3,acregmax=60,
      acdirmin=30,acdirmax=60,hard,intr,proto=udp,timeo=7,retrans=3


-- 

 / jakob

