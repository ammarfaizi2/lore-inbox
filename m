Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268524AbUINFo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268524AbUINFo2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 01:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268993AbUINFo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 01:44:28 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:53930
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268524AbUINFoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 01:44:25 -0400
Date: Mon, 13 Sep 2004 22:42:32 -0700
From: "David S. Miller" <davem@davemloft.net>
To: hadi@cyberus.ca
Cc: lkml@einar-lueck.de, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC][PATCH 2/2] ip multipath, bk head (EXPERIMENTAL)
Message-Id: <20040913224232.4b979c7d.davem@davemloft.net>
In-Reply-To: <1095129624.1060.45.camel@jzny.localdomain>
References: <41457848.6040808@de.ibm.com>
	<1095129624.1060.45.camel@jzny.localdomain>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Sep 2004 22:40:24 -0400
jamal <hadi@cyberus.ca> wrote:

> As long as whatever arrangement ensures that no packet reordering
> happens, should be sane. Yes, current scheme is broken in some ways (but
> guarantees packet ordering within a flow).

I think his changes ensure this as well, at least for local system
sockets.  You'll only get a new hop each time a route lookup is
performed, which is only done once per socket unless the path
becomes "sick" and TCP decides to try and do a relookup of the
destination.

I'm kind of ambivalent about these changes.  I definitely like the
first patch which cleans up those huge functions in route.c :-)
But there are things I like about the current behavior, although I
understand why people want things to work the way Einar is changing
it to.
