Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbUCIThY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbUCITed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:34:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33477 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262135AbUCITaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:30:52 -0500
Date: Tue, 9 Mar 2004 11:30:46 -0800
From: "David S. Miller" <davem@redhat.com>
To: "Viorel Canja, Softwin" <vcanja@bitdefender.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem in tcp_v4_synq_add ?
Message-Id: <20040309113046.40271dc8.davem@redhat.com>
In-Reply-To: <684501482.20040309132741@bitdefender.com>
References: <684501482.20040309132741@bitdefender.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2004 13:27:41 +0200
"Viorel Canja, Softwin" <vcanja@bitdefender.com> wrote:

> Shouldn't  "write_lock(&tp->syn_wait_lock);" be moved before
> "req->dl_next = lopt->syn_table[h];" to avoid a race condition ?

Nope, the listening socket's socket lock is held, and all things that
add members to these hash chains hold that lock.
