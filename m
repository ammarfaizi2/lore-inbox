Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263822AbTKFVYW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 16:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263830AbTKFVYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 16:24:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:26538 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263822AbTKFVX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 16:23:58 -0500
Date: Thu, 6 Nov 2003 13:18:41 -0800
From: "David S. Miller" <davem@redhat.com>
To: azarah@gentoo.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
 defined (trivial)
Message-Id: <20031106131841.4b68502e.davem@redhat.com>
In-Reply-To: <1068153535.12287.355.camel@nosferatu.lan>
References: <1068140199.12287.246.camel@nosferatu.lan>
	<20031106093746.5cc8066e.davem@redhat.com>
	<1068143563.12287.264.camel@nosferatu.lan>
	<1068144179.12287.283.camel@nosferatu.lan>
	<20031106113716.7382e5d2.davem@redhat.com>
	<1068149368.12287.331.camel@nosferatu.lan>
	<20031106120548.097ccc7c.davem@redhat.com>
	<1068150552.12287.349.camel@nosferatu.lan>
	<20031106122723.5cbe1b6d.davem@redhat.com>
	<1068153535.12287.355.camel@nosferatu.lan>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Nov 2003 23:18:55 +0200
Martin Schlemmer <azarah@gentoo.org> wrote:

> Ok - say for instance then you were to write the abi headers - how would
> you handle a case like this that -ansi forbid type long long, but it
> have to be in the struct userspace uses to pass data to the
> kernel/device ?

I can tell you what cannot happen.  You absolutely can't consider
ideas like using '__u32 val[2];' and accessor macros, long long or
whatever type the platform uses for __u64 has different alignment
constraints than the '__u32 val[2]' array thing would.

I believe there is a way to work around this by using the
__extension__ keyword when defining the __u64 typedefs.  Someone
should try playing with that.  But this is only going to work when
the compiler is GCC.

