Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWCaOVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWCaOVo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 09:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWCaOVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 09:21:44 -0500
Received: from pat.uio.no ([129.240.10.6]:31743 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751332AbWCaOVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 09:21:43 -0500
Subject: Re: NFS client (10x) performance regression 2.6.14.7 -> 2.6.15
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060331140816.GJ9811@unthought.net>
References: <20060331094850.GF9811@unthought.net>
	 <1143807770.8096.4.camel@lade.trondhjem.org>
	 <20060331124518.GH9811@unthought.net>
	 <1143810392.8096.11.camel@lade.trondhjem.org>
	 <20060331132131.GI9811@unthought.net>
	 <1143812658.8096.18.camel@lade.trondhjem.org>
	 <20060331140816.GJ9811@unthought.net>
Content-Type: text/plain
Date: Fri, 31 Mar 2006 09:21:29 -0500
Message-Id: <1143814889.8096.22.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.307, required 12,
	autolearn=disabled, AWL 1.51, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-31 at 16:08 +0200, Jakob Oestergaard wrote:
> On Fri, Mar 31, 2006 at 08:44:18AM -0500, Trond Myklebust wrote:
> ...
> > Just apply
> > http://client.linux-nfs.org/Linux-2.6.x/2.6.16/linux-2.6.16-NFS_ALL.dif
> > 
> > to a clean 2.6.16.
> 
> Done. Plain 2.6.16 plus the patch.
> 
> ---------------------------------------
> [puffin:joe] $ time ./nfsbench
> 
> real    0m29.581s
> user    0m0.000s
> sys     0m0.208s
> [puffin:joe] $ nfsstat 
> Client rpc stats:
> calls      retrans    authrefrsh
> 13222      0          0       
> 
> <snip v2>
> 
> Client nfs v3:
> null       getattr    setattr    lookup     access     readlink   
> 0       0% 2577   19% 1       0% 24      0% 18      0% 0       0% 
> read       write      create     mkdir      symlink    mknod      
> 7045   53% 3200   24% 0       0% 0       0% 0       0% 0       0% 
> remove     rmdir      rename     link       readdir    readdirplus
> 0       0% 0       0% 0       0% 0       0% 0       0% 34      0% 
> fsstat     fsinfo     pathconf   commit     
> 0       0% 2       0% 0       0% 319     2% 
> 
> ---------------------------------------
> 
> Lots of getattr and lots of read...
> 
> I verified that the patch really got applied.
> 
> What could the difference be?
> 
> I've attached my .config - if there is anything in there you think might
> have an impact, please let me know - again, I can try anything on this
> machine...

Hmm... Nothing obvious.

Try catting /proc/self/mountstats and see if the entry for your NFS
mount shows anything interesting.

Cheers,
  Trond

> ...
> > Linux servers do not yet support anything larger than a 32k r/wsize (and
> > in any case, you would have to switch towards using TCP). My home
> > directory is on a filer.
> 
> Ok.
> 

