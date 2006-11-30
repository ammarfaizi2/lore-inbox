Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967977AbWK3XX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967977AbWK3XX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 18:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967978AbWK3XX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 18:23:57 -0500
Received: from colin.muc.de ([193.149.48.1]:44299 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S967977AbWK3XX4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 18:23:56 -0500
Date: 1 Dec 2006 00:23:54 +0100
Date: Fri, 1 Dec 2006 00:23:54 +0100
From: Andi Kleen <ak@muc.de>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic_cmpxchg return type error
Message-ID: <20061130232354.GA12359@muc.de>
References: <20061130211705.GA12987@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130211705.GA12987@Krystal>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 04:17:06PM -0500, Mathieu Desnoyers wrote:
> Hi,
> 
> I just noticed that a atomic_cmpxchg, that would be given an atomic64_t
> parameter, would cast the return value as a (int). In the typical use of this
> primitive, the result would be that the 32 MSB would be lost when comparing
> against the original value. It also affects atomic_add_unless. Note that there
> is no atomic64_cmpxchg nor atomic64_add_unless, which might make things a
> little clearer.

Normally you're supposed to only use atomic64_* with atomic64_t

While it works for most by accident on x86 to just use atomic_* 
with atomic64_t it's not portable to other architectures.

If you want to use those with atomic64_t suitable macros would need
to be added on all architectures.

-Andi
