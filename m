Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTE3EQZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 00:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbTE3EQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 00:16:25 -0400
Received: from mx2.elte.hu ([157.181.151.9]:6044 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263258AbTE3EQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 00:16:24 -0400
Date: Fri, 30 May 2003 06:29:13 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: Scott A Crosby <scrosby@cs.rice.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
In-Reply-To: <1054267067.2713.3.camel@rth.ninka.net>
Message-ID: <Pine.LNX.4.44.0305300627140.4176-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 29 May 2003, David S. Miller wrote:

> > I highly advise using a universal hashing library, either our own or
> > someone elses. As is historically seen, it is very easy to make silly
> > mistakes when attempting to implement your own 'secure' algorithm.
> 
> Why are you recommending this when after 2 days of going back
> and forth in emails with me you came to the conclusion that for
> performance critical paths such as the hashes in the kernel the Jenkins
> hash was an acceptable choice?
> 
> It is unacceptably costly to use a universal hash, it makes a multiply
> operation for every byte of key input plus a modulo operation at the end
> of the hash computation.  All of which can be extremely expensive on
> some architectures.
> 
> I showed and backed this up for you with benchmarks comparing your
> universal hashing code and Jenkins.

i'd suggest to use the jhash for the following additional kernel entities:  
pagecache hash, inode hash, vcache hash.

the buffer-cache hash and the pidhash should be hard (impossible?) to
attack locally.

	Ingo

