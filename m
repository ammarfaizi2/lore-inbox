Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTJ0Gjr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 01:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbTJ0Gjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 01:39:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:47293 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261190AbTJ0Gjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 01:39:46 -0500
Date: Sun, 26 Oct 2003 22:33:18 -0800
From: "David S. Miller" <davem@redhat.com>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, grof@dragon.cz,
       volf@dragon.cz
Subject: Re: possible bug in tcp_input.c
Message-Id: <20031026223318.41917bb0.davem@redhat.com>
In-Reply-To: <20031026065519.GC28035@louise.pinerecords.com>
References: <20031024162959.GB11154@louise.pinerecords.com>
	<20031024193034.30f1caed.davem@redhat.com>
	<20031026065519.GC28035@louise.pinerecords.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Oct 2003 07:55:19 +0100
Tomas Szepe <szepe@pinerecords.com> wrote:

> Dave, we've been thinking about this some more and have concluded
> that since the problem is a relatively non-fatal one, the kernel
> should just print out an "assertion failed" error similar to the
> one in tcp_input.c, line 1323 [BUG_TRAP(cnt <= tp->packets_out);]
> and maybe fix things up a little rather than oops on a NULL pointer
> dereference;  The state in question, although invalid, is possible
> and should IMHO be checked for as in all the other "if (skb != NULL)
> ..." places).

If this condition triggers, the lists are corrupt and the kernel
should not try to access this socket in any way whatsoever
past this point.

Therefore it should OOPS, which is exactly what it does now.
A BUG_ON() is an equivalent response as far as I am concerned,
it has the same exact result, and the backtrace shows where the
problem is occuring.
