Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWGRKS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWGRKS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWGRKS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:18:57 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:10933 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S932160AbWGRKS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:18:56 -0400
In-Reply-To: <1153216601.3038.16.camel@laptopd505.fenrus.org>
References: <20060718091807.467468000@sous-sol.org> <20060718091948.747619000@sous-sol.org> <1153216601.3038.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7534c2861b892e1b42bc0880801a4121@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: Ian Pratt <ian.pratt@xensource.com>, Jeremy Fitzhardinge <jeremy@goop.org>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, Christoph Lameter <clameter@sgi.com>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 02/33] Add sync bitops
Date: Tue, 18 Jul 2006 11:18:45 +0100
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Jul 2006, at 10:56, Arjan van de Ven wrote:

>> plain text document attachment (synch-ops)
>> Add "always lock'd" implementations of set_bit, clear_bit and
>> change_bit and the corresponding test_and_ functions.  Also add
>> "always lock'd" implementation of cmpxchg.  These give guaranteed
>> strong synchronisation and are required for non-SMP kernels running on
>> an SMP hypervisor.
>
> Hi,
>
> this sounds really like the wrong approach; you know you're compiling
> for xen, so why not just make set_bit() and the others use the lock'd
> instructions at compile time?

Then all users of bitops would unnecessarily pay the price when running 
in a single-CPU guest. Only a few of our bitops callers absolutely 
require the lock prefix in all cases.

   -- Keir

