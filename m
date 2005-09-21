Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbVIUVPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbVIUVPF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 17:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbVIUVPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 17:15:05 -0400
Received: from pat.uio.no ([129.240.130.16]:30138 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964844AbVIUVPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 17:15:03 -0400
Subject: Re: dentry_cache using up all my zone normal memory -- also seen
	on 2.6.14-rc2
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: dipankar@in.ibm.com
Cc: Christopher Friesen <cfriesen@nortel.com>, Sonny Rao <sonny@burdell.org>,
       linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
       bharata@in.ibm.com
In-Reply-To: <20050921210019.GF4569@in.ibm.com>
References: <433189B5.3030308@nortel.com> <43318FFA.4010706@nortel.com>
	 <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org>
	 <4331C9B2.5070801@nortel.com>  <20050921210019.GF4569@in.ibm.com>
Content-Type: text/plain
Date: Wed, 21 Sep 2005 17:14:40 -0400
Message-Id: <1127337280.11109.48.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.755, required 12,
	autolearn=disabled, AWL 1.25, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 22.09.2005 Klokka 02:30 (+0530) skreiv Dipankar Sarma:
> On Wed, Sep 21, 2005 at 02:59:30PM -0600, Christopher Friesen wrote:
> > Sonny Rao wrote:
> > 
> > >Over one million files open at once is just asking for trouble on a
> > >lowmem-crippled x86 machine, IMHO.
> > 
> > I don't think there actually are.  I ran the testcase under strace, and 
> > it appears that there are two threads going at once.
> > 
> > thread 1 spins doing the following:
> > fd = creat("./rename14", 0666);
> > unlink("./rename14");
> > close(fd);
> > 
> > thread 2 spins doing:
> > rename("./rename14", "./rename14xyz");
> 
> Ewww.. Looks like a leak due to a race.
> 
> Does this happen on a non-nfs filesystem ?

...and what is "an NFS filesystem"? v2, v3, v4, ...?

Note also that the above test will be heavily exercising the sillyrename
code. Is Chris perhaps seeing vast numbers of .nfs* files resulting from
this test?

Also note that one change went into 2.6.13 that causes the icache to
evict inodes corresponding to files that end up being deleted by
nfs_rename(). Previously, they could end up floating around in the
icache because the i_nlink count was non-zero.

Cheers,
  Trond

