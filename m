Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVCBOw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVCBOw7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 09:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbVCBOw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 09:52:59 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:3788 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262312AbVCBOwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 09:52:46 -0500
Date: Wed, 2 Mar 2005 06:51:52 -0800
From: Paul Jackson <pj@sgi.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, johnpol@2ka.mipt.ru,
       elsa-devel@lists.sourceforge.net, jlan@engr.sgi.com, gh@us.ibm.com,
       efocht@hpce.nec.com, netdev@oss.sgi.com, kaigai@ak.jp.nec.com
Subject: Re: [PATCH 2.6.11-rc4-mm1] connector: Add a fork connector
Message-Id: <20050302065152.79d9fba2.pj@sgi.com>
In-Reply-To: <1109753292.8422.117.camel@frecb000711.frec.bull.fr>
References: <1109240677.1738.196.camel@frecb000711.frec.bull.fr>
	<1109753292.8422.117.camel@frecb000711.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume wrote:
> 
>   I also run the lmbench and results are send in response to another
> thread "A common layer for Accounting packages". When fork connector is
> turned off the overhead is negligible. 

Good.

If I read this code right:
>
> +static inline void fork_connector(pid_t parent, pid_t child)
> +{
> +	static DEFINE_SPINLOCK(cn_fork_lock);
> +	static __u32 seq;   /* used to test if message is lost */
> +
> +	if (cn_fork_enable) {

then the code executed if the fork connector is off is a call to an
inline function that tests an integer, finds it zero, and returns.

This is sufficiently little code that I for one would hardly
even need lmbench to be comfortable that fork() wasn't impacted
seriously, in the case that the fork connector is disabled.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
