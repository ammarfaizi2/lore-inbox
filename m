Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318207AbSG3EWa>; Tue, 30 Jul 2002 00:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318211AbSG3EW3>; Tue, 30 Jul 2002 00:22:29 -0400
Received: from ns.suse.de ([213.95.15.193]:14605 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318207AbSG3EW3>;
	Tue, 30 Jul 2002 00:22:29 -0400
Date: Tue, 30 Jul 2002 06:25:52 +0200
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Muli Ben-Yehuda <mulix@actcom.co.il>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: rename 'unused' in sys_iopl to somethign else, since it is used
Message-ID: <20020730062552.A922@wotan.suse.de>
References: <20020728141256.GA9573@alhambra.actcom.co.il> <20020730011859.96E0B4276@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020730011859.96E0B4276@lists.samba.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 11:02:33AM +1000, Rusty Russell wrote:
> In message <20020728141256.GA9573@alhambra.actcom.co.il> you write:
> > sys_iopl on i386 accepts one parameter, 'unsigned long unused'. Then
> > it goes ahead and uses it to get a pointer to struct pt_regs. This
> > patch changes its name to 'location'.=20
> 
> Hmmm.... Andi, the x86_64 version is different: do you really push one
> arg on the stack then the regs?  Please check...

level is in a register (rdi), but pt_regs is on the stack. The calling 
convention automatically switches to stack location for structures bigger 
than one register.  

On i386 it is probably cleanest when you need both pt_regs and arguments
to declare pt_regs only and get the first argument directly out of regs->ebx.


-Andi
