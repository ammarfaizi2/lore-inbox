Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265201AbUENJwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbUENJwP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 05:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbUENJwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 05:52:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53633 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265138AbUENJwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 05:52:03 -0400
Date: Fri, 14 May 2004 05:51:45 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Martijn Sipkema <m.j.w.sipkema@student.tudelft.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: POSIX message queues should not allocate memory on send
Message-ID: <20040514095145.GC30909@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <000701c4399e$88a3aae0$161b14ac@boromir>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000701c4399e$88a3aae0$161b14ac@boromir>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 11:30:53AM +0100, Martijn Sipkema wrote:
> The default mq_msgsize also seems a little large to me, but
> I don't see why defaults are needed; if I understand the standard
> correctly then creating a new message queue without mq_attr
> should create an empty queue, which thus cannot be used to
> pass messages.

No idea where you found this.

"If attr is NULL, the message queue shall be created with
implementation-defined default message queue attributes."

Empty queue means a message queue which has no messages in it, not
that mq_msgsize and/or mq_maxmsg is 0.
And mq_open with mq_msgsize 0 and/or mq_maxmsg 0 must fail (with EINVAL),
so the implementation-defined defaults IMHO must be > 0 for both
limits.

"     The mq_open() function shall fail if:"
...
"     [EINVAL]
             O_CREAT was specified in oflag, the value of attr is not NULL,
	     and either mq_maxmsg or mq_msgsize was less than or equal to zero."

	Jakub
