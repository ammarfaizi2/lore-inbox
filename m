Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVJQKit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVJQKit (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 06:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVJQKis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 06:38:48 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:30402 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932260AbVJQKis
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 06:38:48 -0400
Date: Mon, 17 Oct 2005 16:02:44 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Jean Delvare <khali@linux-fr.org>, torvalds@osdl.org,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
Message-ID: <20051017103244.GB6257@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43536A6C.102@cosmosbay.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 11:10:04AM +0200, Eric Dumazet wrote:
> Dipankar Sarma a écrit :
> >
> >IMO, putting the file accounting in slab ctor/dtors is not very
> >reliable because it depends on slab not getting fragmented.
> >Batched freeing in RCU is just an extreme case of it. We needed
> >to fix file counting anyway.
> >
> >Thanks
> >Dipankar
> 
> But isnt this file counting a small problem ?
> 
> This small program can eat all available memory.
> 
> Fixing the 'file count' wont fix the real problem : Batch freeing is good 
> but should be limited so that not more than *billions* of file struct are 
> queued for deletion.

Agreed. It is not designed to work that way, so there must be
a bug somewhere and I am trying to track it down. It could very well
be that at maxbatch=10 we are just queueing at a rate far too high
compared to processing.

> I believe we can find a solution, even if it might delay 2.6.14 because 
> Linus would have to release a rc5

This I am not sure, it is Linus' call. I am just trying to do the
right thing - fix the real problem.

Thanks
Dipankar
