Return-Path: <linux-kernel-owner+w=401wt.eu-S1422971AbWLUQxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422971AbWLUQxI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 11:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422969AbWLUQxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 11:53:08 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:48521 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422973AbWLUQxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 11:53:06 -0500
Date: Thu, 21 Dec 2006 19:51:43 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: jamal <hadi@cyberus.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take28-resend_1->0 0/8] kevent: Generic event handling mechanism.
Message-ID: <20061221165143.GA322@2ka.mipt.ru>
References: <458A64E5.4050703@garzik.org> <20061221104918.GA16744@2ka.mipt.ru> <1166708885.3749.49.camel@localhost> <20061221140429.GA25214@2ka.mipt.ru> <1166710867.3749.56.camel@localhost> <20061221142337.GA17204@2ka.mipt.ru> <20061221143621.GA32706@2ka.mipt.ru> <1166712026.3749.60.camel@localhost> <20061221144644.GA4735@2ka.mipt.ru> <1166719324.3863.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1166719324.3863.1.camel@localhost>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 21 Dec 2006 19:51:44 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 11:42:04AM -0500, jamal (hadi@cyberus.ca) wrote:
> > > > Things like sockets/pipes can only benefit from direct kevent usage 
> > > > instead of ->poll() and wrappers.
> > > 
> > > You should be able change it to use those schemes when it detects
> > > that the kernel supports them.
> > 
> > I.e. stat() for each new file descriptor - note, that _you_ asked it :)
> 
> Didnt follow. Is there some issue with libevent you mean? 

libevent provides file descriptor without any additional info about it -
so when it is added into the waiting subsystem, userspace must select
different usage cases (i.e. different kevent notifications for different
types of file descriptor - socket notifications for sockets and pipes,
poll/select for all others), this requires stat() call per provided file
descriptor.

Event addition/waiting itself is the same - only parameters (type and
requested event) are changed.

> cheers,
> jamal

-- 
	Evgeniy Polyakov
