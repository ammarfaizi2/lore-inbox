Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264301AbUENKkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264301AbUENKkl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 06:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265192AbUENKkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 06:40:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20377 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264301AbUENKkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 06:40:39 -0400
Date: Fri, 14 May 2004 06:40:12 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Martijn Sipkema <m.j.w.sipkema@student.tudelft.nl>
Cc: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>
Subject: Re: POSIX message queues should not allocate memory on send
Message-ID: <20040514104012.GE30909@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <000701c4399e$88a3aae0$161b14ac@boromir> <20040514095145.GC30909@devserv.devel.redhat.com> <000601c439a3$f793af40$161b14ac@boromir>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000601c439a3$f793af40$161b14ac@boromir>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 12:09:46PM +0100, Martijn Sipkema wrote:
> You are correct; defaults are indeed needed. The current default value
> for mq_msgsize seems rather large considering that mq_msgsize*mq_maxmsg
> bytes will have to be allocated on queue creation. If variable sized large
> payload messages are needed one might consider using shared memory in
> combination with a message queue.
> 
> My main point was that mq_send()/mq_timedsend() may not return ENOMEM
> and I am positive I did not misread the standard on that.

Even that is not clear.
http://www.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_03.html#tag_02_03
"   Implementations may support additional errors not included in this list,
    may generate errors included in this list under circumstances other than
    those described here, or may contain extensions or limitations that
    prevent some errors from occurring.  The ERRORS section on each
    reference page specifies whether an error shall be returned, or whether
    it may be returned.  Implementations shall not generate a different error
    number from the ones described here for error conditions described in
    this volume of IEEE Std 1003.1-2001, but may generate additional errors
    unless explicitly disallowed for a particular function."

Explicitely disallowed in the general section is only EINTR for the THR
option functions unless explitely listed for that function and nothing else.

I don't see ENOMEM explicitly forbidden for mq_send/mq_timedsend nor
any wording in mq_open description which would require the buffers to
be preallocated.

	Jakub
