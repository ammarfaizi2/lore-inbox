Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbTFLAUP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 20:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264632AbTFLAUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 20:20:15 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:15662 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264629AbTFLAUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 20:20:10 -0400
Date: Wed, 11 Jun 2003 17:29:58 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andy Pfiffer <andyp@osdl.org>
Cc: christophe@saout.de, adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: ext[23]/lilo/2.5.{68,69,70} -- blkdev_put() problem?
Message-Id: <20030611172958.5e4d3500.akpm@digeo.com>
In-Reply-To: <1055377253.1222.8.camel@andyp.pdx.osdl.net>
References: <1052507057.15923.31.camel@andyp.pdx.osdl.net>
	<1052510656.6334.8.camel@chtephan.cs.pocnet.net>
	<1052513725.15923.45.camel@andyp.pdx.osdl.net>
	<1055369326.1158.252.camel@andyp.pdx.osdl.net>
	<1055373692.16483.8.camel@chtephan.cs.pocnet.net>
	<1055377253.1222.8.camel@andyp.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jun 2003 00:33:54.0274 (UTC) FILETIME=[4D9C5420:01C3307A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> wrote:
>
> So now the important question: is it wrong to not sync_blockdev() until
> the count drops to 0?

Should be OK.  The close will not sync anything if someone else has the
blockdev open (ie: there's a filesystem mounted there).

But sync() should certainly write everything out, and lilo does perform a
sync.

I'd be interested in seeing the contents of /proc/meminfo immediately after
the lilo run, see if there's any dirty memory left around.

