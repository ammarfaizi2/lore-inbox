Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbWEKALf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbWEKALf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 20:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbWEKALf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 20:11:35 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40072
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965101AbWEKALe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 20:11:34 -0400
Date: Wed, 10 May 2006 17:11:27 -0700 (PDT)
Message-Id: <20060510.171127.42619262.davem@davemloft.net>
To: paulus@samba.org
Cc: rth@twiddle.net, t@twiddle.net, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, amodra@bigpond.net
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <17506.31456.68099.57515@cargo.ozlabs.ibm.com>
References: <20060510154702.GA28938@twiddle.net>
	<17506.29128.591758.502430@cargo.ozlabs.ibm.com>
	<17506.31456.68099.57515@cargo.ozlabs.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Mackerras <paulus@samba.org>
Date: Thu, 11 May 2006 09:44:32 +1000

> That means we lose the possible optimization of combining the addi
> into a following load or store.  Bah.  However, I guess it's still
> better than what we do at the moment.

If you have to hide the operation so deeply like this, maybe you can
do something similar to sparc64, by explicitly doing the per-cpu fixed
register and offsets, and still get the single instruction relocs that
powerpc can do for up to 64K by doing something like:

	&per_cpu_blah - &per_cpu_base

to calculate the offset.
