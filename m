Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266554AbUF3FOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266554AbUF3FOO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 01:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266557AbUF3FOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 01:14:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39068 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266554AbUF3FOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 01:14:08 -0400
Date: Tue, 29 Jun 2004 22:13:41 -0700
From: "David S. Miller" <davem@redhat.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: inconsistency between SIOCGIFCONF and SIOCGIFNAME
Message-Id: <20040629221341.52824096.davem@redhat.com>
In-Reply-To: <40E24573.5030403@redhat.com>
References: <40E0EAC1.50101@redhat.com>
	<20040629012604.20c3ad8b.davem@redhat.com>
	<40E1BE7D.7070806@redhat.com>
	<20040629141915.0268b741.davem@redhat.com>
	<40E24573.5030403@redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2004 21:45:39 -0700
Ulrich Drepper <drepper@redhat.com> wrote:

> When was the netlink interface introduced?  The ioctl() code is most
> probably older and therefore we would still get wrong results on old
> kernels.  I don't know the reason why  you hesitate, but the patch seems
> really harmless and, as you pointed out, more compatible with the BSD
> version.

RTNETLINK interfaces to get link information has existed since at
least 2.0.x or something :-)  In fact, the first RTNETLINK codes
are the ones to obtain and set link information.

All of these BSD ioctls are deprecated interfaces, back compatability
hacks if you real, and the recommended interface to change link and
route information is RTNETLINK.

I really hesitate to change the ioctl() code, because basically my
suggested change puts effectively an AF_UNSPEC address there (this
is what you get with a zero'd out sockaddr_t).  Who knows what that
means.  Sure most apps will ignore it but I absolutely do not want
to take the chance.

This is especially unnecessary since rtnetlink does exactly what you
want already, so we don't need to add a new interface nor change the
semantics of an old one.
