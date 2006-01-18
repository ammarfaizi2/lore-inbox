Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWARHip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWARHip (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 02:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWARHio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 02:38:44 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:48608 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1030297AbWARHin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 02:38:43 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 17 Jan 2006 23:38:36 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@localhost.localdomain
To: Ulrich Drepper <drepper@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] pepoll_wait ...
In-Reply-To: <43CDC21C.7050608@redhat.com>
Message-ID: <Pine.LNX.4.63.0601172337550.4942@localhost.localdomain>
References: <Pine.LNX.4.63.0601171933400.15529@localhost.localdomain>
 <43CDC21C.7050608@redhat.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2006, Ulrich Drepper wrote:

> Davide Libenzi wrote:
>> The attached patch implements the pepoll_wait system call, that extend
>> the event wait mechanism with the same logic ppoll and pselect do. The
>> definition of pepoll_wait is: [...]
>
> I definitely ACK this patch, it's needed for the same reasons we need
> pselect and ppoll.
>
>
>> +	if (error == -EINTR) {
>> +		if (sigmask) {
>> +			memcpy(&current->saved_sigmask, &sigsaved, sizeof(sigsaved));
>> +			set_thread_flag(TIF_RESTORE_SIGMASK);
>> +		}
>> +	} else if (sigmask)
>> +		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
>
> This part I'd clean up a bit, though.  Move the if (sigmask) test to the
> top and have the EINTR test decide what to do.  As is the code would be
> a bit irritating if it wouldn't be so trivial.  The important thing is
> that you only do something special if sigmask != NULL.

Agreed.


- Davide


