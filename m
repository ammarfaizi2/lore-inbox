Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWFZJAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWFZJAr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 05:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWFZJAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 05:00:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:9289 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751304AbWFZJAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 05:00:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=luleboyqiH0r42FdibYoFpSYU+wYRWWwtlMXY9O7G59isGdScCG3hxxbbCyI9RjXZ9jpsi9TIbPbakd2Y/JvOZ1/Umy5bLb/lPBAAzHSnCXKaYDWcrz58UnX8HnvNK73Metf8exCBnh5qeRAO1wyClOfkoVLWiD/sY9/MamKRUs=
Date: Mon, 26 Jun 2006 11:00:41 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-pm@osdl.org, stern@rowland.harvard.edu
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Message-ID: <20060626090041.GA3686@slug>
References: <20060621221445.GB3798@inferi.kami.home> <20060622061905.GD15834@kroah.com> <20060622004648.f1912e34.akpm@osdl.org> <20060622160403.GB2539@slug> <20060622092506.da2a8bf4.akpm@osdl.org> <20060623090206.GA2234@slug> <20060623091016.GE4940@elf.ucw.cz> <20060623121210.GB2234@slug> <20060623125658.GB8048@elf.ucw.cz> <20060623125706.69dafffd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623125706.69dafffd.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 12:57:06PM -0700, Andrew Morton wrote:
> On Fri, 23 Jun 2006 14:57:01 +0200
> Pavel Machek <pavel@ucw.cz> wrote:
> 
> > > Stack: c0229b71 00000046 00000000 00000286 c0383ca7 f6cb9ecc c013b242 00000003
> > >         00000000 00000003 f6cb9ee0 c013b2e8 00000003 c0436890 f6c9a003 f6cb9f08
> > >         c013b481 00000003 00000003 00000246 c1788b00 00000003 c04368a0 c043692c
> > > Call Trace:
> > >  <c0103eea> show_stack_log_lvl+0x92/0xb7  <c0104100> show_registers+0x1a3/0x21b
> > >  <c0104319> die+0x117/0x230  <c03627a6> do_page_fault+0x39c/0x72a
> > >  <c0103b2f> error_code+0x4f/0x54  <c013b242> suspend_enter+0x2f/0x52
> > >  <c013b2e8> enter_state+0x4b/0x8d  <c013b481> state_store+0xa0/0xa2
> > >  <c01a5151> subsys_attr_store+0x37/0x41  <c01a53d2> flush_write_buffer+0x3c/0x46
> > >  <c01a5443> sysfs_write_file+0x67/0x8b  <c0166bb6> vfs_write+0x1b9/0x1be
> > >  <c0166c7b> sys_write+0x4b/0x75  <c010300f> sysenter_past_esp+0x54/0x75
> > > 
> > > Code: 05 c4 42 43 c0 31 43 43 c0 c3 8b 2d 68 6e 54 c0 8b 1d 60 6e 54 c0 8b 35 6c 6e 54 c0 8b 3d 70 6d 54 c0 ff 35 74 6e 54 c0 9d c3 90 <e8> 6d 38 ea ff e8 a2 ff ff ff 6a 03 e8 ec b6 de ff 83 c4 04 c3
> > > EIP: [c043431c>] do_suspend_lowlevel+0x0/0x15 SS:ESP 0068:f6cb6ea4
> >   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Ha, wait a moment, this is interesting line. Can you trace down which
> > instruction causes this?
> > 
> > We recently changed pagetable handling during swsusp, perhaps thats
> > it? It went to Linus few minutes ago...
> 
> That's a good possibility.  It does appear to be oopsing at the first
> instruction of arch/i386/kernel/acpi/wakeup.S:do_suspend_lowlevel(). 
> Perhaps there's enough info in that oops trace to tell us whether it was
> the instruction fetch which oopsed.
> 
> One wonders whether this will help...
> 
I've tried 2.6.17-git10 which appears to have the fix and the laptop 
suspends correctly. Looks like that was it :).

Thanks,
Frederik
