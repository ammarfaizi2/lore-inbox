Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267759AbUHPQTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267759AbUHPQTZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 12:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267758AbUHPQTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 12:19:24 -0400
Received: from holomorphy.com ([207.189.100.168]:8104 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267709AbUHPQTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 12:19:03 -0400
Date: Mon, 16 Aug 2004 09:18:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Ray Bryant <raybry@sgi.com>, "David S. Miller" <davem@redhat.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath: Increasing SMP scalability by introducing pte locks?
Message-ID: <20040816161845.GA11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christoph Lameter <clameter@sgi.com>, Ray Bryant <raybry@sgi.com>,
	"David S. Miller" <davem@redhat.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0408150630560.324@schroedinger.engr.sgi.com> <20040815130919.44769735.davem@redhat.com> <Pine.LNX.4.58.0408151552280.3370@schroedinger.engr.sgi.com> <20040815165827.0c0c8844.davem@redhat.com> <Pine.LNX.4.58.0408151703580.3751@schroedinger.engr.sgi.com> <20040815185644.24ecb247.davem@redhat.com> <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com> <41205BAA.9030800@sgi.com> <Pine.LNX.4.58.0408160817210.8293@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408160817210.8293@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004, Ray Bryant wrote:
>> Something else to worry about here is mm->rss.  Previously, this was updated
>> only with the page_table_lock held, so concurrent increments were not a
>> problem.  rss may need to converted be an atomic_t if you use pte_locks.
>> It may be that an approximate value for rss is good enough, but I'm not sure
>> how to bound the error that could be introduced by a couple of hundred
>> processers handling page faults in parallel and updating rss without locking
>> it or making it an atomic_t.

On Mon, Aug 16, 2004 at 08:18:11AM -0700, Christoph Lameter wrote:
> Correct. There are a number of issues that may have to be addressed but
> first we need to agree on a general idea how to proceed.

I'd favor a per-cpu counter so the cacheline doesn't bounce.


-- wli
