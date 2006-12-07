Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032383AbWLGQgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032383AbWLGQgQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 11:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032390AbWLGQgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 11:36:16 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41487 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032383AbWLGQgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 11:36:15 -0500
Date: Thu, 7 Dec 2006 08:35:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: David Miller <davem@davemloft.net>, viro@zeniv.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: cmpxchg() in kernel/workqueue.c breaks things
Message-Id: <20061207083558.a25ebc19.akpm@osdl.org>
In-Reply-To: <23292.1165491984@redhat.com>
References: <20061207032817.e9e587bd.akpm@osdl.org>
	<20061207.000950.28414823.davem@davemloft.net>
	<10380.1165489429@redhat.com>
	<23292.1165491984@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Dec 2006 11:46:24 +0000
David Howells <dhowells@redhat.com> wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> 
> > I don't see why the 2.6.19 logic needed changing.
> > 
> > a) Nobody should be freeing the work_struct itself without running
> >    flush_scheduled_work() and
> > 
> > b) even if the work_struct _did_ get freed, the callback function won't
> >    care, because there's nothing in that work_struct which it's interested
> >    in.
> 
> Erm...  Did you mean that in reply to my suggestion that we don't need to use
> cmpxchg()?

I was referring to the core logic change in run-workqueue():

		if (!test_bit(WORK_STRUCT_NOAUTOREL, &work->management))
			work_release(work);
		f(work);


