Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932734AbWBUOof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734AbWBUOof (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 09:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932735AbWBUOof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 09:44:35 -0500
Received: from ns2.suse.de ([195.135.220.15]:63140 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932734AbWBUOof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 09:44:35 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, shai@scalex86.org, kiran@scalex86.org
Subject: Re: [patch] Cache align futex hash buckets
References: <20060220233242.GC3594@localhost.localdomain>
	<20060220153320.793b6a7d.akpm@osdl.org>
	<20060220153419.5ea8dd89.akpm@osdl.org>
	<20060221000924.GD3594@localhost.localdomain>
	<20060220162317.5c7b9778.akpm@osdl.org>
	<20060221010430.GE3594@localhost.localdomain>
	<20060220170940.1496e1d5.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 21 Feb 2006 15:44:30 +0100
In-Reply-To: <20060220170940.1496e1d5.akpm@osdl.org>
Message-ID: <p738xs44vqp.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
> 
> Well it's your architecture...  As long as you're finding this to be a
> sufficiently large problem in testing to justify consuming a meg of memory
> then fine, let's do it.

I think it's a waste of memory even with 128 byte cache lines. 

If it's really a big problem. Some more clever solution would be
better. e.g. allocate a hash table per node and use a hierarchical
hash, trying to put stuff into the local node first.

-Andi
