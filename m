Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSIHV4c>; Sun, 8 Sep 2002 17:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSIHV4c>; Sun, 8 Sep 2002 17:56:32 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:31109 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315278AbSIHV4c>;
	Sun, 8 Sep 2002 17:56:32 -0400
Date: Sun, 8 Sep 2002 17:00:04 -0500
From: Amos Waterland <apw@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: pwaechtler@mac.com, golbi@mat.uni.torun.pl, linux-kernel@vger.kernel.org,
       Jakub Jelinek <jakub@redhat.com>, Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] POSIX message queues
Message-ID: <20020908170004.A3257@kvasir.austin.ibm.com>
References: <B547AE30-C26B-11D6-87AD-00039387C942@mac.com> <Pine.LNX.4.44.0209071716460.17119-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209071716460.17119-100000@localhost.localdomain>; from mingo@elte.hu on Sat, Sep 07, 2002 at 05:17:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2002 at 05:17:35PM +0200, Ingo Molnar wrote:
> 
> On Sat, 7 Sep 2002 pwaechtler@mac.com wrote:
> 
> > OTOH I can't see a _big_ problem when a process with sufficient
> > permissions can trash the message queues - otherwise I wonder why file
> > permissions are granted "per user" and not "per process".
> 
> yes - furthermore, processes from the same user can 'trash' queues anyway,
> via ptrace() or mmaping /proc.

That is correct, but it is not the issue though.  The issue is that
completely unrelated processes can spoof/destroy each other's messages.

If a queue is set up with mq_open(name, O_CREAT|O_RDWR, S_IWOTH, &attr),
the process which set it up expects that "others" (processes not owned
by the user or by users in his/her group) will be able to send, and only
send, messages.  If shared memory is used, "others" must be able to
update the data structures representing the queue, so they will be able
to do a lot more than just send.

The fundamental problem is that filesystem permissions do not map
cleanly to message queue permissions.  Does this make sense?  Thanks.

Amos Waterland
