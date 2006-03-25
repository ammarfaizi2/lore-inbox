Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWCYHjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWCYHjk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 02:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWCYHjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 02:39:40 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:62889 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751102AbWCYHjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 02:39:40 -0500
To: akpm@osdl.org
CC: mhalcrow@us.ibm.com, phillip@hellewell.homeip.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mcthomps@us.ibm.com,
       yoder1@us.ibm.com, toml@us.ibm.com, emilyr@us.ibm.com,
       daw@cs.berkeley.edu
In-reply-to: <20060324163358.557ac5f7.akpm@osdl.org> (message from Andrew
	Morton on Fri, 24 Mar 2006 16:33:58 -0800)
Subject: Re: eCryptfs Design Document
References: <20060324222517.GA13688@us.ibm.com>
	<20060324154920.11561533.akpm@osdl.org>
	<20060325001345.GC13688@us.ibm.com> <20060324163358.557ac5f7.akpm@osdl.org>
Message-Id: <E1FN3ML-0003MZ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 25 Mar 2006 08:38:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > One dutifully wonders whether all this functionality could be
> > > provided via FUSE...
> > 
> > My main concern with FUSE has to do with shared memory mappings.
> 
> OK.  But I'm sure Miklos would appreciate help with that ;)

You bet.

> > My next concern is with regard to performance impact of constant
> > context switching during page reads and writes.
> 
> Maybe.  One could estimate the cost of that by benchmarking an existing
> (efficient) FUSE fs and then add fiddle factors.  If the number of copies
> is the same for in-kernel versus FUSE then one would expect the performance
> to be similar.  Especially if the encrypt/decryption cost perponderates.

The main overhead of FUSE is not in copies, but in context switching.
For I/O that can be mitigated by doing it in big chunks, otherwise the
only solution is adding more processors.

Miklos
