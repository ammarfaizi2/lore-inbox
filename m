Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264987AbTL1J1m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 04:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbTL1J1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 04:27:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6589 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264987AbTL1J1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 04:27:41 -0500
Date: Sun, 28 Dec 2003 01:23:29 -0800
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: acme@conectiva.com.br, mpm@selenic.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH-2.6.0-tiny] "uninline" {lock,release}_sock
Message-Id: <20031228012329.43003de5.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0312280017060.2274@home.osdl.org>
References: <20031228075426.GB24351@conectiva.com.br>
	<Pine.LNX.4.58.0312280017060.2274@home.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Dec 2003 00:23:07 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> Function calls aren't all that expensive, especially with FASTCALL() etc 
> to show that you don't have to follow the common calling conventions. 
> Right now I think FASTCALL() only matters on x86, but some other 
> architectures could make it mean "smaller call clobbered list" or similar.
> 
> Have you benchmarked with the smaller kernel? 

To be honest I think {lock,release}_sock() should both be uninlined
always.

It almost made sense to inline these things before the might_sleep()
was added, now it definitely makes no sense.

