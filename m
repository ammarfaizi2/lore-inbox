Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271817AbRH1Qye>; Tue, 28 Aug 2001 12:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271821AbRH1Qy0>; Tue, 28 Aug 2001 12:54:26 -0400
Received: from ns.suse.de ([213.95.15.193]:30990 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271817AbRH1QyK>;
	Tue, 28 Aug 2001 12:54:10 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, bgerst@didntduck.org, haba@pdc.kth.se
Subject: Re: Size of pointers in sys_call_table?
In-Reply-To: <3B8B9C00.4842710D@didntduck.org.suse.lists.linux.kernel> <E15blYK-0006Fb-00@the-village.bc.nu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Aug 2001 18:54:06 +0200
In-Reply-To: Alan Cox's message of "28 Aug 2001 18:19:47 +0200"
Message-ID: <oupd75gjfbl.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > The layout of the sys_call_table is totally architecture dependant.  The
> > question to ask here is why do you need to use it?  Modifying it to hook
> > into syscalls is frowned upon.
> 
> And potentially unsafe (think about caching, and non atomic writes on
> some platforms)

It is ATM impossible to make a module that patches sys_call_table safe against
module unload races. The only way is to put a stub into the main kernel
that manages the module counters and calls a separate hook (i.e. as done 
by nfsd's syscall) 

[Introducing quiescent states in module unloading would probably fix that,
as it has been discussed for a long time now, but I lost hope that it'll ever
get implemented in the main kernel]

Other than that on some weird architectures like IA64 it can get quite 
complicated to patch the syscall table.

-Andi

