Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbUEJTiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUEJTiQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 15:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUEJTiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 15:38:16 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:55443 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261416AbUEJTiG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 15:38:06 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 May 2004 12:37:48 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Andi Kleen <ak@muc.de>
cc: Fabiano Ramos <ramos_fabiano@yahoo.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ptrace in 2.6.5
In-Reply-To: <m365b4kth8.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.58.0405101236200.1156@bigblue.dev.mdolabs.com>
References: <1UlcA-6lq-9@gated-at.bofh.it> <m365b4kth8.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004, Andi Kleen wrote:

> Fabiano Ramos <ramos_fabiano@yahoo.com.br> writes:
> 
> > Hi All.
> >
> >      Is ptrace(), in singlestep mode, required to stop after a int 0x80?
> >     When tracing a sequence like
> >
> > 	mov ...
> > 	int 0x80
> > 	mov ....
> >
> >     ptrace would notify the tracer after the two movs, but not after the
> > int 0x80. I want to know if it is a bug or the expected behaviour.
> 
> What happens is that after the int 0x80 the CPU is in ring 0 (you
> don't get an trace event in that mode unless you use a kernel debugger). 
> Then when the kernel returns the last instruction executed before it is an 
> IRET. But the IRET is also executed still in ring 0 and you should not get 
> an event for it (you can not even access its code from user space).
> 
> So it's expected behaviour.

IIRC, it's the "int" instruction that automatically clears the TF bit from 
flags. The next "iret" will restore the caller flags and re-enable the TF bit.



- Davide

