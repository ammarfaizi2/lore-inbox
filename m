Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271745AbRICQ26>; Mon, 3 Sep 2001 12:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271747AbRICQ2r>; Mon, 3 Sep 2001 12:28:47 -0400
Received: from t2.redhat.com ([199.183.24.243]:4598 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S271745AbRICQ2f>; Mon, 3 Sep 2001 12:28:35 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <m3zo8cp93a.fsf@belphigor.mcnaught.org> 
In-Reply-To: <m3zo8cp93a.fsf@belphigor.mcnaught.org>  <01090310483100.26387@faldara> 
To: Doug McNaught <doug@wireboard.com>
Cc: psusi@cfl.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [bug report] NFS and uninterruptable wait states 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Sep 2001 17:28:32 +0100
Message-ID: <32526.999534512@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


doug@wireboard.com said:
>  NFS does this (wait in D state) by default in order to prevent naive
> applications from getting timeout errors that they're not equipped to
> handle--the idea being that, if an NFS server goes down, programs
> using it will simply freeze and recover once it returns, rather than
> getting a timeout error and possibly becoming confused. 

Timeouts are a completely separate issue, surely? Applications ought to be 
able to deal with getting a _signal_ during a system call, whatever happens.

IMO, sleeping in state TASK_UNINTERRUPTIBLE in any situation where you can't
prove that the wakeup _will_ happen and will happen _soon_ should be
considered a bug - it's almost always just because someone hasn't bothered
to implement the cleanup code required for dealing with being interrupted.

/me tries to work out why anyone would ever want filesystem accesses to be 
uninterruptible.

--
dwmw2


