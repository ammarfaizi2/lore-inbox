Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268160AbTGIKdC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 06:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268172AbTGIKdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 06:33:01 -0400
Received: from air-2.osdl.org ([65.172.181.6]:65512 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268160AbTGIKbz (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 06:31:55 -0400
Date: Wed, 9 Jul 2003 03:46:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Linux-Kernel@vger.kernel.org
Subject: Re: [PATCH] 2/5 VM changes: skip-writepage.patch
Message-Id: <20030709034654.53172638.akpm@osdl.org>
In-Reply-To: <16139.61796.951198.414088@laputa.namesys.com>
References: <16139.54921.640901.797268@laputa.namesys.com>
	<20030709031242.14e89af6.akpm@osdl.org>
	<16139.61796.951198.414088@laputa.namesys.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov <Nikita@Namesys.COM> wrote:
>
> By the way, have you noted that patch changes wbc.nonblocking to be 0,
>  if called from kswapd or pdflush, what do you think?

pdflush isn't likely to enter direct reclaim much, but it is important that
pdflush not block on request queues.  We want a single pdflush thread to be
able to keep a large number of requests queues saturated.

