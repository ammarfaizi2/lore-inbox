Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270520AbTG1UGl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270585AbTG1UGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:06:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:12487 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270520AbTG1UGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:06:39 -0400
Date: Mon, 28 Jul 2003 12:54:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: ldl@aros.net, linux-kernel@vger.kernel.org
Subject: Re: PATCH: fix 2 byte data leak due to padding
Message-Id: <20030728125449.31981939.akpm@osdl.org>
In-Reply-To: <1059391969.15438.16.camel@dhcp22.swansea.linux.org.uk>
References: <200307272019.h6RKJ1Et029763@hraefn.swansea.linux.org.uk>
	<3F249D42.4010003@aros.net>
	<1059391969.15438.16.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Llu, 2003-07-28 at 04:49, Lou Langholtz wrote:
> > >+	memset(&tmp, 0, sizeof(struct __old_kernel_stat));
> > >
> > Wouldn't it be more clear (better) to use sizeof(tmp) here rather than 
> > sizeof(struct _old_kernel_stat)?
> 
> sizeof(variable) can be suprising some times so I always use sizeof(type) out
> of habit. (Think sizeof(x) when X later becomes a pointer)

#define memzero(addr) memset(addr, 0, sizeof(*addr))

would robustify a lot of these things...

