Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVBXKr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVBXKr1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 05:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVBXKr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 05:47:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:49061 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262190AbVBXKrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 05:47:24 -0500
Date: Thu, 24 Feb 2005 02:46:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: linux-kernel@vger.kernel.org, johnpol@2ka.mipt.ru,
       elsa-devel@lists.sourceforge.net, jlan@engr.sgi.com, gh@us.ibm.com,
       efocht@hpce.nec.com
Subject: Re: [PATCH 2.6.11-rc4-mm1] connector: Add a fork connector
Message-Id: <20050224024605.76e7369f.akpm@osdl.org>
In-Reply-To: <1109240677.1738.196.camel@frecb000711.frec.bull.fr>
References: <1109240677.1738.196.camel@frecb000711.frec.bull.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
>
>  +#define CN_FORK_MSG_SIZE 	sizeof(struct cn_msg) + CN_FORK_INFO_SIZE

This really should be parenthesized.

>  +spinlock_t fork_cn_lock = SPIN_LOCK_UNLOCKED;

This should have static scope, and could be local to fork_connector().

Please use DEFINE_SPINLOCK().  (There's a reason for this, but I forget
what it was).

>  +static inline void fork_connector(pid_t parent, pid_t child)
>  +{
>  +	static const struct cb_id fork_id = { CN_IDX_FORK, CN_VAL_FORK };

It's a bit lame to have two copies of this.  Maybe have just a single copy,
declare it in connector.h?

