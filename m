Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265886AbUF2SXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265886AbUF2SXG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 14:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265890AbUF2SXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 14:23:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:53145 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265886AbUF2SXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 14:23:01 -0400
Date: Tue, 29 Jun 2004 11:22:56 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Debi Janos <debi.janos@freemail.hu>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>
Subject: Re: 2.6.7-mm1 - 2.6.7-mm4 weird http behavior
Message-Id: <20040629112256.58828632@dell_ss3.pdx.osdl.net>
In-Reply-To: <freemail.20040529152006.85505@fm4.freemail.hu>
References: <freemail.20040529152006.85505@fm4.freemail.hu>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2004 15:20:06 +0200 (CEST)
Debi Janos <debi.janos@freemail.hu> wrote:

> I am found an interesting (bug?) feature in kernels between
> 2.6.7-mm1 and 2.6.7-mm4
> 
> Some web pages eg. 
> 
> http://www.hup.hu/
> http://portal.fsn.hu/
> http://wiki.hup.hu/
> 
> is unreachable with these kernels. If i try kernel versions
> <= 2.6.7 everything is O.K. above-mentioned all web pages works.
> 
> I try this web pages with some different operating systems
> like Windows, OpenBSD, FreeBSD, WinCe... and seems working
> fine for me.
> 
> Any idea?

Dave enabled the receive buffer auto-tuning which uses TCP window
scaling.  It looks like all these sites are running FreeBSD, perhaps
there is a bug in FreeBSD?

As suggested earlier please get a TCP dump of a failed connection.

To turn of receive buffer auto-tuning:
	sysctl -w net.ipv4.tcp_moderate_rcvbuf=0
	sysctl -w net.ipv4.tcp_default_win_scale=0

Thanks.
