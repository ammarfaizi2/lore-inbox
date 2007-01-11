Return-Path: <linux-kernel-owner+w=401wt.eu-S1751511AbXAKVut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbXAKVut (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 16:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbXAKVut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 16:50:49 -0500
Received: from smtp.osdl.org ([65.172.181.24]:37506 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbXAKVus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 16:50:48 -0500
Date: Thu, 11 Jan 2007 13:49:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pierre Peiffer <pierre.peiffer@bull.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       Jakub Jelinek <jakub@redhat.com>, Darren Hart <dvhltc@us.ibm.com>,
       =?ISO-8859-1?Q?S=E9b?= =?ISO-8859-1?Q?astien_Dugu=E9?= 
	<sebastien.dugue@bull.net>
Subject: Re: [PATCH 2.6.20-rc4 4/4][RFC] sys_futex64 : allows 64bit futexes
Message-Id: <20070111134904.44d89572.akpm@osdl.org>
In-Reply-To: <45A3C1F6.4020503@bull.net>
References: <45A3B330.9000104@bull.net>
	<45A3C1F6.4020503@bull.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jan 2007 17:25:26 +0100
Pierre Peiffer <pierre.peiffer@bull.net> wrote:

>   static inline int
> +futex_atomic_op_inuser64 (int encoded_op, u64 __user *uaddr)

Your email client performs space-stuffing.  Please see if you can turn that
off.  (It's fixable at my end with s/^ /^/g but it's a nuisance).

> +{
> +	int op = (encoded_op >> 28) & 7;
> +	int cmp = (encoded_op >> 24) & 15;
> +	u64 oparg = (encoded_op << 8) >> 20;
> +	u64 cmparg = (encoded_op << 20) >> 20;
> +	u64 oldval = 0, ret, tem;
> +
> +	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
> +		oparg = 1 << oparg;
> +
> +	if (! access_ok (VERIFY_WRITE, uaddr, sizeof(u64)))
> +		return -EFAULT;
> +
> +	inc_preempt_count();

What is that open-coded, uncommented inc_preempt_count() doing in there?
