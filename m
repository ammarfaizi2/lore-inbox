Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUFEVIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUFEVIM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 17:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUFEVIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 17:08:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16041 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262045AbUFEVII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 17:08:08 -0400
Date: Sat, 5 Jun 2004 14:05:44 -0700
From: "David S. Miller" <davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: olh@suse.de, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] compat bug in sys_recvmsg, MSG_CMSG_COMPAT check
 missing
Message-Id: <20040605140544.0de4034d.davem@redhat.com>
In-Reply-To: <20040605140153.6c5945a0.davem@redhat.com>
References: <20040605204334.GA1134@suse.de>
	<20040605140153.6c5945a0.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Replying to myself :-) ]

On Sat, 5 Jun 2004 14:01:53 -0700
"David S. Miller" <davem@redhat.com> wrote:

> Let's ask a better question, why do we need to pass this thing down
> into the implementations anyways?

It's for net/core/scm.c handling, sigh.

This means also that Olaf's patch is broken, when CONFIG_COMPAT is not
set, MSG_CMSG_COMPAT is zero, thus ~MSG_CMSG_COMPAT is the unexpected
value all 1's thus breaking the tests for unexpected flags completely.

Any better ideas?
