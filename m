Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWCRBFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWCRBFF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 20:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWCRBFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 20:05:05 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:52409 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751034AbWCRBFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 20:05:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ELUEgnQ1BxJw9ySmJQluNEla4KedoZg/Uls2aWUy0wq4kOKAmmVDrEbqypAEQnFRk80iIjQDYFchwlUw2nAbxFTUglVVtskm+cX0+bcm7P9gIC484usnsXJu2VwpV+ZhgUNnulRQqTlxxpG3/WrTM2OzUh9fl2UZ03cdxz9Q0+I=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] kernel BUG at drivers/block/loop.c:621
Date: Sat, 18 Mar 2006 02:04:55 +0100
User-Agent: KMail/1.8.3
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
References: <200603171912.12082.rob@landley.net> <200603180124.19077.blaisorblade@yahoo.it> <200603171955.38138.rob@landley.net>
In-Reply-To: <200603171955.38138.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603180204.56562.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 March 2006 01:55, Rob Landley wrote:
> On Friday 17 March 2006 7:24 pm, Blaisorblade wrote:
> > On Saturday 18 March 2006 01:12, Rob Landley wrote:
> > > I can reproduce the following in 2.6.16-rc5, User Mode Linux:
> > >
> > > kernel BUG at drivers/block/loop.c:621!
> > > Kernel panic - not syncing: BUG!
> > >
> > > EIP: 0073:[<ffffe410>] CPU: 0 Not tainted ESP: 007b:b7de1f9c EFLAGS:
> > > 00200246 Not tainted
> > > EAX: 00000000 EBX: 000018be ECX: 00000013 EDX: 000018be
> > > ESI: 000018bb EDI: 00000011 EBP: b7de1fb8 DS: 007b ES: 007b
> > > 09b87bb4:  [<0806c762>] show_regs+0x102/0x110
> > > 09b87bd0:  [<0805b6fc>] panic_exit+0x2c/0x50
> > > 09b87be0:  [<0807ff7d>] notifier_call_chain+0x2d/0x50
> > > 09b87c00:  [<08071095>] panic+0x75/0x120
> > > 09b87c20:  [<0812e181>] loop_thread+0x151/0x160
> > > 09b87c4c:  [<08065297>] run_kernel_thread+0x37/0x60
> > > 09b87cfc:  [<0805bbd1>] new_thread_handler+0x9 1/0xc0
> >
> > The below is strange - GCC is putting disks in the .text section or
> > kallsyms has some bug.
> >
> > > 09b87d20:  [<ffffe420>] disks+0xf7e7ec84/0x4
>
> Isn't ffffe??? the FASTCALL page?

Sorry, didn't mention that according to ctags, disks is defined only as a 
struct member or as a static variable... clearly neither is valid on a call 
stack.

The call trace decoder filters out hex values outside _stext - _etext, but 
maybe it also considers valid the FASTCALL page... leading to this 
interesting bogus output :-)

> Haven't tried.  I value my laptop. :)

> My host is running unbuntu 2.6.12, and my mount test requires a clean
> environment with nothing else mounted when it first runs.  (It basically
> needs to run as PID 1.  Among other things, it synthesizes variants of its
> own fstab...)

> I don't think it's a uml bug, but I cc'd the UML list because that's where
> I can easily reproduce it.

Ok - didn't notice the LKML cc, sorry (it's really late).

> Rob

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com
