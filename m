Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbTIPLLw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 07:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTIPLLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 07:11:52 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:9364 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S261811AbTIPLLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 07:11:51 -0400
Date: Tue, 16 Sep 2003 12:11:39 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, "Hu, Boris" <boris.hu@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Split futex global spinlock futex_lock
Message-ID: <20030916111139.GC26576@mail.jlokier.co.uk>
References: <20030916010313.69E1F2C974@lists.samba.org> <3F66960E.7010703@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F66960E.7010703@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> After these changes the code still works but I couldn't really measure
> any differences to the code without the extra attributes.  This is on a
> 4p machine with 10 processes running in concurrently using mutexes and
> condvars with 250 threads each.  This might be because either the hash
> function is good or very bad (i.e., hashes all futexes in the same
> bucket or far away).  I guess the extra attributes don't hurt.

On a 4 CPU machine the hash table is plenty large enough without the
extra attributes.  (Assuming 128 byte cache lines: 3072 bytes without
(24 cache lines); 32768 bytes with).

The extra cache lines might hurt a bit when all the threads run on a
single CPU, or on a HT, just because 32768 bytes is a lot more L1 than
3072 bytes.

-- Jamie
