Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261441AbSJHXdk>; Tue, 8 Oct 2002 19:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263214AbSJHXT7>; Tue, 8 Oct 2002 19:19:59 -0400
Received: from ns.suse.de ([213.95.15.193]:3603 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261518AbSJHXTW>;
	Tue, 8 Oct 2002 19:19:22 -0400
To: "Steven French" <sfrench@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Waking up kernel thread blocked in sock_recvmsg
References: <OF622E0CD7.34DDBCD6-ON87256C4C.007D935A@boulder.ibm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 09 Oct 2002 01:25:03 +0200
In-Reply-To: "Steven French"'s message of "9 Oct 2002 01:14:35 +0200"
Message-ID: <p734rbwqzsg.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Steven French" <sfrench@us.ibm.com> writes:

> What is the recommended, safe way to wake up a kernel thread blocked in
> sock_recvmsg (other than sending data to it or pulling the network cable
> out of the wall and generating network errors).   I have tried various
> approaches in kernel sock_close, sock_release even wake_up_process.    When
> I want to free my captive kernel threads this thread is typically blocked
> in tcp_recv_data (on a blocking read of a tcp v4 socket).  I am not certain
> that it is not waking up and promptly going back to sleep but it is
> certainly not returning to the caller until it really gets data.

You could send it a signal. 

Or alternatively use non blocking sockets and sleep yourself on the socket
wait queue.

-Andi
