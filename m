Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965208AbVHPNQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208AbVHPNQA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 09:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965209AbVHPNQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 09:16:00 -0400
Received: from ns2.suse.de ([195.135.220.15]:56223 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965208AbVHPNP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 09:15:59 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: taka@valinux.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
References: <20050816.131729.15816429.taka@valinux.co.jp.suse.lists.linux.kernel>
	<20050816.135425.719901536.hyoshiok@miraclelinux.com.suse.lists.linux.kernel>
	<1124171015.3215.0.camel@laptopd505.fenrus.org.suse.lists.linux.kernel>
	<20050816.191617.1025215458.hyoshiok@miraclelinux.com.suse.lists.linux.kernel>
	<1124187950.3215.31.camel@laptopd505.fenrus.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 16 Aug 2005 15:15:35 +0200
In-Reply-To: <1124187950.3215.31.camel@laptopd505.fenrus.org.suse.lists.linux.kernel>
Message-ID: <p73oe7y10qw.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:
> 
> not on kernel entry afaik.
> However just save the register on the stack and put it back at the
> end...

You need to do more than that, like disabling lazy FPU mode. 
That is what kernel_fpu_begin/end takes care of. 

However it disables preemption, which especially for bigger
copies will probably make the low latency people unhappy.

Without disabling preemption there is no way to use SSE right now.

Note that there is also an integer NT store in SSE1, however at least
in Athlon K7 it is microcoded and very slow. 

-Andi
