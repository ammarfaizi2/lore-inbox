Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbUKEASK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbUKEASK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 19:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbUKEASK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 19:18:10 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:14044
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262494AbUKEASG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:18:06 -0500
Date: Thu, 4 Nov 2004 16:06:55 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Patrick McHardy <kaber@trash.net>
Cc: matthias.andree@gmx.de, netfilter-devel@lists.netfilter.org,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Fix ip_conntrack_amanda data corruption bug that
 breaks amanda dumps
Message-Id: <20041104160655.1c66b7ef.davem@davemloft.net>
In-Reply-To: <418AC0F2.7020508@trash.net>
References: <20041104121522.GA16547@merlin.emma.line.org>
	<418A7B0B.7040803@trash.net>
	<20041104231734.GA30029@merlin.emma.line.org>
	<418AC0F2.7020508@trash.net>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Nov 2004 00:53:22 +0100
Patrick McHardy <kaber@trash.net> wrote:

> Your observation and your patch were correct, thanks. It is supposed
> to be just a copy, I missed that it wasn't anymore. While your patch
> works too, and is even faster with non-linear skbs, I don't like the
> idea of using the skb as a scratch-area, so I sent this patch to Dave
> instead.

His patch isn't correct, even making a temporary change to
a shared SKB is illegal.  Things like tcpdump could see
corrupt SKB contents if they look during that tiny window
when the newline character has been changed to NULL by
the amanda conntrack module.

