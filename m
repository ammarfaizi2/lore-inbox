Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268435AbUILDs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268435AbUILDs1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 23:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268425AbUILDs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 23:48:27 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:62105
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268435AbUILDsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 23:48:22 -0400
Date: Sat, 11 Sep 2004 20:47:10 -0700
From: "David S. Miller" <davem@davemloft.net>
To: "Wolfpaw - Dale Corse" <admin@wolfpaw.net>
Cc: linux-kernel@vger.kernel.org, grsecurity@grsecurity.net,
       bugtraq@securityfocus.com
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local (probable Remote) Denial
 of Service
Message-Id: <20040911204710.4aa7abed.davem@davemloft.net>
In-Reply-To: <000001c49872$99333460$0200a8c0@wolf>
References: <022601c49866$9e8aa8f0$0300a8c0@s>
	<000001c49872$99333460$0200a8c0@wolf>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004 20:45:43 -0600
"Wolfpaw - Dale Corse" <admin@wolfpaw.net> wrote:

> As for it being an application bug - it may be one in Mysql not
> closing the sockets, but it is a Kernel Bug that allows CLOSE_WAIT
> sockets to clog up the connection queues, and cause a DOS conditions
> on other applications (such as Apache). Since most software used for
> denial of service is badly written (intentionally) to exploit the
> holes, the error should be fixed, not blamed on faulty software.

If the application doesn't close it's file descriptors there is
absolutely nothing the kernel can do about it.

It's a resource leak, plain and simple.

> That being said - below is a the proper description, and the code
> used to exploit it. Hope it helps. This version is not the one
> which invokes the CLOSE_WAIT state, but rather the TIME_WAIT one,
> I am not able to publish the source code for the CLOSE_WAIT bug.

There is nothing wrong with creating tons of TIME_WAIT sockets,
they simply time out after 60 seconds (unless hit by a RESET
packet or similar).  This is how TCP works.

> The log however clearly shows that a mysql descriptor is closed, 
> and then used immediately again by the socket call, which causes it 
> never to end up getting closed. Linux apparently has either no 
> timeout for CLOSE_WAIT, or it's a very very long one.. Either way 
> is a bad thing.

Please do us all a favor and learn how TCP works.

CLOSE_WAIT means simply that only one side of the TCP
connection has done a close.  Therefore the other end
stays open until that side closes as well.

There is no way to "time things out" or release the
state.
