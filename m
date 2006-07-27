Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWG0VAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWG0VAr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWG0VAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:00:15 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:15772 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751056AbWG0VAJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:00:09 -0400
Subject: Re: [3/4] kevent: AIO, aio_sendfile() implementation.
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Zach Brown <zach.brown@oracle.com>,
       =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
In-Reply-To: <44C90987.1040200@redhat.com>
References: <1153905495613@2ka.mipt.ru> <11539054952574@2ka.mipt.ru>
	 <20060726100431.GA7518@infradead.org> <20060726101919.GB2715@2ka.mipt.ru>
	 <20060726103001.GA10139@infradead.org> <44C77C23.7000803@redhat.com>
	 <44C796C3.9030404@us.ibm.com> <1153982954.3887.9.camel@frecb000686>
	 <44C8DB80.6030007@us.ibm.com>  <44C9029A.4090705@oracle.com>
	 <1154024943.29920.3.camel@dyn9047017100.beaverton.ibm.com>
	 <44C90987.1040200@redhat.com>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 14:02:44 -0700
Message-Id: <1154034164.29920.22.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-27 at 11:44 -0700, Ulrich Drepper wrote:
> Badari Pulavarty wrote:
> > Before we spend too much time cleaning up and merging into mainline -
> > I would like an agreement that what we add is good enough for glibc
> > POSIX AIO.
> 
> I haven't seen a description of the interface so far.  Would be good if
> it existed.  But I briefly mentioned one quirk in the interface about
> which Suparna wasn't sure whether it's implemented/implementable in the
> current interface.

Sebastien, could you provide a description of interfaces you are
adding ? Since you did all the work, it would be appropriate for
you to do it :)

> If a lio_listio call is made the individual requests are handle just as
> if they'd be issue separately.  I.e., the notification specified in the
> individual aiocb is performed when the specific request is done.  Then,
> once all requests are done, another notification is made, this time
> controlled by the sigevent parameter if lio_listio.
> 
> 
> Another feature which I always wanted: the current lio_listio call
> returns in blocking mode only if all requests are done.  In non-blocking
> mode it returns immediately and the program needs to poll the aiocbs.
> What is needed is something in the middle.  For instance, if multiple
> read requests are issued the program might be able to start working as
> soon as one request is satisfied.  I.e., a call similar to lio_listio
> would be nice which also takes another parameter specifying how many of
> the NENT aiocbs have to finish before the call returns.

Looks reasonable.

Thanks,
Badari

