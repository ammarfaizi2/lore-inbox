Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751696AbWHXUDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbWHXUDl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 16:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbWHXUDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 16:03:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48076 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751692AbWHXUDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 16:03:40 -0400
Date: Thu, 24 Aug 2006 21:03:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [take13 1/3] kevent: Core files.
Message-ID: <20060824200322.GA19533@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	lkml <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
	netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
References: <11563322941645@2ka.mipt.ru> <11563322971212@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11563322971212@2ka.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One question on the implementation of kevent_user_ctl_modify/
kevent_user_ctl_remove/kevent_user_ctl_add:  What benchmarks did you
do to add the separate 'fastpath' with the single onstack ukevent
structure if there are three or less events?  I can't believe this
actually helps in practice for various reasons:

 - you add quite a lot of icache footprint by duplicating all this code
 - kmalloc is really fast
 - two or three small copy_from/to_user calls are quite a bit slower
   than one that covers the size of all of them.
