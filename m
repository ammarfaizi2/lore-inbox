Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269440AbUJFXk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269440AbUJFXk4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269653AbUJFXg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:36:58 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:26780
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269620AbUJFXgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:36:00 -0400
Date: Wed, 6 Oct 2004 16:35:01 -0700
From: "David S. Miller" <davem@davemloft.net>
To: "Martijn Sipkema" <martijn@entmoot.nl>
Cc: cfriesen@nortelnetworks.com, hzhong@cisco.com, aebr@win.tue.nl,
       joris@eljakim.nl, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-Id: <20041006163501.20712272.davem@davemloft.net>
In-Reply-To: <009f01c4abed$c0833680$161b14ac@boromir>
References: <003701c4abde$fb251f60$b83147ab@amer.cisco.com>
	<4164514F.2040006@nortelnetworks.com>
	<009f01c4abed$c0833680$161b14ac@boromir>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004 22:45:08 +0100
"Martijn Sipkema" <martijn@entmoot.nl> wrote:

> The current behavious is definately not POSIX compliant; returning an error
> is better in any case

Not true at all.  We in fact used to return -EAGAIN if the
checksum failed and the socket was blocking, and Olaf Kirch
pointed that out so we changed it to block instead and wait
for the next packet to arrive instead which is the correct
behavior.

People, get the heck over this.  The kernel has behaved this way
for more than 3 years both in 2.4.x and 2.6.x.  The code in question
even exists in the 2.2.x sources as well.

Therefore, it would be totally pointless to change the behavior
now since anyone writing an application wishing it to work on
all existing Linux kernels needs to handle this case anyways.

Like stated earlier, use non-blocking sockets with select()/poll()
and be happy.
