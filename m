Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266295AbUG0Oik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUG0Oik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 10:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266293AbUG0Oik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 10:38:40 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:21216 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S266295AbUG0Oii
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 10:38:38 -0400
Date: Tue, 27 Jul 2004 17:38:23 +0300 (EEST)
From: Pasi Valminen <okun@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Remotely triggered kernel panic on PPPoE + IPv6 enabled linux
 boxes
Message-ID: <Pine.GSO.4.58.0407271720390.4851@kekkonen.cs.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can trigger a kernel panic from a remote host using tracepath6.
> First I connect to the internet using pppoe.
PPPoE is not needed to crash the kernel. Plain vanilla 2.6.7 will crash
just fine without it, seems like bringing up an ipv6 tunnel is enough.
Then just

$ tracepath6 <your tunnel ipv6 endpoint>

from a remote host and the kernel panics without any entry in the syslog.
But there is a quick and easy workaround. If you modprobe ip6table_filter,
the kernel won't panic!

Also when the ip6table_filter is not loaded, the tracepath never succeeds,
so I guess the first packet crashes the box. On the otherhand when
ip6table_filter is loaded, the tracepath succeeds as expected.
