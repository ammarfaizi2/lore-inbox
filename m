Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267852AbUHWVbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267852AbUHWVbr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267867AbUHWVXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:23:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5608 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267873AbUHWVTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 17:19:47 -0400
Date: Mon, 23 Aug 2004 14:19:04 -0700
From: "David S. Miller" <davem@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, zdzichu@irc.pl, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm4
Message-Id: <20040823141904.670a8ec6.davem@redhat.com>
In-Reply-To: <1093288507.29850.43.camel@localhost.localdomain>
References: <20040822013402.5917b991.akpm@osdl.org>
	<20040823182113.GA30882@irc.pl>
	<1093285874.29822.19.camel@localhost.localdomain>
	<20040823124013.19ceb34f.akpm@osdl.org>
	<1093288507.29850.43.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004 20:15:08 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Networking too gets fun because you can send a
> packet and want to report that you did something before the fault
> occurred.

Networking doesn't check the return value any more Alan.
What it does do is not return the error if we moved
some bytes already from the socket (from a previous
iovec entry, for example).

Even the pipe code, which is what instigated this silly
return value to begin with, doesn't even check it any
more.

Even the serial driver cases you mention, which I have
looked at, can be converted neatly.

This is really the right change.  Or, care to audit and
fix every platform's user copy implementation? :-)  People
who are experts and work every day on their platform get
this stuff wrong, myself included.  This means we are too
dumb to debug this code, according to The Practice of
Programming :-)  When people get this wrong it's exploitable,
as you mentioned, so double the reason to make it as simple
as possible.
