Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbUKCQH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbUKCQH3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 11:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbUKCQH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 11:07:28 -0500
Received: from pat.uio.no ([129.240.130.16]:35807 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261623AbUKCQHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 11:07:19 -0500
Subject: Re: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jakob Oestergaard <jakob@unthought.net>,
       Neil Brown <neilb@cse.unsw.edu.au>
Cc: Brad Campbell <brad@wasp.net.au>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041103151011.GC12752@unthought.net>
References: <41877751.502@wasp.net.au>
	 <1099413424.7582.5.camel@lade.trondhjem.org>
	 <20041103151011.GC12752@unthought.net>
Content-Type: text/plain
Date: Wed, 03 Nov 2004 08:05:48 -0800
Message-Id: <1099497948.8076.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0.326, required 12,
	RCVD_NUMERIC_HELO 0.33)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 03.11.2004 Klokka 16:10 (+0100) skreiv Jakob Oestergaard:
> On Tue, Nov 02, 2004 at 08:37:04AM -0800, Trond Myklebust wrote:
> > ty den 02.11.2004 Klokka 16:02 (+0400) skreiv Brad Campbell:
> > 
> > > /raid 192.168.2.81(rw,async,no_root_squash)
> > > /raid 192.168.3.80(rw,async,no_root_squash)
> > > /raid0 192.168.2.81(rw,async,no_root_squash)
> > > /raid0/tmp 192.168.2.81(rw,async,no_root_squash)
> > > /raid2 192.168.2.81(rw,async,no_root_squash)
> > > /raid2 192.168.3.80(rw,async,no_root_squash)
> > > /nfsroot 192.168.2.81(rw,async,no_root_squash)
> > 
> > You should only have 1 line per directory.
> 
> But exportfs won't complain about this.
> 
> Additionally, it seems to be allowed to use NIS netgroups in the exports
> file, except, well, it "sort of doesn't quite entirely always work".
> The best part of course being the errors you get: None on the server -
> but mounts might misbehave randomly at some point in the future on some
> client machines.
> 
> I just edited an exports file (according to your recommendations -
> because my server occationally gave stale file handles on some client
> machines), and found that the netmask 255.255.254.0 doesn't work either
> - you need to specify two nets with 255.255.255.0 instead.   My point
> being, that even though I administer a network that I would describe as
> "small", even I run into major problems with the lack of proper parsing
> and error reporting of /etc/exports.
> 
> Generally, it seems exportfs would accept virtually any input, export it
> one way or another to the kernel, with unpredictable results and
> spurious errors at random times in the future.
> 
> What I would like was for exportfs to either say "No! Fix your file
> stupid" or "Good! This setup will work reliably for all eternity then".
> 
> Is anyone considering fixing this?   And; is the problem mainly in
> exportfs, in the kernel, or both?  (relevant for me to know if I want to
> go fix it myself)    Thanks!

I agree entirely.

The above two questions should really be directed to Neil (so I've Cced
him). My guess would be that he would welcome any help here.

Although the limitations on what you are allowed to export are
kernel-based, I believe you only need to add the checks to the nfs-utils
package's parser for /etc/exports.

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

