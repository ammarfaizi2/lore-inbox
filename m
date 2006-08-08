Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWHHMsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWHHMsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWHHMsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:48:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:194 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932432AbWHHMsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:48:21 -0400
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [RFC] NUMA futex hashing
Date: Tue, 8 Aug 2006 14:47:42 +0200
User-Agent: KMail/1.9.3
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
References: <20060808070708.GA3931@localhost.localdomain> <200608081236.15823.ak@suse.de> <200608081429.44497.dada1@cosmosbay.com>
In-Reply-To: <200608081429.44497.dada1@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608081447.42587.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 14:29, Eric Dumazet wrote:
> On Tuesday 08 August 2006 12:36, Andi Kleen wrote:
> > > We may have special case for PRIVATE futexes (they dont need to be
> > > chained in a global table, but a process private table)
> >
> > What do you mean with PRIVATE futex?
> >
> > Even if the futex mapping is only visible by a single MM mmap_sem is still
> > needed to protect against other threads doing mmap.
> 
> Hum... I would call that a user error.
> 
> If a thread is munmap()ing the vma that contains active futexes, result is 
> undefined.

We can't allow anything that could crash the kernel, corrupt a kernel,
data structure, allow writing to freed memory etc.  No matter how
defined it is or not. Working with a vma that doesn't have 
an existence guarantee would be just that.

-Andi
