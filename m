Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268167AbUHYRNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268167AbUHYRNI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 13:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268169AbUHYRNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 13:13:08 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:13284 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268167AbUHYRNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 13:13:04 -0400
Subject: Re: [PATCH] interrupt driven hvc_console as vio device
From: Ryan Arnold <rsa@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040824214950.5d9043a3.akpm@osdl.org>
References: <1093394937.3402.83.camel@localhost>
	 <20040824214950.5d9043a3.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM
Message-Id: <1093410773.3402.111.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 25 Aug 2004 00:12:53 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 23:49, Andrew Morton wrote:

> >  +	spin_lock_irqsave(&hp->lock, flags);
> >  +	retval = N_OUTBUF - hp->n_outbuf;
> >  +	spin_unlock_irqrestore(&hp->lock, flags);

> The new locking in these functions doesn't really do anything, apart from
> adding memory barriers.  If that's what you really want, I suggest you
> simply add (commented) memory barriers.

Since chars_in_buffer() can be called from the tty write task and the
n_outbuf value is changed from the hvc_console task I didn't want there
to be any confusion as to the real value of the variable when
chars_in_buffer() was reading it.  Is this the proper scenario for a
memory barrier?

Ryan S. Arnold
IBM Linux Technology Center

