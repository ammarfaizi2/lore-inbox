Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUFGRB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUFGRB3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 13:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264939AbUFGRB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 13:01:29 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:17280 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264937AbUFGRB1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 13:01:27 -0400
Subject: Re: [BUG] NFS no longer updates file modification times
	appropriately
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: joe.korty@ccur.com
Cc: linux-kernel@vger.kernel.org, Ronny.Lampert@telecasystems.de,
       ioe-lkml@rameria.de
In-Reply-To: <1086627207.4597.4.camel@lade.trondhjem.org>
References: <1086625209.4597.0.camel@lade.trondhjem.org>
	 <20040607163920.GB22505@tsunami.ccur.com>
	 <1086627207.4597.4.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1086627686.4597.10.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 07 Jun 2004 13:01:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På må , 07/06/2004 klokka 12:53, skreiv Trond Myklebust:
> > 
> > Compatibility with existing behavior.  It's called a de-facto standard.
> 
> The "de-facto standard" you describe has never existed other than for
> large files. It was never true of small files that did not trigger
> immediate writeout.

...in fact even for files that trigger immediate writeout, the behaviour
was erratic, since writes could still be cached after the
memory-triggered flush was completed.

So I repeat: There has *never* been a standard other than the
close-to-open.

There has *never* existed any reliable mtime/ctime while the client was
caching writes.

If you want that sort of behaviour, the options are O_SYNC, fsync(),
close(), or "mount -osync". There is no call for it in async writes.

