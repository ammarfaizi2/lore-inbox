Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269322AbUJFQH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269322AbUJFQH7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 12:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269325AbUJFQH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 12:07:58 -0400
Received: from chaos.analogic.com ([204.178.40.224]:6016 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S269322AbUJFQH4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 12:07:56 -0400
Date: Wed, 6 Oct 2004 12:07:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "David S. Miller" <davem@davemloft.net>
cc: Chris Friesen <cfriesen@nortelnetworks.com>, joris@eljakim.nl,
       linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
In-Reply-To: <20041006084128.38e9970d.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0410061158050.3236@chaos.analogic.com>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl>
 <20041006080104.76f862e6.davem@davemloft.net> <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
 <20041006082145.7b765385.davem@davemloft.net> <41640FE2.3080704@nortelnetworks.com>
 <20041006084128.38e9970d.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004, David S. Miller wrote:

> On Wed, 06 Oct 2004 09:31:46 -0600
> Chris Friesen <cfriesen@nortelnetworks.com> wrote:
>
>> David S. Miller wrote:
>>
>>> So if select returns true, and another one of your threads
>>> reads all the data from the file descriptor, what would you
>>> like the behavior to be for the current thread when it calls
>>> read?
>>
>> What about the single-threaded case?
>
> Incorrect UDP checksums could cause the read data to
> be discarded.  We do the copy into userspace and checksum
> computation in parallel.  This is totally legal and we've
> been doing it since 2.4.x first got released.
>
> Use non-blocking sockets with select()/poll() and be happy.

Gawd. This is damn awful. How could this possibly be justified?
You can't have a system call that lies. We already have an OS
that does that. Certainly, no other Unix OS in the past has
thrown away integrity with such aplomb. Next, in the interest
of "performance", you'll probably only occasionally provide
file-data, as well.

You can't do this. When there is some well-defined procedure
such as select() or poll(), that is designed to provide a
reliable way of knowing that a read will succeed, you or
anybody else don't have the authority to declare that it's
not important to actually have it work.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

