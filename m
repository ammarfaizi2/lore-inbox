Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbUCRD2T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 22:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUCRD2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 22:28:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:48267 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261437AbUCRD2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 22:28:16 -0500
Date: Wed, 17 Mar 2004 19:28:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Kenneth Chen" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: add lowpower_idle sysctl
Message-Id: <20040317192821.1fe90f24.akpm@osdl.org>
In-Reply-To: <200403180318.i2I3IDF03166@unix-os.sc.intel.com>
References: <20040317170436.430acfbe.akpm@osdl.org>
	<200403180318.i2I3IDF03166@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kenneth Chen" <kenneth.w.chen@intel.com> wrote:
>
>  > > Logically it means a sysctl entry in /proc/sys/kernel.
>  > Yes, but the *meanings* of the different values of that sysctl need
>  > to be defined, and documented.  If lowpower_idle=42 has a totally
>  > different meaning on different architectures then that's unfortunate
>  > but understandable.  But we should at least enumerate the different
>  > values and try to get different architectures to honour `42' in the
>  > same way.
> 
>  Writing to sysctl should be a bool, reading the value can be number of
>  module currently disabled low power idle.  I think the original intent
>  is to use ref count for enabling/disabling.  (granted, we copied the
>  code from other arch).

OK, so why not give us:

#define IDLE_HALT			0
#define IDLE_POLL			1
#define IDLE_SUPER_LOW_POWER_HALT	2

and so forth (are there any others?).

Set some system-wide integer via a sysctl and let the particular
architecture decide how best to implement the currently-selected idle mode?

