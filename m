Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUEYKxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUEYKxU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 06:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUEYKxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 06:53:20 -0400
Received: from gate.in-addr.de ([212.8.193.158]:34541 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262932AbUEYKxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 06:53:18 -0400
Date: Tue, 25 May 2004 12:52:52 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: braam <braam@clusterfs.com>, "'Jens Axboe'" <axboe@suse.de>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       "'Phil Schwan'" <phil@clusterfs.com>
Subject: Re: [PATCH/RFC] Lustre VFS patch
Message-ID: <20040525105252.GJ22750@marowsky-bree.de>
References: <20040525064730.GB14792@suse.de> <20040525082305.BAEE93101A0@moraine.clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040525082305.BAEE93101A0@moraine.clusterfs.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-05-25T16:21:29,
   braam <braam@clusterfs.com> said:

> I think do answer your question:  ...
> > > If we were to return errors, (which, I agree, _seems_ much more
> > > sane, and we _did_ try that for a while!) then there is a good
> > > chance, namely immediately when something is flushed to disk, that
> > > the system will detect the errors and not continue to execute
> > > transactions making consistent testing of our replay mechanisms
> > > impossible.
> So: we can use the flags, but we cannot return the errors.

Maybe I am missing something here, but is this testing not somewhat
unrealistic then? In the general case, the system in production _will_
report an error and not silently throw away the writes.

> Some people find it very convenient to have this available, but if the
> opinion is that it is better to let development teams manage their own
> testing infrastructure that is acceptable to me.

Yes, this is very "convenient" and actually, "some people" think it is
absolutely mandatory that the kernel which is used for production sites
is 1:1 bit-wise identical than the one used for load & stress testing,
otherwise the testing is void to a certain degree...

Maybe you could fix this in the test harness / Lustre itself instead and
silently discard the writes internally if told so via an (internal)
option, instead of needing a change deeper down in the IO layer, or use
a DM target which can give you all the failure scenarios you need?

In particular the last one - a fault-injection DM target - seems like a
very valuable tool for testing in general, but the Lustre-internal
approach may be easier in the long run.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

