Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbUCEOHa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 09:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbUCEOHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 09:07:30 -0500
Received: from mikonos.cyclades.com.br ([200.230.227.67]:56338 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S262595AbUCEOH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 09:07:28 -0500
Date: Fri, 5 Mar 2004 11:06:02 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@dmt.cyclades
To: Daniel Fenert <daniel@fenert.net>
cc: linux-kernel@vger.kernel.org, <sct@redhat.com>,
       Michelle Konzack <linux4michelle@freenet.de>
Subject: Re: Is there some bug in ext3 in 2.4.25?
In-Reply-To: <20040304065038.GV31185@fenert.net>
Message-ID: <Pine.LNX.4.44.0403051048160.2678-100000@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This sounds like memory corruption (which could be caused by a misbehaving
driver or by flaky hardware) because transaction->t_ilist is not used at
all by the kernel code. Did this box run stable with other kernels?

I found a similar report from Michelle (CCed), which can be found at:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107529754608448&w=2

Searching a bit more, I found another message from Michelle with 
topic "[SOLVED] Kernel-Bug (at checkpoint.c 587)"
http://lists.debian.org/debian-user-german/2004/debian-user-german-200401/msg04404.html

Unfortunately the said message is in German, which I can't understand. 
Michelle, can you clarify it for me?

Stephen, Andrew, any idea how can transaction->t_ilist become not NULL?


On Thu, 4 Mar 2004, Daniel Fenert wrote:

> Message from syslogd@lazy at Thu Mar  4 08:31:58 2004 ...
> lazy kernel: Assertion failure in __journal_drop_transaction() at
> checkpoint.c:587: "transaction->t_ilist == NULL"
> 
> Networking still works, I've tried to login, but no luck here.
> I've got one ssh console opened, and tried to reboot, but nothing happend, it
> looks like it lost connection with hda :(
> Where should I look for reason?
> Machine as faaar away, and it's second or third time it hangs mysteriously,
> the only difference is that this time I've got some console output.
> 

>From daniel@fenert.net Fri Mar  5 10:48:26 2004
Date: Thu, 4 Mar 2004 08:03:29 +0100
From: Daniel Fenert <daniel@fenert.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Is there some bug in ext3 in 2.4.25?

>Message from syslogd@lazy at Thu Mar  4 08:31:58 2004 ...
>lazy kernel: Assertion failure in __journal_drop_transaction() at
>checkpoint.c:587: "transaction->t_ilist == NULL"

One more thing - it has happened when /var got full.


