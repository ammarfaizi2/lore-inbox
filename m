Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTEDUqq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 16:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbTEDUqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 16:46:46 -0400
Received: from rth.ninka.net ([216.101.162.244]:10183 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261702AbTEDUqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 16:46:43 -0400
Subject: Re: [PATCH] remove useless MOD_{INC,DEC}_USE_COUNT from sunrpc
From: "David S. Miller" <davem@redhat.com>
To: trond.myklebust@fys.uio.no
Cc: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <16053.25445.434038.90945@charged.uio.no>
References: <20030504191447.C10659@lst.de>
	 <16053.20430.903508.188812@charged.uio.no> <20030504203655.A11574@lst.de>
	 <16053.24599.277205.64363@charged.uio.no> <20030504205306.A11647@lst.de>
	 <16053.25445.434038.90945@charged.uio.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052075166.27465.12.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 May 2003 12:06:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-05-04 at 12:00, Trond Myklebust wrote:
> >>>>> " " == Christoph Hellwig <hch@lst.de> writes:
> 
>      > Previously you incremented the usecount and now we're waiting
>      > for the thread to finish in module_exit().
> 
> Fair enough...

Well, what if this hangs?  Unless the user specifies
"--wait" to 2.5.x's rmmod, the user absolutely does not
expect this behavior.

Rather, so that the "--wait" is respected, something one level
up ought to be doing try_module_get().

If you want to change the behavior, that's definitely to be considered,
but on a global scale not locally for sunrpc.

-- 
David S. Miller <davem@redhat.com>
