Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbTJOEjl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 00:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTJOEjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 00:39:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:48845 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262232AbTJOEjk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 00:39:40 -0400
Date: Tue, 14 Oct 2003 21:38:22 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, clock@twibright.com
Subject: Re: Vortex 3c900 passing driver parameters
Message-Id: <20031014213822.5382c84e.rddunlap@osdl.org>
In-Reply-To: <20031014211316.64c7eeb9.akpm@osdl.org>
References: <20031014205702.140b6476.rddunlap@osdl.org>
	<20031014211316.64c7eeb9.akpm@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Oct 2003 21:13:16 -0700 Andrew Morton <akpm@osdl.org> wrote:

| "Randy.Dunlap" <rddunlap@osdl.org> wrote:
| >
| > Andrew Morton wrote:
| > | Karel Kulhavý <clock@twibright.com> wrote:
| > | >
| > | > Hello
| > | > 
| > | > How do I do a ether=... (kernel boot-time) equivalent of
| > | > insmod 3c59x.o options=0x201 full_duplex=1 ?
| > | 
| > | Unfortunately you cannot.  `ether=' is broken for all drivers which use the
| > | new(ish) alloc_etherdev() API.
| > | 
| > | It is due to ordering problems: the name of the interface is not known at
| > | the time of parsing the setup info and nobody has got down and worked out
| > | how to fix it.
| > 
| > Does this ordering problem apply to both 2.4.current and 2.6.0-test?
| 
| Well it was a problem a year or so ago.
| 
| But init_netdev()'s call to netdev_boot_setup_check() looks like it
| should fix things up, so I'm not sure what's going on...

[I'm looking at 2.4.22 since that is where the problem was reported.]

I don't see anything in 3c59x.c that calls init_netdev().
vortex_probe1() calls alloc_etherdev().
It doesn't call init_etherdev() -> init_netdev(),
AFAICT. ??

But I agree with you, I think there is still an ordering problem.

--
~Randy
