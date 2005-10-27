Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbVJ0S1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbVJ0S1T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 14:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVJ0S1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 14:27:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52459 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751439AbVJ0S1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 14:27:18 -0400
Date: Thu, 27 Oct 2005 11:26:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: rajesh.shah@intel.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] export cpu_online_map
Message-Id: <20051027112635.3d0a7199.akpm@osdl.org>
In-Reply-To: <20051027063859.20fcb9bb.pj@sgi.com>
References: <200510260421.j9Q4LGh9014087@shell0.pdx.osdl.net>
	<20051026205038.26a1c333.pj@sgi.com>
	<20051026210803.07efba69.akpm@osdl.org>
	<20051027015504.5a20ed05.pj@sgi.com>
	<20051027023548.0471db17.akpm@osdl.org>
	<20051027063859.20fcb9bb.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Andrew wrote:
> > Sweet, thanks.  Perhaps we can remove cpu_online_map from UP builds soon -
> > it's really wrong to have it there.
> 
> Eh ... my gut reaction is different.   Even uni-processors have
> online cpus - just not very many of them (and hot unplugging one
> of them is frowned on).

That's daft.  A uniprocessor machine has one and only one CPU and it's
always online!   An online_map is only needed for MP.

Now conceptually, yes, we should be able to query and perhaps set the
onlineness of a CPU.  But that doesn't mean that we should have storage
which idiotically remembers something which was known at compile time.

>  Why make special cases when it serves no purpose?

Ths presence of cpu_online_map in UP builds _is_ a special case.  The
kernel's overall approach to such things is to optimise them away at
compile time for !SMP builds.

