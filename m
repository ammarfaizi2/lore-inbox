Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752253AbWFXOmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253AbWFXOmf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 10:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752256AbWFXOmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 10:42:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57558 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752252AbWFXOme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 10:42:34 -0400
Subject: Re: [PATCH] x86: cache pollution aware __copy_from_user_ll()
From: Arjan van de Ven <arjan@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, torvalds@osdl.org
In-Reply-To: <200606231501.k5NF1B79002899@hera.kernel.org>
References: <200606231501.k5NF1B79002899@hera.kernel.org>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 16:42:32 +0200
Message-Id: <1151160152.3181.59.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-23 at 15:01 +0000, Linux Kernel Mailing List wrote:
> commit c22ce143d15eb288543fe9873e1c5ac1c01b69a1
> tree dc7d457b8952fc50dfc90df659b35de4117c61fc
> parent 7dbdf43cfa635ddc3701cc8d1eab07597cd731c0
> author Hiro Yoshioka <hyoshiok@miraclelinux.com> Fri, 23 Jun 2006 16:04:16 -0700
> committer Linus Torvalds <torvalds@g5.osdl.org> Fri, 23 Jun 2006 21:42:56 -0700
> 
> [PATCH] x86: cache pollution aware __copy_from_user_ll()
> 
> Use the x86 cache-bypassing copy instructions for copy_from_user().
> 
> Some performance data are
> 
> Total of GLOBAL_POWER_EVENTS (CPU cycle samples)
> 
> 2.6.12.4.orig    1921587
> 2.6.12.4.nt      1599424
> 1599424/1921587=83.23% (16.77% reduction)

Hi,

while this patch will reduce the number of cycles spent in the kernel,
it's just pushing the cache miss to userspace (by virtue of doing a
cache flush effectively)... is this really the right thing? The total
memory bandwidth will actually increase with this patch if you're
unlucky (eg if userspace decides to write to this memory eventually)....

Greetings,
   Arjan van de Ven

