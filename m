Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWHAIMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWHAIMd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 04:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWHAIMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 04:12:33 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:16589 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751288AbWHAIMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 04:12:32 -0400
Date: Tue, 1 Aug 2006 10:12:10 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/6] AVR32 update for 2.6.18-rc2-mm1
Message-ID: <20060801101210.0548a382@cad-250-152.norway.atmel.com>
In-Reply-To: <1154371259.13744.4.camel@localhost>
References: <1154354115351-git-send-email-hskinnemoen@atmel.com>
	<20060731174659.72da734f@cad-250-152.norway.atmel.com>
	<1154371259.13744.4.camel@localhost>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 11:40:58 -0700
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> On Mon, 2006-07-31 at 17:46 +0200, Haavard Skinnemoen wrote:
> > On Mon, 31 Jul 2006 15:55:15 +0200
> > Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:
> > 
> > > Anyway, 2.6.18-rc2-mm1 boots successfully on my target with these
> > > patches, but there's something strange going on with NFS and a few
> > > other things that I didn't notice on 2.6.18-rc1. I'll investigate
> > > some more and see if I can figure out what's going on.
> > 
> > All forms of write access to the NFS root file system seem to return
> > -EACCESS. If I leave out git-nfs.patch, the problem goes away, so
> > I'll try bisecting the NFS git tree tomorrow.
> 
> can you check in /proc/self/mountstats what mount options are set on
> the root file system?

rw,vers=2,rsize=4096,wsize=4096,acregmin=3,acregmax=60,acdirmin=30,
acdirmax=60,hard,nolock,proto=udp,timeo=11,retrans=2,sec=null

> > Is there anyway to access it via http?
> 
> The individual patches are archived in

Thanks, I cloned the git repository via my home PC so I could do a real
bisect, which ended up blaming this patch:

NFS: Share NFS superblocks per-protocol per-server per-FSID

from David Howells. The patch is quite large, so I'm not able to spot
anything obvious. Please let me know if you want me to test something.

Haavard
