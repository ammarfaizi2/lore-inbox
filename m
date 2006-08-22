Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWHVM1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWHVM1z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 08:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWHVM1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 08:27:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39078 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751221AbWHVM1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 08:27:54 -0400
Date: Tue, 22 Aug 2006 13:27:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [PATCH] kevent_user: remove non-chardev interface
Message-ID: <20060822122731.GA2994@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	lkml <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
	netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
References: <12345678912345.GA1898@2ka.mipt.ru> <11561555871530@2ka.mipt.ru> <20060822115459.GA10839@infradead.org> <20060822121709.GA4815@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822121709.GA4815@2ka.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 04:17:10PM +0400, Evgeniy Polyakov wrote:
> I personally do not have objections against it, but it introduces
> additional complexies - one needs to open /dev/kevent and then perform
> syscalls on top of returuned file descriptor.

it disalllows

int fd = sys_kevent_ctl(<random>, KEVENT_CTL_INIT, <random>, <random>);

in favour of only

int fd = open("/dev/kevent", O_SOMETHING);

which doesn't seem like a problem, especially as I really badly hope
no one will use the syscalls but some library instead.

In addition to that I'm researching whether there's a better way to
implement the other functionality instead of the two syscalls.  But I'd
rather let code speak, so wait for some patches from me on that.

