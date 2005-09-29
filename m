Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbVI2Jnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVI2Jnp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 05:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVI2Jnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 05:43:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42939 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751172AbVI2Jno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 05:43:44 -0400
Date: Thu, 29 Sep 2005 02:43:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: davidel@xmailserver.org, nacc@us.ibm.com, nish.aravamudan@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] 2.6.14-rc2-mm1: fixes for overflow
 msec_to_jiffies()
Message-Id: <20050929024312.2f3a9e80.akpm@osdl.org>
In-Reply-To: <20050924194418.GC26197@alpha.home.local>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain>
	<20050924040534.GB18716@alpha.home.local>
	<29495f1d05092321447417503@mail.gmail.com>
	<20050924061500.GA24628@alpha.home.local>
	<20050924171928.GF3950@us.ibm.com>
	<Pine.LNX.4.63.0509241120380.31327@localhost.localdomain>
	<20050924193839.GB26197@alpha.home.local>
	<20050924194418.GC26197@alpha.home.local>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> wrote:
>
> +#if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
>  +#  define MAX_MSEC_OFFSET \
>  +	(ULONG_MAX - (MSEC_PER_SEC / HZ) + 1)

That generates numbers which don't fit into unsigned ints, yielding vast
numbers of

include/linux/jiffies.h: In function `msecs_to_jiffies':
include/linux/jiffies.h:310: warning: comparison is always false due to limited range of data type
include/linux/jiffies.h: In function `usecs_to_jiffies':
include/linux/jiffies.h:323: warning: comparison is always false due to limited range of data type


