Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVAQHvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVAQHvF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 02:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbVAQHvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 02:51:05 -0500
Received: from ozlabs.org ([203.10.76.45]:63905 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261296AbVAQHvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 02:51:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16875.28257.239324.486966@cargo.ozlabs.ibm.com>
Date: Mon, 17 Jan 2005 18:50:57 +1100
From: Paul Mackerras <paulus@samba.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, mingo@elte.hu,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: Horrible regression with -CURRENT from "Don't busy-lock-loop in preemptable spinlocks" patch
In-Reply-To: <20050117073345.GA3616@taniwha.stupidest.org>
References: <20050117055044.GA3514@taniwha.stupidest.org>
	<20050116230922.7274f9a2.akpm@osdl.org>
	<20050117073345.GA3616@taniwha.stupidest.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood writes:

> +#define rwlock_is_write_locked(x) ((x)->lock == 0)

AFAICS on i386 the lock word, although it goes to 0 when write-locked,
can then go negative temporarily when another cpu tries to get a read
or write lock.  So I think this should be

((signed int)(x)->lock <= 0)

(or the equivalent using atomic_read).

Paul.
