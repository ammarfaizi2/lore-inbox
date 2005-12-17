Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932577AbVLQNLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbVLQNLw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 08:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbVLQNLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 08:11:52 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:10667 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932577AbVLQNLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 08:11:51 -0500
Date: Sat, 17 Dec 2005 21:35:18 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Greg Banks <gnb@sgi.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: [PATCH 11/12] readahead: nfsd support
Message-ID: <20051217133518.GA5444@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Greg Banks <gnb@sgi.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@cse.unsw.edu.au>
References: <20051216130738.300284000@localhost.localdomain> <20051216131048.397266000@localhost.localdomain> <20051217000522.GB30278@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051217000522.GB30278@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 11:05:22AM +1100, Greg Banks wrote:
> On Fri, Dec 16, 2005 at 09:07:49PM +0800, Wu Fengguang wrote:
> > ------------------------------------------------------------------------
> > Here is some test output(8 nfsd; local mount with tcp,rsize=8192):
> 
> What are the numbers when you use a more realistic rsize like 32768? 

Here they are.  The normal data are now much better, and come close to that of
the serialized ones.

NORMAL

readahead_ratio = 8, ra_max = 1024kb (old logic)
48.36s real  2.22s system  1.51s user  7209+4110 cs  diff $NFSFILE $NFSFILE2
readahead_ratio = 70, ra_max = 1024kb (new logic)
30.04s real  2.46s system  1.33s user  5420+2492 cs  diff $NFSFILE $NFSFILE2

readahead_ratio = 8, ra_max = 1024kb
92.99s real  10.32s system  3.23s user  145004+1826 cs  diff -r $NFSDIR $NFSDIR2 > /dev/null
readahead_ratio = 70, ra_max = 1024kb
90.96s real  10.68s system  3.22s user  144414+2520 cs  diff -r $NFSDIR $NFSDIR2 > /dev/null

SERIALIZED

readahead_ratio = 8, ra_max = 1024kb
47.58s real  2.10s system  1.27s user  7933+1357 cs  diff $NFSFILE $NFSFILE2
readahead_ratio = 70, ra_max = 1024kb
29.46s real  2.41s system  1.38s user  5590+2613 cs  diff $NFSFILE $NFSFILE2

readahead_ratio = 8, ra_max = 1024kb
93.02s real  10.67s system  3.25s user  144850+2286 cs  diff -r $NFSDIR $NFSDIR2 > /dev/null
readahead_ratio = 70, ra_max = 1024kb
91.15s real  11.04s system  3.31s user  144432+2814 cs  diff -r $NFSDIR $NFSDIR2 > /dev/null

Regards,
Wu
