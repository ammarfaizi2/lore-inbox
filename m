Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbUCJVjb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbUCJVid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:38:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5086 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262864AbUCJVhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 16:37:42 -0500
Date: Wed, 10 Mar 2004 13:37:34 -0800
From: "David S. Miller" <davem@redhat.com>
To: Paul Wagland <paul@wagland.net>
Cc: vcanja@bitdefender.com, linux-kernel@vger.kernel.org
Subject: Re: problem in tcp_v4_synq_add ?
Message-Id: <20040310133734.0758f5e2.davem@redhat.com>
In-Reply-To: <F750F6B1-7271-11D8-AFFE-000A95CD704C@wagland.net>
References: <684501482.20040309132741@bitdefender.com>
	<20040309113046.40271dc8.davem@redhat.com>
	<F750F6B1-7271-11D8-AFFE-000A95CD704C@wagland.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004 10:04:41 +0100
Paul Wagland <paul@wagland.net> wrote:

> > Nope, the listening socket's socket lock is held, and all things that
> > add members to these hash chains hold that lock.
> 
> Is that the same as saying that the write_lock() is not needed at all? 
> Since it is already guaranteed to be protected with a different lock?

Also not true, as other pieces of code traverse the list as a reader
without holding the listening sockets lock.
