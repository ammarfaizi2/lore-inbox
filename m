Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269301AbUJFPpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269301AbUJFPpb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269289AbUJFPmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:42:51 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:34195
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269315AbUJFPmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:42:22 -0400
Date: Wed, 6 Oct 2004 08:41:28 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: root@chaos.analogic.com, joris@eljakim.nl, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-Id: <20041006084128.38e9970d.davem@davemloft.net>
In-Reply-To: <41640FE2.3080704@nortelnetworks.com>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
	<20041006080104.76f862e6.davem@davemloft.net>
	<Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
	<20041006082145.7b765385.davem@davemloft.net>
	<41640FE2.3080704@nortelnetworks.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Oct 2004 09:31:46 -0600
Chris Friesen <cfriesen@nortelnetworks.com> wrote:

> David S. Miller wrote:
> 
> > So if select returns true, and another one of your threads
> > reads all the data from the file descriptor, what would you
> > like the behavior to be for the current thread when it calls
> > read?
> 
> What about the single-threaded case?

Incorrect UDP checksums could cause the read data to
be discarded.  We do the copy into userspace and checksum
computation in parallel.  This is totally legal and we've
been doing it since 2.4.x first got released.

Use non-blocking sockets with select()/poll() and be happy.
