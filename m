Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTEDVKr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 17:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbTEDVKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 17:10:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58843 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261743AbTEDVKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 17:10:41 -0400
Date: Sun, 04 May 2003 13:15:58 -0700 (PDT)
Message-Id: <20030504.131558.27788112.davem@redhat.com>
To: hch@lst.de
Cc: trond.myklebust@fys.uio.no, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove useless MOD_{INC,DEC}_USE_COUNT from sunrpc
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030504230010.A12753@lst.de>
References: <16053.25445.434038.90945@charged.uio.no>
	<1052075166.27465.12.camel@rth.ninka.net>
	<20030504230010.A12753@lst.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Christoph Hellwig <hch@lst.de>
   Date: Sun, 4 May 2003 23:00:11 +0200
   
   Oh well, what about something like the following?
 ...   
   +	 */
   +	if (!try_module_get(THIS_MODULE))
   +		return -EBUSY;

Ahem... Why don't we just do this right? :-)

By this I mean provide some real registry thing in the
main kernel image that we can use to do try_module_get()
outside of the sunrpc module?

The other option is the make more progress in the area of
two-stage module unload, and allowing cleanup() to return
whether the module is unloadable or not.  This is being
discussed on netdev so that we have some way to make ipv6
modules work sanely (instead of putting try_module_get() in
every other line, that simply isn't acceptable).

The situation in rxrpc looks worse btw...
