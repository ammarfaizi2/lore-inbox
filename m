Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262268AbSI3RXk>; Mon, 30 Sep 2002 13:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262336AbSI3RXk>; Mon, 30 Sep 2002 13:23:40 -0400
Received: from [198.149.18.6] ([198.149.18.6]:23464 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262268AbSI3RXk>;
	Mon, 30 Sep 2002 13:23:40 -0400
Date: Mon, 30 Sep 2002 20:43:20 -0400
From: Christoph Hellwig <hch@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: lord@sgi.com, Arjan van de Ven <arjanv@redhat.com>, cw@f00f.org,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
Message-ID: <20020930204320.A21715@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	Ingo Molnar <mingo@elte.hu>, lord@sgi.com,
	Arjan van de Ven <arjanv@redhat.com>, cw@f00f.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <20020930194529.A15138@sgi.com> <Pine.LNX.4.44.0209301911180.21901-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209301911180.21901-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Sep 30, 2002 at 07:12:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 07:12:54PM +0200, Ingo Molnar wrote:
> > Not exactly.  All your work on one queue is internally serialize.  An
> > totally unserialized workqueue would be best for XFS.
> 
> you can create as many queues as you wish - one per CPU for example. Or
> one per mounted fs per CPU.

Yeah.  But adding a create_workqueue_per_cpu that has one queue and thead
per cpu to which queue_work dispatches would centralize the code needed
to manage that in one place instead of duplicating it over and over.

Sure both works, but IMHO hiding it behind a nice abstraction is much
better.

